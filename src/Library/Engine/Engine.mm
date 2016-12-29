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


extern AppProtocol *app;
Engine      *_engine;
//extern CocoaHandler *cocoaHandler;



void Engine::setDefaults() {
    mixerWidth=640;
    mixerHeight=480;
    layersPreview_Columns = 3;
    mixerNLayers = 3;
    beatsToSnap = 4;
    
}



Engine::Engine() {
    if (_engine != NULL) return;
    
    _engine         = this;
	currentFilePath = "";
    buffer          = NULL;
    setOpened       = false;
    runMode         = PLAY_MODE;
    
    
    setDefaults();
    
	
    beatSnapInProgress = false;
    
    fileManagerThreadObj.start();
	
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
    
    
    // setup some syphon outputs. this is temporary. needs to be controlled by the user and stored on the file
    syphonOutputManager.setMainOutputActive(true);
    syphonOutputManager.setSyphonMainOutput("Main Output");
    for (unsigned int i=0;i<4;i++) {
        syphonOutputManager.setChannelOutputActive(i, true);
        syphonOutputManager.setSyphonChannelOutput(i, "Channel " + ofToString(i+1));
    }
}

Engine::~Engine() {
	destroyBuffer();
}




/* ************************************************************************ */
#pragma mark File Management





bool Engine::newSet(unsigned int _width, unsigned int _height, unsigned int _layers){
	closeSet();
	if (_width>0) mixerWidth = _width;
	if (_height>0) mixerHeight = _height; 
	if (_layers>0) mixerNLayers = _layers;
	currentSet.newSet(mixerWidth, mixerHeight, mixerNLayers);
	setActiveLayer(1);
    
    return true;
}

void Engine::closeSet() {
	//currentSet.emptyVisualsList(); // ? porque foi retirado
	removeAllLayers();
	currentVisualInstance = NULL;
	currentSet.closeSet();
	setOpened = false;
    currentFilePath = "";
}



/**
 *  Open a set
 *
 *  @param _setPath the path to the file to open
 *
 *  @return open success value. boolean
 */
bool Engine::openSet(string _setPath) {
    destroyBuffer();
  	if (currentSet.isLoaded() == true) closeSet();
	removeAllLayers();
	bool result = currentSet.openSet(_setPath);
    if (!result) return result;

    initBuffer();
    setActiveLayer(1);
	currentFilePath = _setPath;
    setOpened = true;
    return result;
}

bool Engine::saveSet() {
	currentSet.saveSet();
    
    return true;
}

bool Engine::saveSetAs(string _setPath) {
	currentSet.saveSetAs(_setPath);
    currentFilePath = _setPath;
    
    return true;
    //[cocoaHandler updatePreferences];
}


void Engine::setMixerResolution(unsigned int width, unsigned int height) {
    destroyBuffer();
    
    mixerWidth = width;
    mixerHeight = height;
    
    initBuffer();
    
    /* restart all the layers */
    /*
     LayersListIterator i;
     i = layersList.begin();
     for (int f=0;f<layerN;f++) {
     ++i;
     }
     */
    for (LayersListIterator i = layersList.begin();i!=layersList.end(); i++){
        Layer *layer = (*i);
        
        LayerProperties *layerProperties = layer->getProperties();
        
        layerProperties->setWidth(width);
        layerProperties->setHeight(height);
        layer->destroyBuffer();
        layer->initBuffer();
    }
}




/* ************************************************************************* */
#pragma mark Layer Management

Layer *Engine::addLayer() {
	if (layersList.size() ==MAXIMUM_NUMBER_OF_LAYERS) return NULL;
	
	Layer *newLayer;
	
	
	newLayer = new Layer();
	newLayer->setLayerNumber(layersList.size()+1);
	addLayerToList(newLayer);
    
    return newLayer;
}


void Engine::addLayerToList(Layer *newLayer){
	layersList.push_back(newLayer);
}

void Engine::removeAllLayers() {
	// get the number of layers
	/*
	unsigned int totalNumberOfLayers;
	totalNumberOfLayers = layersList.size();
	for (int f=0;f<totalNumberOfLayers;f++) {
			layersList.pop
	}
	 */
	while (!layersList.empty()){
		layersList.pop_front();
	}
	
	selectedLayer=0;
}

void Engine::removeLayer(unsigned int layerN) {
	if (layerN>layersList.size()) return;
    
    // remove all instances in that layer
    
    
    // move into the layer
	LayersListIterator i;
	i = layersList.begin();
	for (int f=0;f<layerN;f++) {
		++i;
	}
    
    // remove the layer
	i=layersList.erase(i);
    
    // set the new selected layer
    unsigned int layerSize =layersList.size();
	//if (selectedLayer>=layerSize) selectedLayer = layerSize-1;
    if (selectedLayer>=layerSize) setActiveLayer(layerSize);
}


Layer *Engine::getLayer(unsigned int layerN) {
	// check if the layer exist
	unsigned int layerNumber = layersList.size();
	if (layerN>=layerNumber) return NULL;
	
	LayersListIterator i = layersList.begin();
	std::advance(i, layerN);
	return *i;
}


void Engine::setActiveVisualInstanceNumberForLayer(unsigned int column, unsigned int layerN) {
    Layer           *layer;
    VisualInstance  *visualInstance;
    
    layer = getLayer(layerN);
	if (layer == NULL) return;
		
	
	// get the selected visual Instance for the current scene
	visualInstance = NULL;
	visualInstance = currentSet.getVisualInstanceInCorrentSet(column, layerN);
    
 	
	if(visualInstance!=NULL) {
        //selectedLayer = layerN;
        layer->playVisualInstance(visualInstance);
        currentVisualInstance = layer->getActiveVisualInstance();
        
        if (currentVisualInstance != NULL) {
            selectedColumn = currentVisualInstance->getProperties()->getColumn();
        }
	}
    else {
        if (currentVisualInstance != NULL && properties.getStopCurrentVisualIfTriggeredInvalid() == YES) {
            stopVisualAtLayer(layerN);
        }
    }
}

void Engine::setActiveVisualIntancesOnAllLayers(unsigned int columnN) {
	/*
	for (LayersListIterator i = layersList.begin(); i!=layersList.end();i++){
		Layer *layer = (*i);
		
		// get visual instance with the desired conditions
		layer->setActiveVisualInstance(columnN);
	}
	 */
	for (int f=0;f<layersList.size();f++) {
		this->setActiveVisualInstanceNumberForLayer(columnN, f);
	}
}


void Engine:: setActiveVisualIntanceOnActiveLayer(unsigned int visualInstanceN) {
	setActiveVisualInstanceNumberForLayer(visualInstanceN, selectedLayer);
}


VisualInstance* Engine::getCurrentActiveVisualInstance(){
	// get the current layer
    
    /*
	Layer *currentLayer = getLayer(selectedLayer);
	currentVisualInstance = currentLayer->activeInstance;
	return currentLayer->activeInstance;
	*/
        //return currentVisualInstance;
    return getVisualAtLayerAndInstanceN(selectedLayer, selectedColumn);
}


VisualInstance *Engine::getVisualAtLayerAndInstanceN(unsigned int layerN, unsigned int visualInstanceN) {
    Scene *currentScene = getCurrentScene();
    if (currentScene == NULL) return NULL;
    return currentScene->getVisualInstance(visualInstanceN, layerN);

}


void Engine::stopVisualAtSelectedLayer() {
    stopVisualAtLayer(selectedLayer);
}



void Engine::stopVisualAtLayer(unsigned int layerN) {
    Layer           *layer;
    VisualInstance  *playingInstance;
    
    layer = getLayer(layerN);
    if (layer == NULL) return;
    
    // get the current playing instance and stop it
    playingInstance = layer->getActiveVisualInstance();
    if (playingInstance==NULL) return;
    playingInstance->stop();
    layer->setActiveVisualInstance(NULL);
}



int Engine::getNumberOfLayers() {
    return layersList.size();
}


void Engine::setNumberOfLayers(unsigned int _val){
    unsigned int currentNumberOfLayers = getNumberOfLayers();
    
    if (_val == currentNumberOfLayers) return;
    
    if (_val > currentNumberOfLayers) {
        for (unsigned int i = 0; i < _val-currentNumberOfLayers; i++) {
            this->addLayer();
        }
        
    }
    else {
        for (unsigned int i = _val-1; i < currentNumberOfLayers; i++) {
            this->removeLayer(i);
        }
        
    }
}

LayerProperties* Engine::getPropertiesOfCurrentLayer() {
    Layer           *layer;
    LayerProperties *properties;
    
    layer       = this->getSelectedLayer();
    properties  = layer->getProperties();
    
    return properties;
}

/* ************************************************************************** */
#pragma mark debug



void Engine::printInfo() {
	cout << "********************************************************************************"<<endl;
	cout << "** Engine Debug Print *********************************************** [start] **"<<endl;
	cout << "********************************************************************************"<<endl;
	cout << "mixerWidth: "<<mixerWidth<<endl;
	cout << "mixerHeight: "<<mixerHeight<<endl;
	cout << "Set object address: "<<&currentSet<<endl;
	cout << endl;
	cout << "** Layers **********************************************************************"<<endl;
	cout << "number of layers: "<<layersList.size()<<endl;
	int count = 1;
	for (LayersListIterator i = layersList.begin();i!=layersList.end(); i++){
		Layer *layer = (*i);
		cout << endl;
		cout << "LAYER "<<count<<":"<<endl;
		layer->print();
		count++;
	}
	cout << endl;
	currentSet.print();

	cout << "********************************************************************************"<<endl;
	cout << "** Engine Debug Print ************************************************* [end] **"<<endl;
	cout << "********************************************************************************"<<endl;
	cout << endl;
}


void Engine::saveCurrentFrame(string path) {
    ofPixels pixels;
    
    //pixels.setFromPixels(buffer.get)
    buffer->readToPixels(pixels);
    ofSaveImage(pixels, path);
}

/* ************************************************************************** */
#pragma mark Scene & Visuals




void Engine::addVisualToSceneListInCurrentLayer(unsigned int visual, unsigned int layer, unsigned int column) {
	Visual *visualToAdd = currentSet.getVisualFromList(visual);
	
	if (visualToAdd != NULL) {
            //cout << "adding visual #"<<visual<<" in column "<<column<<endl;
		if (layer <=0) layer = selectedLayer;
		if (layer>layersList.size()) layer = layersList.size();
		currentSet.getCurrentScene()->addVisualToInstanceList(visualToAdd, layer, column);
	}
}



void Engine::addVisualToScene(unsigned int visual, unsigned int layer, unsigned int column) {
    Visual *visualToAdd = currentSet.getVisualFromList(visual);
    
    if (visualToAdd != NULL) {
            // check if the current layer exists. if not, add it and all before
        if (layer > currentSet.getNumberOfLayers() ) {
            for (int i=layersList.size();i<=layer; i++) {
                    //cout << "adding layer "<<i<<endl;
                    //add here
                addLayer();
            }
        }
        
        currentSet.getCurrentScene()->addVisualToInstanceList(visualToAdd, layer, column);
    }
}


void Engine::removeVisualFromScene(unsigned int layer, unsigned int column) {
    Scene *currentScene;
    
    currentScene = getCurrentScene();
    
    if (layer == selectedLayer && column == selectedColumn) {
        stopVisualAtSelectedLayer();
    }
    
    currentScene->removeVisualInstance(layer, column);
}


Scene *Engine::getCurrentScene() {
    return currentSet.getCurrentScene();
}

Scene *Engine::getSceneAtIndex(unsigned int index) {
    return currentSet.getSceneAtIndex(index);
}

unsigned int Engine::getNumberOfVisuals() {
    return currentSet.getNumberOfVisuals();
}

Visual* Engine::getVisualAtIndex(unsigned int index) {
    return currentSet.getVisualFromList(index);
}



/*!
 Traverse all the inputs, check if they are syphon inputs, check if the servername and appname are the samse
 **/
bool Engine::isSyphonInputLoaded(string serverName, string appName) {
    /*
    unsigned int nVisuals;
    
    nVisuals = getNumberOfVisuals();
    for(int index = 0; index < nVisuals; index++) {
        Visual *visual = getVisualAtIndex(index);
        if (visual->getType() == VisualType_Syphon) {
            if (
                serverName.compare(((VisualSyphon *)visual)->getServerName()) == 0 &&
                appName.compare(((VisualSyphon *)visual)->getAppName()) == 0
                
                ) return true;
        }
    }
    return false;
     */
    
    return (getSyphonInput(serverName, appName)!=NULL) ? true:false;
}

VisualSyphon* Engine::getSyphonInput(string serverName, string appName) {
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


void Engine::removeVisualFromSet(Visual *visual) {
    currentSet.removeVisualFromSet(visual);
 }

/* ************************************************************************** */
#pragma mark Render & Draw

void Engine::render(){
    
    if (osc != NULL) osc->update();
    
    if (beatSnapInProgress) {
        triggerSchedulledVisualsOnAllLayers();
        beatSnapInProgress = false;
    }
	
	// check if there are layers. exit if not
	if (layersList.empty()== true) return;
	
	
	// render each layer 
    unsigned int layerCount = 0;
    for (LayersListIterator i = layersList.begin();i!=layersList.end(); i++){
		Layer *layer = (*i);
		layer->render();
        if (layerCount < N_SYPHON_CHANNEL_OUTPUTS) {
            syphonOutputManager.publishChannelOutputScreen(layerCount, layer->getTexture());
        }
        layerCount++;
	}
	
	// draw each layer on the engine buffer
	this->buffer->begin();
	ofClear(0, 0, 0, 0);
	ofEnableAlphaBlending();
    for (LayersListReverseIterator i = layersList.rbegin();i!=layersList.rend(); i++){
		Layer *layer = (*i);
		
		if (layer!=NULL) {
			ofSetColor(255, 255, 255, (int) (layer->getProperties()->getAlpha() * 255.0));
			ofEnableBlendMode((ofBlendMode) layer->getProperties()->getBlendMode());
			layer->draw(0, 0, mixerWidth, mixerHeight);
            ofDisableBlendMode();
		}
	}
	ofDisableAlphaBlending();

	this->buffer->end();
    
    // send the main output syphon
    syphonOutputManager.publishMainOutputScreen(&this->buffer->getTextureReference());
}



void Engine::drawOutput(int x, int y, int width, int height){
	if (buffer==NULL) return;
	buffer->draw(x, y, width, height);
}


void Engine::drawLayer(int layerNumber, int x, int y, int width, int height) {
	// move to layer
	if (layerNumber<=1) return;
	Layer *layer = getLayer(layerNumber);
	layer->draw(x,y,width, height);
}

void Engine::drawOutputPreview(int x, int y, int width, int height) {
	ofSetColor(255, 255, 255);
	drawOutput(x, y,width, height);
	/*
	ofSetColor(0,0, 0);
	ofNoFill();
	GUIRect(x, y, width, height);
	ofFill();
	ofEnableAlphaBlending();
	ofSetColor(0, 0, 0,128);
	ofRect(x, y, width, 16);
	ofSetColor(0, 0, 0,0);
	ofDisableAlphaBlending();
	GUIPrint("Output", x+4, y+12,GUIFontSmall);
	ofSetColor(255, 255, 255);
	GUIPrint("Output", x+3, y+11,GUIFontSmall);
	*/
}

void Engine::drawLayersPreview(int x, int y, int width, int maxNumLayers) {
	unsigned int count = 0;
	unsigned layersToDraw = this->layersList.size();
	unsigned int layerPreviewWidth = (int) floor((float) width / (float) this->layersPreview_Columns);
	float resizeAmount = this->mixerWidth / layerPreviewWidth;
	unsigned int layerPreviewHeight = mixerHeight / resizeAmount;
	
	unsigned int x1 = x;
	unsigned int y1 = y;
	if (layersToDraw>maxNumLayers)layersToDraw = maxNumLayers;

	for (unsigned int f=0;f<layersToDraw;f++) {
		Layer *layer = this->getLayer(f+1);
		/*
		ofSetColor(0,0, 0);
		ofFill();
		ofRect(x1, y1, layerPreviewWidth, layerPreviewHeight);
		 */
		ofSetColor(255, 255, 255);
		layer->draw(x1, y1, layerPreviewWidth, layerPreviewHeight);
		/*
		ofSetColor(0,0, 0);
		ofNoFill();
		GUIRect(x1, y1, layerPreviewWidth, layerPreviewHeight);
		*/
		ofEnableAlphaBlending();
		ofSetColor(0, 0, 0,128);
		ofFill();
		ofRect(x1, y1, layerPreviewWidth, 16);
		ofSetColor(0, 0, 0,0);
		ofDisableAlphaBlending();
		

		string label;
		label="Layer " + ofToString(f+1) + "|";
        BlendMode layerBlendMode =layer->getProperties()->getBlendMode();
        
		if ( layerBlendMode == BLEND_ALPHA) label =label+"ALPHA";
		if ( layerBlendMode == BLEND_ADD) label =label+ "ADD";
		if ( layerBlendMode == BLEND_MULTIPLY) label =label+"MULT";
		if ( layerBlendMode == BLEND_SUBTRACT) label =label+"SUBT";
		if ( layerBlendMode== BLEND_SCREEN) label =label+"SCRN";
		label =label+"|"+ofToString((int)(layer->getProperties()->getAlpha() * 100))+"%";
		//GUIPrint(label, x1+4, y1+12, GUIFontSmall);
		ofSetColor(255, 255, 255);
		//GUIPrint(label, x1+3, y1+11,GUIFontSmall);
		
		// check if f is odd
		if ((f+1) % layersPreview_Columns == 0) {
			x1=x;
			y1=y1+layerPreviewHeight;
		} else {
			x1 = x1+layerPreviewWidth;
		}
		
	}
}



/* ************************************************************************** */
#pragma mark beats and metronome functions

void Engine::beat() {
    triggeringBeat = false;
    
        //cout << "beat!"<<endl;
    ++beatsCounter;
        //cout << beatsCounter << endl;
    if (beatsCounter>32) beatsCounter = 0;
    
    if (beatsCounter%beatsToSnap == 0.0) {
        triggeringBeat = true;
        beatSnapInProgress = true;
            //cout << "BAR!" <<endl;
    }
    
    
    // TODO run something from the main app probably set a callback for the beat
    //((AppProtocol *)app)->beat();
    appBeatCallback();
}


void Engine::triggerSchedulledVisualsOnAllLayers() {
        // traverse all layers and activate what needs to be activated
    for (LayersListIterator i = layersList.begin();i!=layersList.end(); i++){
        Layer *layer = (*i);
        
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
        //cout << "metronome on" <<endl;
	metronomeThreadObj.start();
	metronomeOn=true;
}

void Engine::stopMetronome(){
        //cout << "metronome off" <<endl;
	metronomeThreadObj.stop();
	metronomeOn = false;
}


void Engine::resetMetronome() {
    metronomeThreadObj.resetMetronome();
}


void Engine::tap() {
    unsigned long long elapsedTime = ofGetElapsedTimeMillis();
    /*
    unsigned int index=0;
    if (currentTapIndex>-1) index = currentTapIndex+1;
    */
    if (currentTapIndex>-1) currentTapIndex++; else currentTapIndex=0;
    if (currentTapIndex>3) currentTapIndex = 0;
    taps[currentTapIndex] = elapsedTime;
    
    //printf("%3llu %3llu %3llu %3llu\n", taps[0], taps[1], taps[2], taps[3]);
    
    
    // calculate bpm
    if (currentTapIndex == 3) {
        unsigned long  long a, b, c;
        float newBpm;
        a = taps[1]-taps[0];
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
	if (buffer==NULL) {
		buffer = new ofFbo();
		buffer->allocate(mixerWidth, mixerHeight);
		
		// clear the fbo
		buffer->begin();
		ofClear(0, 0, 0, 0);
		buffer->end();
	}
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


/*************** */
void Engine::setActiveLayer(unsigned int activeLayer){
    unsigned int layerSize = layersList.size();
	if (activeLayer>(layerSize)) activeLayer = layerSize;
	selectedLayer = activeLayer-1;
}




/* ************************************************************************ */
#pragma mark Cameras Functions


void Engine::scanCameras() {
    ofVideoGrabber 		vidGrabber;
    vector<ofVideoDevice> devices = vidGrabber.listDevices();
    
    for(int i = 0; i < devices.size(); i++){
		cout << devices[i].id << ": " << devices[i].deviceName;
        if( devices[i].bAvailable ){
            cout << endl;
        }else{
            cout << " - unavailable " << endl;
        }
	}
    
    
}


/* ************************************************************************ */
#pragma mark Windows Functions


NSRect Engine::getMainScreenRect() {
    for (ScreensListIterator i = screensList.begin();i!=screensList.end(); i++){
		Screen *screen = (*i);
        
        if (screen->isPrimaryScreen()) return screen->getNSRect();
    }
    return NSMakeRect(0,0,0,0);
    
}




#pragma mark cleanup

void Engine::cleanup() {
    currentSet.cleanup();
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

VisualInstancesProperties* Engine::getPropertiesOfCurrentVisualInstance() {
    VisualInstance          *visualInstance;
    VisualInstancesProperties *properties;
    
    visualInstance = this->getCurrentVisualInstance();
    if  (visualInstance == NULL) return NULL;
    
    return(visualInstance->getProperties());
}


float Engine::playhead() {
    VisualInstance *visualInstance;
    
    visualInstance = this->getCurrentVisualInstance();
    if  (visualInstance == NULL) return 0.0;
    
    return visualInstance->getPercentagePlayed();
}



void Engine::setPlayhead(float playhead) {
    VisualInstance *visualInstance;
    
    visualInstance = this->getCurrentVisualInstance();
    if  (visualInstance == NULL) return;

    visualInstance->setPercentagePlayed(playhead);
}

float Engine::start() {
    VisualInstancesProperties *properties;
    
    properties = getPropertiesOfCurrentVisualInstance();
    if (properties==NULL) return NULL;
    
    return(properties->getStartPercentage());
}

void Engine::setStart(float start) {
    VisualInstancesProperties *properties;
    
    properties = getPropertiesOfCurrentVisualInstance();
    if (properties==NULL) return;
    
     properties->setStartPercentage(start);
}

float Engine::end() {
    VisualInstancesProperties *properties;
    
    properties = getPropertiesOfCurrentVisualInstance();
    if (properties==NULL) return NULL;
    
    return(properties->getEndPercentage());
}

void Engine::setEnd(float end) {
    VisualInstancesProperties *properties;
    
    properties = getPropertiesOfCurrentVisualInstance();
    if (properties==NULL) return;
    
    properties->setEndPercentage(end);
}

float Engine::speed() {
    VisualInstance *visualInstance;
    
    visualInstance = this->getCurrentVisualInstance();
    if  (visualInstance == NULL) return 0.0;
    
    return(visualInstance->video.getSpeed());
}

void Engine::setSpeed(float speed) {
    VisualInstance *visualInstance;
    
    visualInstance = this->getCurrentVisualInstance();
    if  (visualInstance == NULL) return;
    
    return(visualInstance->video.setSpeed(speed));
}

float   Engine::x() {
    VisualInstancesProperties *properties;
    
    properties = getPropertiesOfCurrentVisualInstance();
    if (properties==NULL) return NULL;
    
    return(properties->getCenterX());
}

void Engine::setX(float x) {
    VisualInstancesProperties *properties;
    
    properties = getPropertiesOfCurrentVisualInstance();
    if (properties==NULL) return;
    
    properties->setCenterX(x);
}

float Engine::y()  {
    VisualInstancesProperties *properties;
    
    properties = getPropertiesOfCurrentVisualInstance();
    if (properties==NULL) return NULL;
    
    return(properties->getCenterY());
}

void Engine::setY(float y)  {
    VisualInstancesProperties *properties;
    
    properties = getPropertiesOfCurrentVisualInstance();
    if (properties==NULL) return;
    
    properties->setCenterY(y);
}

float Engine::width()  {
    VisualInstancesProperties *properties;
    
    properties = getPropertiesOfCurrentVisualInstance();
    if (properties==NULL) return NULL;
    
    return(properties->getZoomX());
}

void Engine::setWidth(float width)  {
    VisualInstancesProperties *properties;
    
    properties = getPropertiesOfCurrentVisualInstance();
    if (properties==NULL) return;
    
    properties->setZoomX(width);
}


float Engine::height()  {
    VisualInstancesProperties *properties;
    
    properties = getPropertiesOfCurrentVisualInstance();
    if (properties==NULL) return NULL;
    
    return(properties->getZoomY());
}


void Engine::setHeight(float height)  {
    VisualInstancesProperties *properties;
    
    properties = getPropertiesOfCurrentVisualInstance();
    if (properties==NULL) return;
    
    properties->setZoomY(height);
}


bool Engine::retrigger() {
    VisualInstancesProperties *properties;
    
    properties = getPropertiesOfCurrentVisualInstance();
    if (properties==NULL) return NULL;
    
    return(properties->getRetrigger());
}


void Engine::setRetrigger(bool retrigger) {
    VisualInstancesProperties *properties;
    
    properties = getPropertiesOfCurrentVisualInstance();
    if (properties==NULL) return;
    
    properties->setRetrigger(retrigger);
}


bool Engine::beatSnap() {
    VisualInstancesProperties *properties;
    Boolean                     returnedVal;
    
    properties = getPropertiesOfCurrentVisualInstance();
    if (properties==NULL) return NULL;
    
    returnedVal = properties->getBeatSnap();
    return(returnedVal);
}


void Engine::setBeatSnap(bool val) {
    VisualInstancesProperties *properties;
    
    properties = getPropertiesOfCurrentVisualInstance();
    if (properties==NULL) return;
    
    properties->setBeatSnap(val);
}



/*************************************************************/

#pragma mark controllers handling

void Engine::visualsKeysControlCallback(Controller *controller) {
    int value;
    
    //if (_engine==NULL) return;
    //if (controller->getType() != KeyController) return;
    
    
    _engine->setActiveVisualIntanceOnActiveLayer(controller->getValue());
    
    
}

/*************************************************************/
    
#pragma mark other stuff

string Engine::md5(string message) {
    string result;
    string shellCommand;
    
    try {
        shellCommand = "md5 -q -s " + message;
        result = ofSystem(shellCommand);
        result.erase(result.size() - 2);
    }
    catch(exception& e) {
        cout << e.what() << "\n";
        result = "";
    }
    return result;
}

void Engine::setAppSupportDir(string _dir) {
    appSupportDir = _dir;
}

string Engine::calculateThumbnailPath(string path) {
    //return ofString
    string md5FileName = this->md5(ofFilePath::getFileName(path));
    return appSupportDir + "/cache/thumbnails/" + md5FileName + ".jpg";
    
}


#pragma mark App Callback Registration

void Engine::registerAppBeatCallback(void (*callback)(void)) {
    appBeatCallback = callback;
}

