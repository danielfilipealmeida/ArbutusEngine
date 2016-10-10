/*
 *  Engine.h
 *  VJingApp
 *
 *  Created by Daniel Almeida on 12/13/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#ifndef __ENGINE_H__
#define __ENGINE_H__


#include "ofMain.h"
#include "ofxXmlSettings.h"
#include "Set.h"
#include "Layer.h"
#include "FileManager.h"
#include "Metronome.h"
#include "Midi.h"
#include "Osc.h"
//#include "FreeFrameFilters.h"
#include "Screen.h"
#include "SetProperties.h"
#include "Controller.h"
#include "SyphonOutputManager.h"
#include "AppProtocol.h"

#define MAXIMUM_NUMBER_OF_LAYERS 6


typedef enum  {
    PLAY_MODE = 0,
    LEARN_MODE
} EngineRunMode;



/**
 * The Engine Class.
 * This is the main class that the program class uses to handle everything 
 * related with the video mixing.
 */

class Engine {
    EngineRunMode   runMode;
    ControllerGroup controllers;
    Osc             *osc;   // isto é usado???
    unsigned int	mixerWidth, mixerHeight, mixerNLayers;
    
    
    string          appSupportDir;
    int             selectedLayer;
    int             selectedColumn;

    // I should make a class just for these data
    Boolean			metronomeOn;
    unsigned int    beatsToSnap;
    unsigned int    beatsCounter;
    Boolean         triggeringBeat;
    Boolean         beatSnapInProgress;
    unsigned long long taps[4];
    int             currentTapIndex = -1;

    
    bool			setOpened;
    unsigned		layersPreview_Columns;

    
    string          currentFilePath;
    
    Set				currentSet;
  
    LayersList		layersList;
    ScreensList     screensList;

    VisualInstance	*currentVisualInstance;

    ofFbo			*buffer;

    metronome		metronomeThreadObj;
    
    FileManager     fileManagerThreadObj;
    
    SyphonOutputManager syphonOutputManager;
public:
    SetProperties   properties;
    
	
	
    dispatch_queue_t processingQueue;
    
    
    
    
    
// include free frame if available
#ifdef _OFX_FFGL_HOST
	FreeFrameFilterHost freeFrameHost;
	FreeFrameFilterInstanceList freeFrameInstanceList;
	ofxFFGLHost ffHost;
//#else
//#warning "FreeFrame not available!"
#endif
    
	
	Engine();
	~Engine();

	
	/*
	 * Set functions
	 */
	bool newSet(unsigned int _width=0, unsigned int _height=0, unsigned int _layers=0);
	void closeSet();
	bool openSet(string _setPath);
	bool saveSet();
	bool saveSetAs(string _setPath);
	
    void setMixerResolution(unsigned int width, unsigned int height);
    
    /*************************************************************/
    
#pragma mark Layer functions
 
	Layer*          addLayer();
	void            addLayerToList(Layer *newLayer);
	void            removeAllLayers();
	void            removeLayer(unsigned int layerN);
	void            setActiveVisualInstanceNumberForLayer(unsigned int visualInstanceN, unsigned int layerN);
	void            setActiveVisualIntancesOnAllLayers(unsigned int columnN);
	void            setActiveVisualIntanceOnActiveLayer(unsigned int visualInstanceN);
	Layer*          getLayer(unsigned int layerN);
    Layer*          getSelectedLayer() { return this->getLayer(this->selectedLayer);}
	void            setActiveLayer(unsigned int activeLayer);
	VisualInstance* getCurrentActiveVisualInstance();
    VisualInstance* getVisualAtLayerAndInstanceN(unsigned int layerN, unsigned int visualInstanceN);
	void            stopVisualAtSelectedLayer();
    void            stopVisualAtLayer(unsigned int layerN);
    int             getNumberOfLayers();
    void            setNumberOfLayers (unsigned int _val);
    LayerProperties *getPropertiesOfCurrentLayer();
    
    /*************************************************************/
    
#pragma mark Scene & Visuals Functions
	void            addVisualToSceneListInCurrentLayer(unsigned int visual, unsigned int layer, unsigned int column);
    void            addVisualToScene(unsigned int visual, unsigned int layer, unsigned int column);
    void            removeVisualFromScene(unsigned int layer, unsigned int column);
    Scene           *getCurrentScene();
    Scene           *getSceneAtIndex(unsigned int index);
    unsigned int    getNumberOfVisuals();
    Visual          *getVisualAtIndex(unsigned int index);
    bool            isSyphonInputLoaded(string serverName, string appName);
    VisualSyphon*   getSyphonInput(string serverName, string appName);
    void            removeVisualFromSet(Visual *visual);
    
    
    /*************************************************************/

#pragma mark App Callback Registration
    
    void (*appBeatCallback)(void); ;
	

    /*************************************************************/
    
#pragma mark Rendering and drawing Functions

    void render();
	void drawOutput(int x, int y, int width, int height);
	void drawLayer(int layerNumber, int x, int y, int width, int height);
	void drawOutputPreview(int x, int y, int width, int height);
	void drawLayersPreview(int x, int y, int height, int maxNumLayers = MAXIMUM_NUMBER_OF_LAYERS );
	
	
    /*************************************************************/
    
#pragma mark Debug

	void printInfo();
    void saveCurrentFrame(string path);
	
    /*************************************************************/
    
#pragma mark Beats, Tap & metronomes

	void beat();
	void startMetronome();
	void stopMetronome();
	void tap();
    void setBPM(unsigned int newBPM);
    unsigned int getBPM();
    void triggerSchedulledVisualsOnAllLayers();
    void resetMetronome();
    unsigned int getCurrentBeat();
    
    
    /*************************************************************/
    
#pragma mark Buffer related functions
    
	void initBuffer();
	void destroyBuffer();
	

    /*************************************************************/
    
#pragma mark Input handling. mouse/keys.
    

	void keyPressed(int key);
	void keyReleased(int key);
	void mouseMoved(int x, int y );
	void mouseDragged(int x, int y, int button);
	void mousePressed(int x, int y, int button);
	void mouseReleased(int x, int y, int button);
    
    
    void setDefaults();
    
    /*************************************************************/
    
#pragma mark Cameras       
    
    
    void scanCameras();
    
    
    /*************************************************************/
    
#pragma mark Windows

    
    NSRect getMainScreenRect();
    
    
    /*************************************************************/
    
#pragma mark Cleanup

    void cleanup();
    
 
    /*************************************************************/
    
#pragma mark midi & osc


    
    void changeMidiPort(int port);
    void changeOscPort(int port);
    
    
    
/*************************************************************/
    
#pragma mark getters and setters
    

    
    bool isCurrentSetLoaded() {return currentSet.isLoaded();}
    
    unsigned int    getMixerWidth() { return mixerWidth; };
    void            setMixerWidth ( unsigned int _width ) { mixerWidth = _width; }
    
    unsigned int    getMixerHeight() { return mixerHeight; };
    void            setMixerHeight ( unsigned int _height ) { mixerHeight = _height; }
    
    NSSize getMixerSize() {return NSMakeSize(mixerWidth, mixerHeight); }
    
    
    int     getSelectedLayerNumber () { return selectedLayer; }
    void    setSelectedLayerNumber ( int val ) { selectedLayer = val; }
    
    int     getSelectedColumnNumber () { return selectedColumn; }
    void    setSelectedColumnNumber ( int val ) { selectedColumn = val; }
    
    
    unsigned int    getBeatsToSnap() { return beatsToSnap; }
    void            setBeatsToSnap ( unsigned int val ) { beatsToSnap = val; }
    
    unsigned int    getBeatsCounter() { return beatsCounter; }
    void            setBeatsCounter ( unsigned int val ) { beatsCounter = val; }

    
    Boolean isMetronomeOn () { return metronomeOn; }
    void setMetronomeOn ( Boolean val ) { metronomeOn = val; }
    
    Boolean isTriggeringBeat () { return triggeringBeat; }
    void setTriggeringBeat ( Boolean val ) { triggeringBeat = val; }
    
    string getCurrentFilePath () { return currentFilePath; }
    
    Set *getCurrentSet () { return &currentSet; }
    
    LayersList getLayersList() { return layersList;}
    ScreensList getScreensList() { return screensList; }
    
    VisualInstance *getCurrentVisualInstance () { return currentVisualInstance; }
    VisualInstancesProperties *getPropertiesOfCurrentVisualInstance();
    


    ofFbo *getBuffer() { return buffer; }
    
    
    /* parameters setters and getters */
    
    float   playhead();
    void    setPlayhead(float playhead);
    float   start();
    void    setStart(float start);
    float   end();
    void    setEnd(float end);
    float   speed();
    void    setSpeed(float speed);
    float   x();
    void    setX(float x);
    float   y();
    void    setY(float y);
    float   width();
    void    setWidth(float width);
    float   height();
    void    setHeight(float height);
    bool    retrigger();
    void    setRetrigger(bool retrigger);
    bool    beatSnap();
    void    setBeatSnap(bool val);
    
    
    /* handling controllers */
    static void visualsKeysControlCallback(Controller *controller);
    
    
    /* more stuff */
    
    void setAppSupportDir(string _dir);
    string calculateThumbnailPath(string path);
    string md5(string);

    
#pragma mark App Callback Registration
    
    /* ************************** */
    /* App Callback Registrations */
    

    
    /*!
     * Register the callback to be executed on the app when a beat occurs
     * @param void* callback the callback to be executed
     */
    void registerAppBeatCallback(void (*callback)(void));

};






#endif

