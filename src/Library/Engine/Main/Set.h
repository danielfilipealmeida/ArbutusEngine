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

    /*!
     \brief ...
     */
    static Set& getInstance();
    
    /*!
     \brief Constructor
     */
    Set(Set const&) = delete;
    
    /*!
     \brief Destructor
     */
    ~Set();
    
    /*!
     \brief ...
     */
    void operator=(Set const&) = delete;
    
   
    /*!
     \brief ...
     */
    json getScenesState();
    

    /*!
     \brief ...
     @param _filePath the file path
     */
    bool openSet(string _filePath);
    
    /*!
     \brief ...
     @param _filePath <#_filePath description#>
     */
    bool openSet_old(string _filePath);
	
    /*!
     \brief ...
     */
    void closeSet();
    
    /*!
     \brief ...
     @param _width <#_width description#>
     @param _height <#_height description#>
     @param _nLayers <#_nLayers description#>
     */
    void newSet(
                unsigned int _width,
                unsigned int _height,
                unsigned int _nLayers);
    
    /*!
     \brief traverse set data and generate a xml document
     */
	void saveSet();
	
    
    /*!
     \brief ...
     @param _filePath <#_filePath description#>
     */
    void saveSetAs(string _filePath);
    
	
    /*!
     \brief ...
     @param filePath <#filePath description#>
     */
	void addVisualVideoToListFromFile(string filePath);
    
    /**
     !
     @abstract ...
     @param rate <#rate description#>
     @param w <#w description#>
     @param h <#h description#>
     */
    void addVisualCameraToList(
                               unsigned int id,
                               unsigned int rate,
                               unsigned int w,
                               unsigned int h);
    
    /**
     !
     @abstract ...
     @param serverName <#serverName description#>
     @param appName <#appName description#>
     */
    void addVisualSyphonToList(string serverName, string appName);
	
    /**!
     @abstract ...
     */
    void emptyVisualsList();
	
  
#pragma mark Scenes
	
    /**
     !
     @abstract ...
     @param sceneName <#sceneName description#>
     @param nVisualsInScene <#nVisualsInScene description#>
     @param visualsInScene <#visualsInScene description#>
     */
    Scene* addScene(
                    string sceneName,
                    unsigned char nVisualsInScene,
                    unsigned char *visualsInScene);
    
    /**
     !
     @abstract ...
     @param newScene <#newScene description#>
     */
    void addScene(Scene *newScene);
    
    /**
     !
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
	
    /**
     !
     @abstract ...
     @param _sceneNumber <#_sceneNumber description#>
     */
    void setCurrentScene(unsigned int _sceneNumber);
    
    /**
     !
     @abstract ...
     @param newName <#newName description#>
     */
    void setNameToCurrentScene(string newName);
    
    /**!
     @abstract ...
     */
    void gotoPreviousScene();
    
    /*!
     @abstract ...
     */
    void gotoNextScene();
    
    /*!
     @abstract ...
     @param layerN <#layerN description#>
     @param column <#column description#>
     */
    void setActiveVisualInstance(
                                 unsigned int layerN,
                                 unsigned int column);
    
    /*!
     \brief Returns a Visual instance in a given layer and column. 
     \param layer
     \param columbm
     */
    VisualInstance *getVisualInstanceInCorrentSet(unsigned int layer, unsigned int column);
 
    
    /*!
     @abstract ...
     */
    Boolean isVisualInstantInColumn(unsigned int layerN, unsigned int column);
    
    /*!
     @abstract ...
     */
    void emptyVisualInstanceOnAllScenes();
    
    /*!
     @abstract ...
     */
    unsigned int getTotalScenes();
    
    /*!
     @abstract ...
     */
    Scene* getSceneAtIndex(unsigned int index);
    
    /*!
     @abstract ...
     */
	void print();
    
    /*!
     @abstract ...
     */
    void cleanup();
    
    
#pragma mark Setters & Getters
    
    /*!
     @abstract ...
     */
    bool isLoaded() {return loaded;}

    
    /*!
     @abstract ...
     */
    string getFilePath () { return filePath; }
    
    
    /*!
     @abstract ...
     */
    void setFilePath ( string _input ) { filePath = _input; }
    
    /*!
     @abstract ...
     */
    unsigned int getNumberOfLayers () { return nLayers; }
    
    /*!
     @abstract ...
     */
    void setNumberOfLayers (unsigned int _val) { nLayers = _val; }
    
    /*!
     @abstract ...
     */
    unsigned int getCurrentSceneNumber () { return currentSceneNumber; }
    
    /*!
     @abstract ...
     */
    Scene*  getCurrentScene () { return currentScene; }
};


#endif
