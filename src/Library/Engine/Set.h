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



class Set {
    bool			loaded;
    string			filePath;
    unsigned int	nLayers;
    ofxXmlSettings	setData;
    unsigned int	numVideosFound;
    unsigned int	totalScenes;
    unsigned int	currentSceneNumber;
    ScenesList		scenesList;
    Scene			*currentScene;
    
    VisualsList		visualsList;
    
    
public:

    
	Set();
	~Set();
	
	bool openSet(string _filePath);
    bool openSet_old(string _filePath);
	void closeSet();
	void newSet(unsigned int _width, unsigned int _height, unsigned int _nLayers);
    
    /*!
     *  traverse set data and generate a xml document
     */
	void saveSet();
	
    
    void saveSetAs(string _filePath);
	
	// visuals
    unsigned int    getNumberOfVisuals();
	void            addVisualToList(Visual *visual);
	Visual          *getVisualFromList(int pos);
	Boolean         isFileInVisualsList(string filePath);
	void            addVisualVideoToListFromFile(string filePath);
    void            addVisualCameraToList(unsigned int id, unsigned int rate, unsigned int w, unsigned int h);
    void            addVisualSyphonToList(string serverName, string appName);
	void            emptyVisualsList();
	
	// scenes
	void            addSceneToList(string sceneName, unsigned char nVisualsInScene, unsigned char *visualsInScene);
    void            newScene();
    void            removeCurrentScene();
	void            addSceneToList(Scene *newScene);
	void            emptyScenesList();
	void            setCurrentScene(unsigned int _sceneNumber);
    void            setNameToCurrentScene(string newName);
    void            gotoPreviewScene();
    void            gotoNextScene();
	void            setActiveVisualInstanceNumberForLayer(unsigned int column, unsigned int layerN);
	VisualInstance  *getVisualInstanceInCorrentSet(unsigned int column, unsigned int layerN);
	Boolean         isVisualInstantInColumn(unsigned int column, unsigned int layerN);
	void            emptyVisualInstanceOnAllScenes();
    unsigned int    getTotalScenes();
    Scene*          getSceneAtIndex(unsigned int index);
    void            removeVisualFromSet(Visual *visual);
    
	// debug
	void print();
    
        // cleanup
    void cleanup();
    
    
    /* setters & getters */
    
    bool isLoaded() {return loaded;}

    string getFilePath () { return filePath; }
    void setFilePath ( string _input ) { filePath = _input; }
    
    unsigned int getNumberOfLayers () { return nLayers; }
    void setNumberOfLayers (unsigned int _val) { nLayers = _val; }
    
    unsigned int getCurrentSceneNumber () { return currentSceneNumber; }
    
    VisualsList*    getVisualsList () { return &visualsList; }
    Scene*          getCurrentScene () { return currentScene; }
    
    
    
};


#endif
