/*
 *  Set.h
 *  VJingApp
 *
 *  Created by Daniel Almeida on 12/13/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */


#ifndef __SET_H__
#define __SET_H__

#include "ofMain.h"
#include <stdlib.h>
#include "ofxXmlSettings.h"
#include "Visual.h"
#include "Scene.h"
#include "Layer.h"



/*!
 @class Set
 @abstract ...
 @discussion ...
 */
class Set {
    bool loaded;
    string filePath;
    unsigned int nLayers, numVideosFound, totalScenes, currentSceneNumber;
    ofxXmlSettings	setData;
    
    Scene *currentScene;
    
    // cleaning up
    //VisualsList		visualsList; // passar para um singleton
    //ScenesList scenesList;
    
    /**!
     @abstract ...
     */
    Set();
    
public:

    static Set& getInstance();
    Set(Set const&) = delete;
    void operator=(Set const&) = delete;
    
    
    /**!
     @abstract ...
     */
	~Set();
    
    
    
    /**!
     @abstract ...
     */
    json getScenesState();
    

    /**!
     @abstract ...
     */
    bool openSet(string _filePath);
    
    /**!
     @abstract ...
     */
    bool openSet_old(string _filePath);
	
    /**!
     @abstract ...
     */
    void closeSet();
    
    /**!
     @abstract ...
     */
    void newSet(unsigned int _width, unsigned int _height, unsigned int _nLayers);
    
    /*!
     *  traverse set data and generate a xml document
     */
	void saveSet();
	
    
    /**!
     @abstract ...
     */
    void saveSetAs(string _filePath);
    
	
    /**!
     @abstract ...
     */
	void addVisualVideoToListFromFile(string filePath);
    
    /**!
     @abstract ...
     */
    void addVisualCameraToList(unsigned int id, unsigned int rate, unsigned int w, unsigned int h);
    
    /**!
     @abstract ...
     */
    void
    addVisualSyphonToList(string serverName, string appName);
	
    /**!
     @abstract ...
     */
    void emptyVisualsList();
	
  
#pragma mark Scenes
	
    /**!
     @abstract ...
     */
    Scene* addScene(string sceneName, unsigned char nVisualsInScene, unsigned char *visualsInScene);
    
    /**!
     @abstract ...
     */
    void addScene(Scene *newScene);
    
    /**!
     @abstract ...
     */
    Scene* newScene();
    
    /**!
     @abstract ...
     */
    void removeCurrentScene();
	
    
    /**!
     @abstract ...
     */
    void emptyScenesList();
	
    /**!
     @abstract ...
     */
    void setCurrentScene(unsigned int _sceneNumber);
    
    /**!
     @abstract ...
     */
    void setNameToCurrentScene(string newName);
    
    /**!
     @abstract ...
     */
    void gotoPreviousScene();
    
    /**!
     @abstract ...
     */
    void gotoNextScene();
    
    /**!
     @abstract ...
     */
    void setActiveVisualInstanceNumberForLayer(unsigned int column, unsigned int layerN);
    
    /**!
     @abstract ...
     */
    VisualInstance *getVisualInstanceInCorrentSet(unsigned int column, unsigned int layerN);
 
    /**!
     @abstract ...
     */
    Boolean isVisualInstantInColumn(unsigned int column, unsigned int layerN);
    
    /**!
     @abstract ...
     */
    void emptyVisualInstanceOnAllScenes();
    
    /**!
     @abstract ...
     */
    unsigned int getTotalScenes();
    
    /**!
     @abstract ...
     */
    Scene* getSceneAtIndex(unsigned int index);
    
    /**!
     @abstract ...
     */
	void print();
    
    /**!
     @abstract ...
     */
    void cleanup();
    
    
#pragma mark Setters & Getters
    
    /**!
     @abstract ...
     */
    bool isLoaded() {return loaded;}

    
    /**!
     @abstract ...
     */
    string getFilePath () { return filePath; }
    
    
    /**!
     @abstract ...
     */
    void setFilePath ( string _input ) { filePath = _input; }
    
    /**!
     @abstract ...
     */
    unsigned int getNumberOfLayers () { return nLayers; }
    
    /**!
     @abstract ...
     */
    void setNumberOfLayers (unsigned int _val) { nLayers = _val; }
    
    /**!
     @abstract ...
     */
    unsigned int getCurrentSceneNumber () { return currentSceneNumber; }
    
    /**!
     @abstract ...
     */
    Scene*  getCurrentScene () { return currentScene; }
};


#endif
