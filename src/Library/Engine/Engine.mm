    /*
 *  Engine.mm
 *  VJingApp
 *
 *  Created by Daniel Almeida on 12/13/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#include "Engine.h"
#include "AppProtocol.h"
#include <string>
#include "Utils.h"
#include "SetFile.hpp"


#ifdef app
extern AppProtocol *app;
#endif

Engine *enginePtr = NULL;


#pragma mark Init Methods

void Engine::setDefaults() {
    layersPreview_Columns = 3;
    buffer = NULL;
    setOpened = false;
}

void Engine::setupSyphon() {

 }


Engine::Engine() {
    cout << "### Engine Started" <<endl;
    if (enginePtr != NULL) {
        cout << "### Found dangling Engine!" << endl;
        delete enginePtr;
    }
    enginePtr = this;
    osc = NULL;

    setDefaults();
    
	// init the free frame filters
#ifdef _FREEFRAMEFILTER_H_
	freeFrameHost.init(mixerWidth, mixerHeight);
#endif
    
    controllers.initDefaultControllers();

    // midi & osc tests
    /*
    Midi::list();
    Midi *midi = new Midi(0);
    osc = new Osc(1234);
     */
    
    setupSyphon();
    
    // this needs to only work on osx
    setAppSupportDir(ofFilePath::getUserHomeDir().append("/Library/Application Support/Arbutus"));
    ofSetDataPathRoot("./");
    
}

Engine::~Engine() {
	destroyBuffer();
    Scenes::getInstance().empty();
    Visuals::getInstance().empty();
    Layers::getInstance().empty();
    
    // clean visual lists
    
    enginePtr = NULL;
    cout << "### Engine Destroyed" <<endl;
}


Engine* Engine::getInstance() {
    return enginePtr;
}

/* ************************************************************************ */


#pragma mark State Handling

json Engine::getState() {
    json state;
    
    state["visuals"] = Visuals::getInstance().getState();
    state["layers"] = Layers::getInstance().getState();
    state["scenes"] = Set::getInstance().getScenesState();
    
    return state;
}



void Engine::setState(json state) {
    if (state["visuals"].is_array()) {
        Visuals::getInstance().setState(state["visuals"]);
    }
    if (state["layers"].is_array()) {
        Layers::getInstance().setState(state["layers"]);
    }
    if (state["scenes"].is_array()) {
        Scenes::getInstance().setState(state["scenes"]);
    }
}



// TODO: move this to the Layers class
/*
json Engine::getLayersState() {
    json state;
    
    for(auto layer:Layers::getInstance().getList()) {
        state.push_back(layer->getState());
    }
    return state;
}
 */

/* ************************************************************************ */
#pragma mark File Management





bool
Engine::newSet(unsigned int _width, unsigned int _height, unsigned int _layers)
{
	closeSet();
    if (_width>0)
    {
        EngineProperties::getInstance().setMixerWidth(_width);
    }
    if (_height>0)
    {
        EngineProperties::getInstance().setMixerHeight(_height);
    }
    if (_layers>0)
    {
        EngineProperties::getInstance().setNumberOfLayers(_layers);
    };
	Set::getInstance().newSet(_width, _height, _layers);
    initBuffer();
    Layers::getInstance().setActive(1);
    EngineProperties::getInstance().setCurrentFilePath("");
    setOpened = true;
    
    return true;
}



void
Engine::closeSet() {
    if (Set::getInstance().isLoaded() == false) return;
    
    Layers::getInstance().empty();
	Set::getInstance().closeSet();

    setOpened = false;
    EngineProperties::getInstance().setCurrentFilePath("");
}




bool
Engine::openSet(string _setPath) {
    bool result;
    
    destroyBuffer();
    closeSet();
	Layers::getInstance().empty();
	
    result = Set::getInstance().openSet(_setPath);
    if (!result) return result;

    initBuffer();
    Layers::getInstance().setActive(1);
    
	EngineProperties::getInstance().setCurrentFilePath(_setPath);
    
    setOpened = true;
    
    return result;
}


bool Engine::saveSet() {
	Set::getInstance().saveSet();
    
    return true;
}

bool Engine::saveSetAs(string _setPath) {
   Set::getInstance().saveSetAs(_setPath);
    EngineProperties::getInstance().setCurrentFilePath(_setPath);
    
    return true;
}



#pragma mark Actions Handling



Layer*
Engine::getLayerForActionHandler (json data) {
    Layer *layer;
    
    if (!data["layer"].is_number()) {
        layer = Layers::getInstance().getCurrent();
    }
    else {
        layer = Layers::getInstance().get(data["layer"].get<int>());
    }

    return layer;
}


void
Engine::handleLayerAction(
                          string parameter,
                          json data
                          )
{
    Layer *layer;
    
    layer = this->getLayerForActionHandler(data);
    
    if (layer != NULL) {
        layer->handleAction(parameter, data);
    }

}


void
Engine::handleVisualAction(
                          string parameter,
                          json data
                          )
{
    Layer *layer;
    VisualInstance *visual;
    
     layer = this->getLayerForActionHandler(data);
    if (layer == NULL) return;
    
    visual = layer->getActiveInstance();
    
    if (visual != NULL) {
        visual->handleAction(parameter, data);
    }
    //visual =
}


/*
TODO:
 adicionar um modo que pode ser channel ou visual
*/
void
Engine::handleAction(
                     string parameter,
                     json data
) {
    
    
    switch (str2int(parameter.c_str())) {
        case str2int("Layer Alpha"):
        case str2int("Layer Brightness"):
        case str2int("Layer Contrast"):
        case str2int("Layer Saturation"):
        case str2int("Layer Red"):
        case str2int("Layer Green"):
        case str2int("Layer Blue"):
        case str2int("Layer Blur"):
        case str2int("Layer Horizontal Blur"):
        case str2int("Layer Vertical Blur"):
    
            ofStringReplace(parameter, "Layer ", "");
            handleLayerAction(parameter, data);
            break;
        
        case str2int("Visual Alpha"):
        case str2int("Visual Brightness"):
        case str2int("Visual Contrast"):
        case str2int("Visual Saturation"):
        case str2int("Visual Red"):
        case str2int("Visual Green"):
        case str2int("Visual Blue"):
        case str2int("Visual Zoom X"):
        case str2int("Visual Zoom Y"):
        case str2int("Visual Center X"):
        case str2int("Visual Center Y"):
        case str2int("Visual Start"):
        case str2int("Visual End"):
        case str2int("Visual Played"):
        case str2int("Visual Loop Mode"):
        case str2int("Visual Direction"):
            ofStringReplace(parameter, "Visual ", "");
            handleVisualAction(parameter, data);
            
            
            break;
            
        /*
        default:
            break;
         */
    }
    
}



#pragma mark Put somewhere better



void
Engine::setMixerResolution(
                           unsigned int width,
                           unsigned int height
                           ) {
    destroyBuffer();

    EngineProperties::getInstance().setMixerWidth(width);
    EngineProperties::getInstance().setMixerHeight(height);
 
    initBuffer();

    for (auto layer:Layers::getInstance().getList()) {
        if (layer == NULL) continue;
        
        LayerProperties *layerProperties = layer->getProperties();
        layerProperties->setWidth(width);
        layerProperties->setHeight(height);
        layer->destroyBuffer();
        layer->initBuffer();
    }
}



/* ************************************************************************* */
#pragma mark Visual Management

VisualInstance* Engine::setActiveVisualInstance(unsigned int layerN, unsigned int column)
{
    Layer *layer;
    VisualInstance *visualInstance = NULL;
    
    layer = Layers::getInstance().get(layerN);
	if (layer == NULL) return NULL;
		
	visualInstance = Set::getInstance().getVisualInstanceInCorrentSet(layerN, column);
    
 	
	if (visualInstance!=NULL) {
        /// WHAT IS ALL THIS???? WHAT IS IT DOING. sending the one really playing?
        layer->playVisualInstance(visualInstance);
   }
    else {
        if (setProperties.getStopCurrentVisualIfTriggeredInvalid() == YES) {
            Layers::getInstance().stopAt(layerN);
        }
    }
    
    return visualInstance;
}


void Engine::play(json data) {
    unsigned int layer, column;
    
    if (!data.is_object()) throw "data must be an object";
    if (!data["layer"].is_number()) throw "Layer not set";
    layer = data["layer"].get<unsigned int>();
    
    if (!data["column"].is_number()) throw "column not set";
    column = data["column"].get<unsigned int>();
    
    VisualInstance *visualInstance = setActiveVisualInstance(layer, column);
    //VisualInstance *visualInstance = getCurrentActiveVisualInstance();
    if (visualInstance==NULL) throw "Invalid visual instance";
    visualInstance->play();
}


void Engine::stop(json data) {
    if (
        data.is_object() &&
        data["layer"].is_number()
        )
    {
        Layers::getInstance().stopAt(data["layer"].get<unsigned int>());
    }
    else {
        Layers::getInstance().stopAll();
    }
}


void Engine::setActiveVisualIntances(unsigned int columnN) {
    for (
         int layer = 0;
         layer < Layers::getInstance().getList().size();
         layer++
    ) {
		this->setActiveVisualInstance(layer, columnN);
	}
}



void Engine::setActiveVisualIntanceOnActiveLayer(unsigned int visualInstanceN) {
	setActiveVisualInstance(EngineProperties::getInstance().getSelectedLayerNumber(), visualInstanceN);
}


VisualInstance* Engine::getCurrentActiveVisualInstance(){
    return getVisualAtLayerAndInstanceN(
                                        EngineProperties::getInstance().getSelectedLayerNumber(),
                                        EngineProperties::getInstance().getSelectedColumnNumber()
                                        );
}


VisualInstance*
Engine::getVisualAtLayerAndInstanceN(
                                     unsigned int layerN,
                                     unsigned int visualInstanceN
) {
    Scene *currentScene;

    currentScene = getCurrentScene();
    if (currentScene == NULL) return NULL;
    return currentScene->visualInstances.get(visualInstanceN, layerN);
}


/* ************************************************************************** */
#pragma mark debug



void
Engine::printInfo() {
	cout << "********************************************************************************"<<endl;
	cout << "** Engine Debug Print *********************************************** [start] **"<<endl;
	cout << "********************************************************************************"<<endl;
	cout << "mixerWidth: " << EngineProperties::getInstance().getMixerWidth() << endl;
	cout << "mixerHeight: " << EngineProperties::getInstance().getMixerHeight() << endl;
	cout << "Set object address: "<<&Set::getInstance()<<endl;
	cout << endl;
	cout << "** Layers **********************************************************************"<<endl;
	cout << "number of layers: " << Layers::getInstance().getList().size()<<endl;
	int count = 1;
	for (LayersListIterator i = Layers::getInstance().getList().begin();
         i != Layers::getInstance().getList().end();
         i++
         ){
		Layer *layer = (*i);
		cout << endl;
		cout << "LAYER "<<count<<":"<<endl;
		layer->print();
		count++;
	}
	cout << endl;
	Set::getInstance().print();

	cout << "********************************************************************************"<<endl;
	cout << "** Engine Debug Print ************************************************* [end] **"<<endl;
	cout << "********************************************************************************"<<endl;
	cout << endl;
}



void Engine::saveCurrentFrame(string path) {
    ofPixels pixels;

    buffer->readToPixels(pixels);
    ofSaveImage(pixels, path);
}

/* ************************************************************************** */
#pragma mark Scene & Visuals



Scene*
Engine::addScene() {
    return Set::getInstance().newScene();
}


void
Engine::addVisualToSceneListInCurrentLayer(
                                           unsigned int visual,
                                           unsigned int layer,
                                           unsigned int column
                                           )
{
	Visual *visualToAdd = Visuals::getInstance().get(visual);
	
    if (visualToAdd == NULL)  return;
    
    if (layer <= 0) {
        layer = EngineProperties::getInstance().getSelectedLayerNumber();
    }
    if (layer > Layers::getInstance().count()) {
        layer =  Layers::getInstance().count();
    }
        
    Set::getInstance().getCurrentScene()->visualInstances.add(visualToAdd, layer, column);
}



void Engine::addVisualToScene(unsigned int visual, unsigned int layer, unsigned int column) {
    Visual *visualToAdd = Visuals::getInstance().get(visual);
    
    if (visualToAdd != NULL) {
            // check if the current layer exists. if not, add it and all before
        if (layer > Set::getInstance().getNumberOfLayers() ) {
            for (int i = Layers::getInstance().count(); i <= layer; i++) {
                Layers::getInstance().add();
            }
        }
        
        Set::getInstance().getCurrentScene()->visualInstances.add(visualToAdd, layer, column);
    }
}


void Engine::removeVisualFromScene(unsigned int layer, unsigned int column) {
    Scene *currentScene;
    
    currentScene = getCurrentScene();
    
    if (
        layer == EngineProperties::getInstance().getSelectedLayerNumber() &&
        column == EngineProperties::getInstance().getSelectedColumnNumber()
        ) {
        Layers::getInstance().stopAt(layer);
    }
    
    //VisualInstances::getInstance().remove(layer, column);
    currentScene->visualInstances.remove(layer, column);
}


Scene *Engine::getCurrentScene() {
    return Set::getInstance().getCurrentScene();
}

Scene *Engine::getSceneAtIndex(unsigned int index) {
    return Scenes::getInstance().get(index);
    //return Set::getInstance().getSceneAtIndex(index);
}

unsigned int Engine::getNumberOfVisuals() {
    return Visuals::getInstance().count();
}

Visual* Engine::getVisualAtIndex(unsigned int index) {
    return Visuals::getInstance().get(index);
}



/*!
 Traverse all the inputs, check if they are syphon inputs, check if the servername and appname are the samse
 **/
bool
Engine::isSyphonInputLoaded(
                            string serverName,
                            string appName
) {
    return (getSyphonInput(serverName, appName)!=NULL) ? true:false;
}



VisualSyphon*
Engine::getSyphonInput(
                       string serverName,
                       string appName
) {
    unsigned int nVisuals;
    
    nVisuals = getNumberOfVisuals();
    for(int index = 0; index < nVisuals; index++) {
        Visual *visual = getVisualAtIndex(index);
        if (visual->getType() == VisualType_Syphon) {
            if (
                serverName.compare(((VisualSyphon *)visual)->getServerName()) == 0 &&
                appName.compare(((VisualSyphon *)visual)->getAppName()) == 0
                
                ) return (VisualSyphon *)visual;
        }
    }
    return NULL;

}


/* ************************************************************************** */
#pragma mark Render & Draw

void Engine::render(){
    
    // Protections
    //  - must have layers
    //  - must have bugger alloced
    if (Layers::getInstance().getList().empty()== true) return;
    if (buffer == NULL) return;
    
    if (osc != NULL) osc->update();
    
    if (EngineProperties::getInstance().isBeatSnapInProgress()) {
        triggerSchedulledVisualsOnAllLayers();
        EngineProperties::getInstance().setIsBeatSnapInProgress(false);
    }

	
	// render each layer - transform into a private method
    unsigned int layerCount = 0;
    for (auto layer:Layers::getInstance().getList()) {
		layer->render();
        if (layerCount < N_SYPHON_CHANNEL_OUTPUTS) {
            syphonOutputManager.publishChannelOutputScreen(layerCount, layer->getTexture());
        }
        layerCount++;
	}
	
	// draw each layer on the engine buffer
	buffer->begin();
	ofClear(0, 0, 0, 0);
	ofEnableAlphaBlending();

    for (auto layer:Layers::getInstance().getList()) {
        if (layer!=NULL) {
			ofSetColor(255, 255, 255, (int) (layer->getProperties()->getAlpha() * 255.0));
			ofEnableBlendMode((ofBlendMode) layer->getProperties()->getBlendMode());
			layer->draw(
                        0,
                        0,
                        EngineProperties::getInstance().getMixerWidth(),
                        EngineProperties::getInstance().getMixerHeight()
                        );
            ofDisableBlendMode();
		}
	}
	ofDisableAlphaBlending();

	buffer->end();
    
    // send the main output syphon
    syphonOutputManager.publishMainOutputScreen(&this->buffer->getTextureReference());
}





void Engine::drawOutput(int x, int y, int width, int height)
{
    if (buffer==NULL) return;
    
    width = (width == 0) ? ofGetWidth() - x : width;
    height = (height == 0)  ? ofGetHeight() - y : height;
    
    /*
    if (width == 0) {
        width = ofGetWidth() - x;
    }
    if (height == 0) {
        height = ofGetHeight() - y;
    }
     */
	buffer->draw(x, y, width, height);
}


void Engine::drawLayer(int layerNumber, int x, int y, int width, int height)
{
    Layer *layer;
    
    if (layerNumber<=1) {
        return;
    }
    layer = Layers::getInstance().get(layerNumber);
	layer->draw(x,y,width, height);
}


// TODO: move to another class. this is for display purposes
void Engine::drawOutputPreview(int x, int y, int width, int height) {
	ofSetColor(255, 255, 255);
	drawOutput(x, y,width, height);
}




void
Engine::drawLayersPreview(
                          int x,
                          int y,
                          int width,
                          int maxNumLayers
 ) {
    unsigned int count, layerPreviewWidth, layerPreviewHeight, x1, y1, layersToDraw;
	float        resizeAmount;
    
    
    
    count              = 0;
    layersToDraw       = (unsigned int) Layers::getInstance().count();
    layerPreviewWidth  = (int) floor((float) width / (float) this->layersPreview_Columns);
    resizeAmount       = EngineProperties::getInstance().getMixerWidth() / layerPreviewWidth;
    layerPreviewHeight = EngineProperties::getInstance().getMixerHeight() / resizeAmount;
    
    x1 = x;
    y1 = y;

    if (layersToDraw > maxNumLayers) {
        layersToDraw = maxNumLayers;
    }
    
	for (
         unsigned int f = 0;
         f < layersToDraw;
         f++
    ) {
        Layer     *layer;
        string    label;
        
        layer = Layers::getInstance().get(f+1);
        
		ofSetColor(255, 255, 255);
		layer->draw(x1, y1, layerPreviewWidth, layerPreviewHeight);
		ofEnableAlphaBlending();
		ofSetColor(0, 0, 0,128);
		ofFill();
		ofRect(x1, y1, layerPreviewWidth, 16);
		ofSetColor(0, 0, 0,0);
		ofDisableAlphaBlending();
	
        label = layer->label();
        
        ofSetColor(255, 255, 255);
		
		// check if f is odd
		if (((f+1) % layersPreview_Columns) == 0) {
			x1 = x;
			y1 = y1 + layerPreviewHeight;
		} else {
			x1 = x1+layerPreviewWidth;
		}
		
	}
}



/* ************************************************************************** */
#pragma mark beats and metronome functions

void
Engine::beat() {
    EngineProperties::getInstance().beat();
    
    // TODO run something from the main app probably set a callback for the beat
    appBeatCallback();
}


void Engine::triggerSchedulledVisualsOnAllLayers() {
    /*
    for (LayersListIterator i = layersList.begin();i!=layersList.end(); i++){
        Layer *layer = (*i);
       */
    for (auto layer:Layers::getInstance().getList()) {
        if (layer->getSchedulledInstance () == NULL) {
            VisualInstance *instance = layer->getActiveInstance ();
            
            
            if (instance != NULL)  {
                if (instance->getProperties()->getBeatSnap () == true && instance->getProperties()->getIsTriggered () == true ) {
                    if (instance->video.isPlaying()) {
                            //instance->video.setFrame(0);
                        instance->video.firstFrame();
                    }
                    instance->play(true);
                   
                }
            }
            
            
        }
        else {
            layer->activateSchedulledInstance();
        }
        
        
    }

}

void Engine::startMetronome(){
 	metronomeThreadObj.start();
    EngineProperties::getInstance().setMetronomeOn(true);
}

void Engine::stopMetronome(){
	metronomeThreadObj.stop();
    EngineProperties::getInstance().setMetronomeOn(false);
}


void Engine::resetMetronome() {
    metronomeThreadObj.resetMetronome();
}


void
Engine::tap() {
    unsigned int newBPM;
    
    newBPM = EngineProperties::getInstance().tap();
    
    if (newBPM) setBPM(newBPM);
    
    setBPM((unsigned int) round(newBPM));
    /*
    unsigned long long elapsedTime = ofGetElapsedTimeMillis();
 
    engineProperties.incrementTap();
    
    
    taps[currentTapIndex] = elapsedTime;
    
   

    // calculate bpm
    if (currentTapIndex == 3) {
        unsigned long  long a, b, c;
        float newBpm;
        a = taps[1] - taps[0];
        b = taps[2] - taps[1];
        c = taps[3] - taps[2];
        
        //printf("%3llu %3llu %3llu \n", a,b,c);
        
        // eesta formula está errada
        newBpm = (((float)(a+b+c) / 3.0 ));
        newBpm = (60000.0 / (float) (newBpm));
        setBPM((unsigned int) round(newBpm));
        //cout << "\nbpm - "<<newBpm;
        
        // reset
        currentTapIndex=-1;
    }
     */
}


unsigned int Engine::getCurrentBeat() {
    return metronomeThreadObj.getBeatCount();
}

void Engine::setBPM(unsigned int newBPM) {
    
    
    Boolean metroOn = metronomeThreadObj.getBPM();
    if (metroOn) {
        metronomeThreadObj.stop();
        metronomeThreadObj.waitForThread();
    }
    metronomeThreadObj.setBPM(newBPM);
    if (metroOn) metronomeThreadObj.start();
    
    
}


unsigned int Engine::getBPM() {
    return metronomeThreadObj.getBPM();
}


/* ************************************************************************** */
#pragma mark buffer

void Engine::initBuffer() {
    if (buffer!=NULL) return;
    
    buffer = new ofFbo();
    buffer->allocate(
                     EngineProperties::getInstance().getMixerWidth(),
                     EngineProperties::getInstance().getMixerHeight()
                    );
		
    // clear the fbo
    buffer->begin();
    ofClear(0, 0, 0, 0);
    buffer->end();
	
}

void Engine::destroyBuffer() {
	if (buffer!=NULL) 	{
		delete buffer;
		buffer = NULL;
	}
}


/* ************************************************************************** */

#pragma mark input handling. mouse/keys
void Engine::keyPressed(int key) {
    controllers.handleKeyboardControllers(key);
}

void Engine::keyReleased(int key){
}

void Engine::mouseMoved(int x, int y ){
}

void Engine::mouseDragged(int x, int y, int button){
}

void Engine::mousePressed(int x, int y, int button){
}

void Engine::mouseReleased(int x, int y, int button){
}




/* ************************************************************************ */
#pragma mark Cameras Functions


void
Engine::scanCameras() {
    ofVideoGrabber vidGrabber;
    vector<ofVideoDevice> devices;
    
    devices = vidGrabber.listDevices();
    for (
        int i = 0;
        i < devices.size();
        i++)
    {
		cout << devices[i].id << ": " << devices[i].deviceName;
        if( devices[i].bAvailable ) {
            cout << endl;
        }
        else
        {
            cout << " - unavailable " << endl;
        }
	}
    
    
}





#pragma mark cleanup

void Engine::cleanup() {
    Set::getInstance().cleanup();
}


/* ************************************************************************ */

#pragma mark midi functions




void Engine::changeMidiPort(int port) {
    Midi *currentMidiObj = Midi::getMidiInstance();
    if (currentMidiObj != NULL) {
        delete currentMidiObj;
    }
    //if (port>0) Midi *midi = new Midi(port-1);
}

void Engine::changeOscPort(int port) {
    Osc *currentOscObj = Osc::getOscInstance();
    if (currentOscObj != NULL) {
        delete currentOscObj;
    }
    try {
        osc = new Osc(port);
    }
    catch (int error) {
        cout << "error connecting to OSC server " << error<<endl;
    }
    
}


/* ************************************************************************ */

#pragma mark parameters setters and getters






/*************************************************************/

#pragma mark controllers handling

void Engine::visualsKeysControlCallback(Controller *controller) {
    enginePtr->setActiveVisualIntanceOnActiveLayer(controller->getValue());
}

/*************************************************************/
    
#pragma mark other stuff

void Engine::setAppSupportDir(string _dir) {
    EngineProperties::getInstance().setAppSupportDir(_dir);
}

string
Engine::calculateThumbnailPath(string path) {
    string md5FileName = Utils::md5(ofFilePath::getFileName(path));

    return EngineProperties::getInstance().getAppSupportDir() + "/cache/thumbnails/" + md5FileName + ".jpg";
    
}


#pragma mark App Callback Registration

void Engine::registerAppBeatCallback(void (*callback)(void)) {
    appBeatCallback = callback;
}


