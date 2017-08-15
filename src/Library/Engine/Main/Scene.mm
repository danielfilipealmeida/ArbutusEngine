/*
 *  Scene.mm
 *  VJingApp
 *
 *  Created by Daniel Almeida on 12/13/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#include "Scene.h"


Scene::Scene(string _sceneName){
	sceneName = _sceneName; 
};


Scene::~Scene() {
 	visualInstances.empty();
}



json
Scene::getState() {
    json state;
   
    
    state = json::object({
        {"name", sceneName},
        {"instances", visualInstances.getState()}
    });
    
    
    return state;
}


void
Scene::setName(string newName) {
    sceneName = newName;
}


/*
VisualInstance * Scene::addVisualToInstanceList(Visual *visual, unsigned int layer, unsigned int column) {
	
	// check if there is already a visual and the layer/column
	if(isVisualInstantInColumn(column, layer) == true) {
		removeVisualInstance(layer, column);
		
	}
    
	VisualInstance *instance = new VisualInstance(visual, layer, column);
	visualsInstanceList.push_back(instance);
	totalVisualsOnScene = (unsigned int) visualsInstanceList.size();
    
    return instance;
}
*/

/*
void Scene::removeVisualInstance(unsigned int layer, unsigned int column) {
    
	for(VisualInstanceListIterator i=visualsInstanceList.begin();
        i!=visualsInstanceList.end();
        i++) {
        VisualInstance *visualInstance;
        
		visualInstance = *i;
		if (visualInstance->getProperties()->getLayer () == layer &&
            visualInstance->getProperties()->getColumn () == column
            ) {
            visualsInstanceList.erase(i);
		}
	}
}
*/

/*
void Scene::removeVisualInstancesWithVisual(Visual *visual) {
    for(VisualInstanceListIterator i=visualsInstanceList.begin();
        i!=visualsInstanceList.end();
        i++) {
        VisualInstance *visualInstance;
        
        visualInstance = *i;
        if (visualInstance->visual == visual) {
            visualsInstanceList.erase(i);
        }
    }
}
 */




/*
Boolean Scene::isVisualInstantInColumn(unsigned int column, unsigned int layerN) {
	Boolean res = false;
	for(VisualInstanceListIterator i=visualsInstanceList.begin(); i!=visualsInstanceList.end();i++) {
		VisualInstance *visualInstance = *i;
		if (visualInstance->getProperties()->getLayer () == layerN && visualInstance->getProperties()->getColumn () == column) res = true;
	}
	
	return res;
}
*/
 
/*
void Scene::emptyVisualInstancesList() {
	
    for(VisualInstanceListIterator i=visualsInstanceList.begin(); i!=visualsInstanceList.end();i++) {
        VisualInstance *visualInstance = *i;

        delete visualInstance;
    }
    
    visualsInstanceList.empty();
}
*/

/*
int Scene::getLastColumnInLayer(unsigned int layer) {
    int result = -1;
    for(VisualInstanceListIterator i=visualsInstanceList.begin(); i!=visualsInstanceList.end();i++) {
		VisualInstance *visualInstance = *i;
        if (visualInstance->getProperties()->getLayer () == layer &&
            visualInstance->getProperties()->getColumn () > result
            ) {
         result = visualInstance->getProperties()->getColumn ();
        }
    }
    

    return result;
}
*/


/****************************************************************************/
#pragma mark debug


void Scene::print(){
	cout << "scene name: "<<sceneName<<endl;
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
void Scene::addFreeFrameInstanceToVisualInstance(unsigned int instanceSlotNumber,
                                                 unsigned int column,
                                                 unsigned int layerN) {
	
	VisualInstance *instance = visualInstances.get(column, layerN);
	if (instance==NULL) return;
#ifdef _FREEFRAMEFILTER_H_
	instance->addFreeFrameInstance(instanceSlotNumber);
#endif
}


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




#pragma mark Scenes Implementation

Scenes& Scenes::getInstance()
{
    static Scenes instance;
    
    return instance;
}


ScenesList Scenes::getList() {
    return scenesList;
}


void Scenes::newScene(string sceneTitle) {
    Scene *newScene = NULL;
    newScene = new Scene(sceneTitle);
    add(newScene);
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


