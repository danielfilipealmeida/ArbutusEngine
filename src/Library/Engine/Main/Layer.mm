/*
 *  Layer.mm
 *  VJingApp
 *
 *  Created by Daniel Almeida on 12/24/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#include "Layer.h"
#include "Engine.h"
#include "Utils.h"
#include <string>

extern Engine *enginePtr;



Layer::Layer(bool _loadShaders) {
	buffer = NULL;
	activeInstance = NULL;
    schedulledInstance = NULL;
    
    if (_loadShaders == true) {
        loadShaders();
    }
    
    initBuffer();
}


Layer::~Layer() {
	destroyBuffer();
}



void Layer::loadShaders() {
    loadShadersFromOSXBundle();
}

void Layer::loadShadersFromOSXBundle() {
    string bundlePath;
    NSBundle *bundle;
    NSString *vertShaderNSPath, *fragShaderNSPath;
    string vertShaderPath, fragShaderPath;
   
    bundle     = [NSBundle mainBundle];
    bundlePath = [[bundle bundlePath] UTF8String];
    
    if (!ofFile::doesFileExist(bundlePath)) throw new std::runtime_error("Bundle path doesn't exist");
    
    vertShaderNSPath = [bundle pathForResource:@"layerShader" ofType:@"vert"];
    fragShaderNSPath = [bundle pathForResource:@"layerShader" ofType:@"frag"];
    
    if (vertShaderNSPath == nil) throw new std::runtime_error("Vert shader path doesn't exist");
    if (fragShaderNSPath == nil) throw new std::runtime_error("Frag shader path doesn't exist");
    
    vertShaderPath = [vertShaderNSPath UTF8String];
    fragShaderPath = [fragShaderNSPath UTF8String];
    
    shader.load(vertShaderPath, fragShaderPath);
}



void Layer::render() {
    
	if (buffer==NULL) initBuffer();
	if (this->activeInstance==NULL) return;
	buffer->begin();
	
	// turn on shader and configure
	this->shader.begin();
	this->shader.setUniform1f("blurH", this->properties.getBlurH());
	this->shader.setUniform1f("blurV", this->properties.getBlurV());
	this->shader.setUniform1f("brightness", this->properties.getBrightness());
	this->shader.setUniform1f("contrast", this->properties.getContrast());
	this->shader.setUniform1f("saturation", this->properties.getSaturation());
	this->shader.setUniform1f("redTint", this->properties.getRed());
	this->shader.setUniform1f("greenTint", this->properties.getGreen());
	this->shader.setUniform1f("blueTint", this->properties.getBlue());
	
	//ofClear(0, 0, 0, properties.alpha / 255.0);
    
    unsigned int width, height;
    width   = (unsigned int) buffer->getWidth();
    height  = (unsigned int) buffer->getHeight();
    
	ofEnableAlphaBlending();
	ofSetColor(255, 255, 255, 255 * activeInstance->getProperties()->getAlpha());
	activeInstance->draw(0, 0, width, height);

    
	ofDisableAlphaBlending();
	// turn off shader
	shader.end();

	this->buffer->end();
    
    
    
    
    
    
	
	// check for active free frame filters in this layer
#ifdef _FREEFRAMEFILTER_H_
    unsigned int activeFreeFrameFilters;
    
	activeFreeFrameFilters = false;
	if (freeFrameInstanceList.size()>0) {
		for(
            FreeFrameFilterInstanceListIterator it = freeFrameInstanceList.begin();
            it< freeFrameInstanceList.end();
            it++
        ) {
			FreeFrameFilterInstance *instance = *it;
			if (instance->filter->active == true) {
				activeFreeFrameFilters = true;
				
				unsigned int pluginNumber = instance->filter->number;
				engine.freeFrameHost.ffHost.setPluginActive(pluginNumber, true);
			}
			
		}
	}
	
	if (activeFreeFrameFilters==true) {
		// process freeframe if turned on
		ofPixels pixels;
		buffer->readToPixels(pixels);
		_engine.freeFrameHost.ffHost.loadData(pixels.getPixels(), properties.width, properties.height, GL_RGBA);
		//app->engine.freeFrameHost.ffHost.setPluginActive(2, true);
		_engine.freeFrameHost.ffHost.process();
		buffer->begin();
		_engine.freeFrameHost.ffHost.draw(0, 0, properties.width, properties.height);
	 
		buffer->end();
	
	
		// turn them off
		for(FreeFrameFilterInstanceListIterator it = freeFrameInstanceList.begin();it< freeFrameInstanceList.end();it++) {
			FreeFrameFilterInstance *instance = *it;
			if (instance->filter->active == true) {
				unsigned int pluginNumber = instance->filter->number;
				//instance->host->ffHost.setPluginActive(pluginNumber, false);
				app->engine.freeFrameHost.ffHost.setPluginActive(pluginNumber, false);
			}
			
		}
		
	}
#endif
	
}


void Layer::draw(int x, int y, int width, int height) {
	if (buffer == NULL)         return;
	if (activeInstance == NULL) return;
	
	buffer->draw(x, y, width, height);
}



string
Layer::label() {
    string label;

    label = "Layer " + ofToString(layerNumber+1) + "|";
    label = label + LayerProperties::blendModeToString(properties.getBlendMode());
    label = label + "|" + ofToString((int)(properties.getAlpha() * 100))+"%";
    
    return label;
}


void Layer::print() {
	//cout << "Layer number: "<< layerNumber<<endl;
	properties.print();
}

void Layer::initBuffer(){
	if (buffer==NULL) {
		buffer = new ofFbo();
		buffer->allocate(properties.getWidth(), properties.getHeight());
		
		// clear the fbo
		buffer->begin();
		ofClear(0, 0, 0, 0);
		buffer->end();
	}
}

void Layer::destroyBuffer() {
	if (buffer!=NULL) 	{
		delete buffer;
		buffer = NULL;
	}
}

/* ************************************************************************** */

#pragma mark video instances


void Layer::setActiveVisualInstance(VisualInstance *_activeInstance) {
	activeInstance = _activeInstance;
    schedulledInstance = NULL;
}

void
Layer::stopActiveVisualInstance() {
	activeInstance = NULL;
}

void Layer::stop() {
    VisualInstance *playingInstance = getActiveVisualInstance();
    if (playingInstance==NULL) return;
    playingInstance->stop();
    activeInstance = NULL;
    schedulledInstance = NULL;
}


void
Layer::schedulleInstance(VisualInstance *_instance) {
    schedulledInstance = _instance;
}



void
Layer::activateSchedulledInstance() {
    if (schedulledInstance==NULL) return;
    if(activeInstance!=NULL && activeInstance->video.isPlaying()) activeInstance->stop();
    activeInstance = schedulledInstance;
    schedulledInstance = NULL;
    
    activeInstance->play(true);
    activeInstance->video.setFrame(0);
}



void
Layer::playVisualInstance(
                          VisualInstance *newInstance
) {
    VisualInstancesProperties *properties = newInstance->getProperties();
    
        // if snap is on and beat detection is on
    if (properties->getBeatSnap ()  == true &&
        EngineProperties::getInstance().isMetronomeOn()    == true &&
        EngineProperties::getInstance().isTriggeringBeat() != true
        ) {
        schedulleInstance(newInstance);
        return;
    }

    if (newInstance!=activeInstance) {
        if (activeInstance!=NULL) {
            activeInstance->stop();
        }
        setActiveVisualInstance(newInstance);
        newInstance->play();
        
    }
    if ( properties->getRetrigger() == true ) newInstance->retrigger();
    
}



ofTexture* Layer::getTexture() {
    return &buffer->getTextureReference();
    //return NULL;
}

///////////////////////////////////////////////////////////////////////////

#pragma mark Free Frame Functions
#ifdef _FREEFRAMEFILTER_H_

void
Layer::addFreeFrameInstance(unsigned int instanceSlotNumber) {
	// get the free frame from the host
	FreeFrameFilter *filter = app->engine.freeFrameHost.getFilter(instanceSlotNumber);
	if (filter == NULL) return;
	
	// create an instance
	FreeFrameFilterInstance *freeFrameInstance = new FreeFrameFilterInstance(&(app->engine.freeFrameHost), filter);
	
	// add it to the list
	freeFrameInstanceList.push_back(freeFrameInstance);
}



void
Layer::removeFreeFrameInstance(unsigned int instanceSlotNumber) {
	if (instanceSlotNumber >= freeFrameInstanceList.size()) return;
	freeFrameInstanceList.erase(freeFrameInstanceList.begin()+instanceSlotNumber);
}



FreeFrameFilterInstance*
Layer::getFilterInstance(unsigned int instanceSlotNumber) {
	if (instanceSlotNumber >= freeFrameInstanceList.size()) return NULL;
	return freeFrameInstanceList[instanceSlotNumber];
}



#endif




#pragma mark Actions

void
Layer::handleAction(
                    string parameter,
                    json data
                    ) {
    
    float value;
    //cout << data.dump() << endl;
    value = data["value"].get<float>();
    
    switch (str2int(parameter.c_str())) {
        case str2int("Alpha"):
            properties.setAlpha(value);
            break;

        case str2int("Brightness"):
            properties.setBrightness(value);
            break;
            

        case str2int("Contrast"):
            properties.setContrast(value);
            break;
            
        case str2int("Saturation"):
            properties.setSaturation(value);
            break;

        case str2int("Red"):
            properties.setRed(value);
            break;
            
        case str2int("Green"):
            properties.setGreen(value);
            break;

        case str2int("Blue"):
            properties.setBlue(value);
            break;

        case str2int("Blur"):
            properties.setBlurH(value);
            properties.setBlurV(value);
            break;

        case str2int("Horizontal Blur"):
            properties.setBlurH(value);
            break;

        case str2int("Vertical Blur"):
            properties.setBlurV(value);
            break;


        default:
            break;
    }
}


json Layer::getState() {
    json state;

    state = properties.getState();
    
    return state;
}


/*
 {
 "alpha": 1,
 "brightness": 1,
 "contrast": 1,
 "name": "",
 "saturation": 1,

 }
*/
void Layer::setState(json state) {
    //std::fixed; std::setprecision(2);
    unsigned int precision = 2;
    
    if (state["width"].is_number()) {
        properties.setWidth(state["width"].get<int>());
    }
    if (state["height"].is_number()) {
        properties.setHeight(state["height"].get<int>());
    }
    if (state["blendMode"].is_number()) {
        properties.setBlendMode((BlendMode) state["blendMode"].get<int>());
    }
    if (state["blurH"].is_number()) {
        properties.setBlurH((BlendMode) state["blurH"].get<int>());
    }
    if (state["blurV"].is_number()) {
        properties.setBlurV((BlendMode) state["blurV"].get<int>());
    }

    if (state["red"].is_number()) {
        properties.setRed(roundWithPrecision(state["red"].get<float>(), precision));
    }

    if (state["green"].is_number()) {
        properties.setGreen(roundWithPrecision(state["green"].get<float>(), precision));
    }

    if (state["blue"].is_number()) {
        properties.setBlue(state["blue"].get<float>());
    }

    if (state["alpha"].is_number()) {
        properties.setAlpha(state["alpha"].get<float>());
    }

    if (state["brightness"].is_number()) {
        properties.setBrightness(state["brightness"].get<float>());
    }

    if (state["contrast"].is_number()) {
        properties.setContrast(state["contrast"].get<float>());
    }

    if (state["saturation"].is_number()) {
        properties.setSaturation(state["saturation"].get<float>());
    }

    if (state["name"].is_string()) {
        properties.setName(state["name"].get<string>());
    }

   
}

#pragma mark Layers Implementation

Layers& Layers::getInstance() {
    static Layers instance;
    
    return instance;
}


Layer* Layers::add(bool _loadShaders) {
    Layer *newLayer;
    
    if (layersList.size() == MAXIMUM_NUMBER_OF_LAYERS) {
        return NULL;
    }
    
    newLayer = new Layer(_loadShaders);
    newLayer->setLayerNumber(layersList.size()+1);
    addToList(newLayer);
    
    return newLayer;
}


void Layers::addToList(Layer *newLayer) {
    layersList.push_back(newLayer);
}



void
Layers::empty() {
    while (!layersList.empty()) {
        layersList.pop_front();
    }
    EngineProperties::getInstance().setSelectedLayerNumber(0);
}



void
Layers::remove(unsigned int layerN) {
    unsigned int layerSize;
    
    if (layerN>layersList.size()) return;
    
    LayersListIterator i;
    i = layersList.begin();
    for (int f=0;
         f < layerN;
         f++
         ) {
        ++i;
    }
    
    i = layersList.erase(i);
    layerSize = (unsigned int) layersList.size();
    if (EngineProperties::getInstance().getSelectedLayerNumber() >= layerSize) {
        setActive(layerSize);
    }
}


Layer* Layers::get(unsigned int layerN) {
   	if (layerN >= layersList.size()) return NULL;
    
    LayersListIterator i = layersList.begin();
    std::advance(i, layerN);
    return *i;
}



Layer* Layers::getCurrent() {
    return get(EngineProperties::getInstance().getSelectedLayerNumber());
}

unsigned int Layers::getCurrentId() {
    return EngineProperties::getInstance().getSelectedLayerNumber();
}

Layer* Layers::getSelected() {
    return get(EngineProperties::getInstance().getSelectedLayerNumber());
}

void Layers::setActive (unsigned int activeLayer) {
    unsigned int layerSize;
    
    if (activeLayer == 0) {
        return;
    }
    
    layerSize = layersList.size();
    if ( activeLayer > layerSize ) {
        activeLayer = layerSize;
    }
    EngineProperties::getInstance().setSelectedLayerNumber(activeLayer - 1);

}

int Layers::count() {
    return layersList.size();
}

void Layers::setCount (unsigned int _val) {
    unsigned int currentNumberOfLayers;
    
    currentNumberOfLayers = count();
    
    if (_val == currentNumberOfLayers) return;
    
    if (_val > currentNumberOfLayers) {
        for (unsigned int i = 0; i < _val-currentNumberOfLayers; i++) {
            this->add();
        }
    }
    else {
        for (unsigned int i = _val-1; i < currentNumberOfLayers; i++) {
            this->remove(i);
        }
    }
}

LayersList Layers::getList() {
    return layersList;
}


json Layers::getState() {
    json state;
    
    for(auto layer:layersList) {
        state.push_back(layer->getState());
    }
    
    return state;
}

json Layers::getFullState() {
    json state;
    
    for(auto layer:layersList) {
        state.push_back(layer->getProperties()->getFullState());
    }
    
    return state;
}

void Layers::setState(json state) {
    empty();
    
    for (auto& layer : state) {
        Layer *newLayer = add();
        newLayer->setState(layer);
    }
    
}




void Layers::stopAt(unsigned int position){
    Layer *layer;
    
    layer = get(position);
    if (layer == NULL) return;
    
    layer->stop();
}


void Layers::stopAll() {
    for(auto layer:layersList) {
        layer->stop();
    }

}


void Layers::activateFirst()
{
    setActive(1);
}

void Layers::activatePrevious()
{
    unsigned int currentId = getCurrentId();
    
    setActive(currentId);
}


void Layers::activateNext()
{
    setActive(getCurrentId() + 2);
}

void Layers::activateLast()
{
    setActive(count());
}
