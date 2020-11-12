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


using json = nlohmann::json;


/*!
 @class Scene
 @abstract ...
 @discussion ...
 */
class Scene {
    string sceneName;

public:
	
	VisualInstances visualInstances;

    /*!
     \brief Scene Object constructor
     \param  _sceneName a string for the name of the new scene
     */
	Scene(string _sceneName);
	

    /*!
     \brief Destructor
     */
    ~Scene();
	
    /*!
     \brief ...
     */
    json getState();
    
    /*!
     \brief ...
     */
    void setState(json state);
    
    
    /*!
     @abstract ...
     */
	void print();

  
    /*!
     @abstract ...
     */
    void cleanup();

    
    
    
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

    Scene *newScene(string sceneTitle);
    void add(Scene *newScene);
    
    void empty();
    
    Scene* get(unsigned int index);
    
    /*!
     */
    void setState(json state);

    /*!
     */
    json getState();

};

#endif
