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
 @abstract ...
 @discussion ...
 */
class Scene {
    string sceneName;
    unsigned int totalVisualsOnScene;

public:
	
	VisualInstanceList visualsInstanceList;

    /*!
     @abstract ...
     */
	Scene(
          string _sceneName,
          unsigned int _totalVisualsOnScene
    );
	

    /*!
     @abstract ...
     */
    ~Scene();
	
    /*!
     @abstract ...
     */
    json getState();
    
    /*!
     @abstract ...
     */
    json getInstancesState();
    
    
    /*!
     @abstract ...
     */
    VisualInstance  *addVisualToInstanceList(Visual *visual, unsigned int layer, unsigned int column);
	
    
    
    /**
     *  traverse the list of Visual instances to find the selected instance
     *
     *  @param column the column of the visual
     *  @param layerN the layer of the visual
     *
     *  @return [VisualInstance*] a pointer of the selected visual instance
     */
    VisualInstance* getVisualInstance(
                      unsigned int column,
                      unsigned int layerN
    );
    
    
    
    /*!
     @abstract ...
     */
    void removeVisualInstance(unsigned int layer, unsigned int column);
    
    
    
    /*!
     @abstract ...
     */
    void removeVisualInstancesWithVisual(Visual *visual);
    
    
    
    /*!
     @abstract ...
     */
    Boolean isVisualInstantInColumn(
                            unsigned int column,
                            unsigned int layerN
    );
    
    
    
    /*!
     @abstract ...
     */
	void emptyVisualInstancesList();
	
    
    /*!
     @abstract ...
     */
	void print();
	
    /*!
     @abstract ...
     */
	void addFreeFrameInstanceToVisualInstance(unsigned int instanceSlotNumber,
                                              unsigned int column,
                                              unsigned int layerN);
    
    /*!
     @abstract ...
     */
	void removeFreeFrameInstanceToVisualInstance(unsigned int instanceSlotNumber,
                                                 unsigned int column,
                                                 unsigned int layerN);
    
    /*!
     @abstract ...
     */
    int getLastColumnInLayer(unsigned int layer);
    
    /*!
     @abstract ...
     */
    void cleanup();
	
    /*!
     @abstract ...
     */
    void loadAllVisuals();

    
    
    /*!
     @abstract ...
     */
    unsigned int getTotalVisualsOnScene () { return totalVisualsOnScene; }
    
    /*!
     @abstract ...
     */
    string getSceneName () { return sceneName; }

    
    /*!
     @abstract ...
     */
    void setSceneName ( string _val ) { sceneName = _val; }
    
    /*!
     @abstract ...
     */
    void setName(string newName);

};



typedef std::list<Scene *> ScenesList;
typedef ScenesList::iterator ScenesListIterator;


/**!
 */
class Scenes {
    ScenesList scenesList;
    
    
    Scenes() {}
    
public:
    
    static Scenes& getInstance();
    Scenes(Scenes const&) = delete;
    void operator=(Scenes const&) = delete;

    ScenesList getList();

    void newScene(string sceneTitle, unsigned int nVisuals);
    void add(Scene *newScene);
    
    void empty();
    
    Scene* get(unsigned int index);
};

#endif
