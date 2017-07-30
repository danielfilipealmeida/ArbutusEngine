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
#include "Metronome.h"
#include "Midi.h"
#include "Osc.h"
#include "Screen.h"
#include "SetProperties.h"
#include "Controller.h"
#include "SyphonOutputManager.h"
#include "AppProtocol.h"
#include "json.hpp"
#include "EngineProperties.h"





using json = nlohmann::json;





/*!
 @class Engine
 @abstract The main class, used to control all aspects of the Arbutus VJing Library.
 @discussion This class implements the singleton pattern to create one object used to manage all aspects of the Arbutus Engine.
 */
class Engine {
    Set currentSet;
    LayersList layersList;
    ScreensList screensList;

    ControllerGroup controllers;
    Osc             *osc;   // isto é usado???
    
    bool setOpened;
    unsigned layersPreview_Columns;

    
    
  

    VisualInstance *currentVisualInstance;
    ofFbo *buffer;
    metronome metronomeThreadObj;
    
    SyphonOutputManager syphonOutputManager;
    
    EngineProperties engineProperties;
    SetProperties setProperties;
    
public:
    
    EngineProperties getEngineProperties();
	
	
    dispatch_queue_t processingQueue;
    
    
    
    
    
// include free frame if available
#ifdef _OFX_FFGL_HOST
	FreeFrameFilterHost freeFrameHost;
	FreeFrameFilterInstanceList freeFrameInstanceList;
	ofxFFGLHost ffHost;
//#else
//#warning "FreeFrame not available!"
#endif
    

    /*!
     */
	Engine();

    
    
    /*!
     */
    ~Engine();

    
    /*!
     @abstract Singleton instance getter
     */
    static Engine* getInstance();
	
	/*******************************************************************
	 * Set functions
	 *******************************************************************/
	
    
    /*!
     @abstract Starts a new set with the given dimentions and number of layers. Also allocs all memory needed.
     @param _width the width of the rendering area
     @param _height the height of the rendering area
     @param _layers the number of layers available
     @return a boolean result saying if the set was properly created or not
     */
    bool newSet(
                unsigned int _width  = 0,
                unsigned int _height = 0,
                unsigned int _layers = 0
    );
	
    
    /*!
     @abstract Closes a set and cleans up the memory
     */
    void closeSet();
	
    
    /*!
     @abstract Open a set
     @param _setPath the path to the file to open
     @return open success value. boolean
     */
    bool openSet(string _setPath);
	
    
    /*!
     @abstract Saves the set to the current filepath
     @returns boolean the result
     */
    bool saveSet();
    
    
    /*!
     @abstract Saves a VJ set into a file
     @param _setPath the path to the file to save
     @return a boolean result. True if the file as saved and false if not
     */
	bool saveSetAs(string _setPath);
	
    
    
    
    /*!
     @abstract Defines the area of the rendering buffer
     */
    void setMixerResolution(
                            unsigned int width,
                            unsigned int height
    );
    
    
    
    /*************************************************************/

    
    /*!
     @abstract handles all actions related to layers
     */
    void
    handleLayerAction(
                      string parameter,
                      json data
                      );
    
    
    /*!
     @abstract handles all actions related to visuals
     */
    void
    handleVisualAction(
                      string parameter,
                      json data
                      );
    
    
    
    /*!
     @abstract handles all actions to the engine
     @param parameter a string
     */
    void
    handleAction(
                 string parameter,
                 json data
                 );
    
    
    
    /*************************************************************/
    
#pragma mark Layer functions
 

    /*!
     @abstract
     */
	Layer*
    addLayer(bool _loadShaders = true);
    
    /*!
     @abstract
     */
	void
    addLayerToList(Layer *newLayer);
    
    /*!
     @abstract
     */
	void
    removeAllLayers();
    
    /*!
     @abstract
     */
	void
    removeLayer(unsigned int layerN);
    
    /*!
     @abstract
     */
    Layer*
    getLayer(unsigned int layerN);
    
    
    /*!
     @abstract
     */
    Layer*
    getCurrentLayer();
    
    
    unsigned int
    getCurrentLayerNumber() { return engineProperties.getSelectedLayerNumber();}
    
    /*!
     @abstract NOTE!!! isn't getSelectedLayer == getCurrentLayer
     */
    Layer*
    getSelectedLayer() { return getLayer(engineProperties.getSelectedLayerNumber());}
    
    
    
    /*!
     @abstract
     */
    void
    setActiveLayer(unsigned int activeLayer);
    
    
    
    
    /*!
     @abstract
     */
    int
    getNumberOfLayers();
    
    
    
    /*!
     @abstract
     */
    void
    setNumberOfLayers (unsigned int _val);
    
    
    
#pragma mark Visual Instances Methods
    
    
    /*!
     @abstract
     */
	void
    setActiveVisualInstanceNumberForLayer(
                                          unsigned int visualInstanceN,
                                        unsigned int layerN
   );
	
    
    
    /*!
     @abstract
     */
    void
    setActiveVisualIntancesOnAllLayers(unsigned int columnN);
	
    
    
    /*!
     @abstract
     */
    void
    setActiveVisualIntanceOnActiveLayer(unsigned int visualInstanceN);
    
    
    
    /*!
     @abstract
     */
	VisualInstance*
    getCurrentActiveVisualInstance();
    
    
    
    /*!
     @abstract
     */
    VisualInstance*
    getVisualAtLayerAndInstanceN(unsigned int layerN, unsigned int visualInstanceN);
    
    
    
    /*!
     @abstract
     */
	void
    stopVisualAtSelectedLayer();
    
    
    
    /*!
     @abstract
     */
    void
    stopVisualAtLayer(unsigned int layerN);
    
    
    

    
    
    /*!
     @abstract
     */
    LayerProperties
    *getPropertiesOfCurrentLayer();
    
    
    
    /*************************************************************/
    
#pragma mark Scene & Visuals Functions
	
    
    Scene*
    addScene();
    
    
    /*!
     @abstract
     */
    void
    addVisualToSceneListInCurrentLayer(
                                       unsigned int visual,
                                       unsigned int layer,
                                       unsigned int column
    );
    
    
    
    /*!
     @abstract
     */
    void
    addVisualToScene(
                     unsigned int visual,
                     unsigned int layer,
                     unsigned int column
    );
    
    
    
    /*!
     @abstract
     */
   void
    removeVisualFromScene(
                          unsigned int layer,
                          unsigned int column
    );
    
    
    
    /*!
     @abstract
     */
    Scene
    *getCurrentScene();
    
    
    
    /*!
     @abstract
     */
    Scene
    *getSceneAtIndex(unsigned int index);
    
    
    
    /*!
     @abstract
     */
   unsigned int
    getNumberOfVisuals();
    
    
    
    /*!
     @abstract
     */
    Visual
    *getVisualAtIndex(unsigned int index);
    
    
    
    /*!
     @abstract
     */
    bool
    isSyphonInputLoaded(
                        string serverName,
                        string appName
    );
    
    
    
    /*!
     @abstract
     */
    VisualSyphon*
    getSyphonInput(
                   string serverName,
                   string appName
    );
    
    
    
    void            removeVisualFromSet(Visual *visual);
    
    
    
#pragma mark State Handling
    
    json
    getState();
    
    json
    getLayersState();
    
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
    
#pragma mark Cleanup

    void cleanup();
    
 
    /*************************************************************/
    
#pragma mark midi & osc


    
    void changeMidiPort(int port);
    void changeOscPort(int port);
    
    
    
/*************************************************************/
    
#pragma mark getters and setters
    

    
    bool isCurrentSetLoaded() {return currentSet.isLoaded();}
    
    
    string getCurrentFilePath () { return engineProperties.getCurrentFilePath(); }
    
    Set *getCurrentSet () { return &currentSet; }
    
    LayersList getLayersList() { return layersList;}
    ScreensList getScreensList() { return screensList; }
    
    VisualInstance *getCurrentVisualInstance () { return currentVisualInstance; }
    VisualInstancesProperties *getPropertiesOfCurrentVisualInstance();
    


    ofFbo *getBuffer() { return buffer; }
    
    
    /* parameters setters and getters */
    
    float
    playhead();
    
    
    void
    setPlayhead(float playhead);
    
    
    float
    start();
    
    
    /*!
     */
    void
    setStart(float start);

    /*!
     */
    float
    end();
  
    /*!
     */
    void
    setEnd(float end);
    
    /*!
     */
    float
    speed();
    
    /*!
     */
    void
    setSpeed(float speed);
    
    /*!
     */
    float
    x();
    
    /*!
     */
    void
    setX(float x);
    
    /*!
     */
    float
    y();
    
    /*!
     */
    void
    setY(float y);
    
    
    /*!
     */
    float
    width();
    
    /*!
     */
    void
    setWidth(float width);
    
    /*!
     */
    float
    height();
    
    /*!
     */
    void
    setHeight(float height);
    
    /*!
     */
    bool
    retrigger();
    
    /*!
     */
    void
    setRetrigger(bool retrigger);

    /*!
     */
    bool
    beatSnap();

    /*!
     */
    void
    setBeatSnap(bool val);
    
    
    /* handling controllers */
    static void visualsKeysControlCallback(Controller *controller);
    
    
#pragma mark more stuff -- should be moved to another place. probably be made static methods
    
    /*!
     */
    void
    setAppSupportDir(string _dir);
    
    /*!
     */
    string
    calculateThumbnailPath(string path);
    
    
#pragma mark App Callback Registration
    
    /* ************************** */
    /* App Callback Registrations */
    

    
    /*!
     * Register the callback to be executed on the app when a beat occurs
     * @param void* callback the callback to be executed
     */
    void registerAppBeatCallback(void (*callback)(void));

    
private:
    Layer*
    getLayerForActionHandler (json data);
};






#endif

