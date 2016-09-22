/*
 *  Scene.mm
 *  VJingApp
 *
 *  Created by Daniel Almeida on 12/13/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#include "Scene.h"


Scene::Scene(string _sceneName, unsigned int _totalVisualsOnScene=0){
	sceneName = _sceneName; 
	totalVisualsOnScene = _totalVisualsOnScene;
};


Scene::~Scene() {
 	emptyVisualInstancesList();
}


void Scene::setName(string newName) {
    sceneName = newName;
}



VisualInstance * Scene::addVisualToInstanceList(Visual *visual, unsigned int layer, unsigned int column) {
	
	// check if there is already a visual and the layer/column
	if(isVisualInstantInColumn(column, layer) == true) {
		removeVisualInstance(layer, column);
		
	}
    
	VisualInstance *instance = new VisualInstance(visual, layer, column);
	visualsInstanceList.push_back(instance);
	totalVisualsOnScene = visualsInstanceList.size();
    
    return instance;
}



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


/**
 *  traverse the list of Visual instances to find the selected instance
 *
 *  @param column <#column description#>
 *  @param layerN <#layerN description#>
 *
 *  @return <#return value description#>
 */
VisualInstance *Scene::getVisualInstance(unsigned int column, unsigned int layerN) {
	if (visualsInstanceList.size() == 0) return NULL;
	for(VisualInstanceListIterator i=visualsInstanceList.begin();
        i!=visualsInstanceList.end();
        i++)
    {
		VisualInstance *visualInstance = *i;
        if (visualInstance->getProperties()->getLayer () == layerN && visualInstance->getProperties()->getColumn () == column) {
            return visualInstance;
        }
    }
	return NULL;
}




Boolean Scene::isVisualInstantInColumn(unsigned int column, unsigned int layerN) {
	Boolean res = false;
	for(VisualInstanceListIterator i=visualsInstanceList.begin(); i!=visualsInstanceList.end();i++) {
		VisualInstance *visualInstance = *i;
		if (visualInstance->getProperties()->getLayer () == layerN && visualInstance->getProperties()->getColumn () == column) res = true;
	}
	
	return res;
}


void Scene::emptyVisualInstancesList() {
	
    for(VisualInstanceListIterator i=visualsInstanceList.begin(); i!=visualsInstanceList.end();i++) {
        VisualInstance *visualInstance = *i;

        delete visualInstance;
    }
    
    visualsInstanceList.empty();
}



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



/****************************************************************************/
#pragma mark debug


void Scene::print(){
	cout << "scene name: "<<sceneName<<endl;
	cout << "total visuals: "<<totalVisualsOnScene<<endl;
	cout << "visual instances number: " << visualsInstanceList.size()<<endl;
	cout << endl;
	cout << "** VISUAL INSTANCES ****"<<endl;
	int count = 1;
	for (VisualInstanceListIterator i = visualsInstanceList.begin();i!=visualsInstanceList.end(); i++){
		VisualInstance *visualInstance = (*i);
		cout << "VISUAL INSTANCE "<<count<<":"<<endl;
		visualInstance->print();
		count++;
		cout << endl;;
	}
	
}



#pragma mark cleanup


void Scene::cleanup() {
    VisualInstanceListIterator  i;
    VisualInstance              *visualInstance;
    
    if (visualsInstanceList.empty()) return;
    if (visualsInstanceList.size() ==0) return;
    
    for(i=visualsInstanceList.begin(); i!=visualsInstanceList.end();i++) {
        visualInstance = *i;
        
        if (visualInstance->checkCloseCondition() == true) {
            visualInstance->unload();
        }
    }
    
}


void Scene::loadAllVisuals() {
    VisualInstanceListIterator  i;
    VisualInstance              *visualInstance;
    
    for(i = visualsInstanceList.begin(); i != visualsInstanceList.end(); i++) {
        visualInstance = *i;
        visualInstance->loadVideo();
    }
}


//////////////////////////////////////////////////////////////////////

#pragma mark free frame functions


// columns and layerN starts in 1
void Scene::addFreeFrameInstanceToVisualInstance(unsigned int instanceSlotNumber,
                                                 unsigned int column,
                                                 unsigned int layerN) {
	
	VisualInstance *instance = getVisualInstance(column, layerN);
	if (instance==NULL) return;
#ifdef _FREEFRAMEFILTER_H_
	instance->addFreeFrameInstance(instanceSlotNumber);
#endif
}


void Scene::removeFreeFrameInstanceToVisualInstance(unsigned int instanceSlotNumber,
                                                    unsigned int column,
                                                    unsigned int layerN) {
    VisualInstance *instance;
    
#ifdef _FREEFRAMEFILTER_H_
    instance = getVisualInstance(column, layerN);;
	instance->removeFreeFrameInstance(instanceSlotNumber);
#endif



}

