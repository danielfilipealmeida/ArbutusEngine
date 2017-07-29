/*
 *  Scene.h
 *  VJingApp
 *
 *  Created by Daniel Almeida on 12/13/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */



#ifndef __SCENE_H__
#define __SCENE_H__


#include "ofMain.h"
#include <stdlib.h>
#include "VisualInstance.h"
#include "Visual.h"
#include "json.hpp"


using json = nlohmann::json;


/*!
 @class Scene
 @abstract
 @discussion
 */
class Scene {
    string          sceneName;
    unsigned int    totalVisualsOnScene;

public:
	
	VisualInstanceList visualsInstanceList;

    /*!
     */
	Scene(
          string _sceneName,
          unsigned int _totalVisualsOnScene
    );
	

    /*!
     */
    ~Scene();
	
    /*!
     */
    json
    getState();
    
    /*!
     */
    json
    getInstancesState();
    
    
    VisualInstance  *addVisualToInstanceList(Visual *visual, unsigned int layer, unsigned int column);
	
    
    
    /**
     *  traverse the list of Visual instances to find the selected instance
     *
     *  @param column the column of the visual
     *  @param layerN the layer of the visual
     *
     *  @return [VisualInstance*] a pointer of the selected visual instance
     */
    VisualInstance*
    getVisualInstance(
                      unsigned int column,
                      unsigned int layerN
    );
    
    
    
    void
    removeVisualInstance(unsigned int layer, unsigned int column);
    
    
    
    void
    removeVisualInstancesWithVisual(Visual *visual);
    
    
    
    Boolean
    isVisualInstantInColumn(
                            unsigned int column,
                            unsigned int layerN
    );
    
    
    
	void
    emptyVisualInstancesList();
	
    
    
    
	// debug
	void print();
	
	// freeframe
	void addFreeFrameInstanceToVisualInstance(unsigned int instanceSlotNumber,
                                              unsigned int column,
                                              unsigned int layerN);
	void removeFreeFrameInstanceToVisualInstance(unsigned int instanceSlotNumber,
                                                 unsigned int column,
                                                 unsigned int layerN);
    
    int getLastColumnInLayer(unsigned int layer);
    
    void cleanup();
	
    void loadAllVisuals();

    
    
    /** getters and setters **/
    
    unsigned int getTotalVisualsOnScene () { return totalVisualsOnScene; }
    
    string getSceneName () { return sceneName; }
    void setSceneName ( string _val ) { sceneName = _val; }
    
    void setName(string newName);

};



typedef std::list<Scene *> ScenesList;
typedef ScenesList::iterator ScenesListIterator;

#endif
