/*
 *  Scene.mm
 *  VJingApp
 *
 *  Created by Daniel Almeida on 12/13/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#include "Scene.h"
#include "Visuals.h"



Scene::Scene(string _sceneName){
	sceneName = _sceneName; 
};


Scene::~Scene() {
 	visualInstances.empty();
}



json Scene::getState() {
    json state;
   
    state = json::object({
        {"name", sceneName},
        {"instances", visualInstances.getState()}
    });
    
    return state;
}

void Scene::setState(json state) {
    if (!state.is_object()) throw "State isn't an object";
    if (state["name"].is_string()) setName(state["name"].get<string>());
    if (!state["instances"].is_array()) return;
    
    visualInstances.empty();
    for(auto newVisualInstanceState:state["instances"]) {
        Visual *visual;
        unsigned int layer, column;
        string name;
        
        visual = Visuals::getInstance().get(newVisualInstanceState["index"]);
        if (visual == NULL) continue;
        
        layer = newVisualInstanceState["properties"]["layer"];
        column = newVisualInstanceState["properties"]["column"];
        name = newVisualInstanceState["properties"]["name"];
        
        visualInstances.add(visual, layer, column, name);
    }
}


void
Scene::setName(string newName) {
    sceneName = newName;
}


/****************************************************************************/
#pragma mark debug


void Scene::print(){
	cout << "scene name: " << sceneName << endl;
	cout << "total visuals: " << visualInstances.count() << endl;
    visualInstances.print();
}



#pragma mark cleanup


void Scene::cleanup() {
    visualInstances.cleanup();
}




//////////////////////////////////////////////////////////////////////

#pragma mark free frame functions


// columns and layerN starts in 1
/*
void Scene::addFreeFrameInstanceToVisualInstance(unsigned int instanceSlotNumber,
                                                 unsigned int column,
                                                 unsigned int layerN) {
	
	VisualInstance *instance = visualInstances.get(column, layerN);
	if (instance==NULL) return;
#ifdef _FREEFRAMEFILTER_H_
	instance->addFreeFrameInstance(instanceSlotNumber);
#endif
}
*/
/*
void Scene::removeFreeFrameInstanceToVisualInstance(
                                                    unsigned int instanceSlotNumber,
                                                    unsigned int column,
                                                    unsigned int layerN
                                                    )
{
#ifdef _FREEFRAMEFILTER_H_
    VisualInstance *instance;
    instance = visualInstances.get(column, layerN);;
	instance->removeFreeFrameInstance(instanceSlotNumber);
#endif
}

*/


#pragma mark Scenes Implementation

Scenes& Scenes::getInstance()
{
    static Scenes instance;
    
    return instance;
}


ScenesList Scenes::getList() {
    return scenesList;
}


// todo: reame to new
Scene* Scenes::newScene(string sceneTitle) {
    Scene *newScene = NULL;
    newScene = new Scene(sceneTitle);
    add(newScene);
    
    return newScene;
}


void Scenes::add(Scene *newScene) {
    scenesList.push_back(newScene);
}


void Scenes::empty() {
    for(ScenesListIterator i = scenesList.begin();
        i != scenesList.end();
        i++) {
        
        Scene *scene = (*i);
        delete scene;
    };
    
    scenesList.clear();
}



Scene* Scenes::get(unsigned int index) {
    unsigned int count;
    
    count = 0;
    
    if (count >= scenesList.size()) return NULL;
    for (ScenesListIterator it = scenesList.begin();
         it!=scenesList.end();
         it++) {
        if (count == index) return *it;
        count++;
    }
    return NULL;
}


void Scenes::setState(json state) {
    //cout << state.dump(4) << endl;
    empty();
    for (auto newSceneState:state) {
        Scene *scene = newScene(newSceneState["name"]);
        scene->setState(newSceneState);
    }
    
}

json Scenes::getState() {
    json state;
    
    return state;
}


