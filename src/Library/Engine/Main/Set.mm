/*
 *  Set.mm
 *  VJingApp
 *
 *  Created by Daniel Almeida on 12/13/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#include "Set.h"
#include "ofApp.h"
#include "Scene.h"
#include "Layer.h"
#include "Engine.h"
#include "SetFile.hpp"

#include <algorithm>

#include "VisualVideo.h"
#include "VisualCamera.h"
#include "VisualSyphon.h"
#include "EngineProperties.h"
#include "Visuals.h"


extern Engine *enginePtr;

Set& Set::getInstance() {
    static Set instance;
    
    return instance;
}

Set::Set() {
	currentScene = NULL;
	numVideosFound = 0;
	totalScenes = 0;
	currentSceneNumber = 0;
	loaded=false;
}

Set::~Set() {
	closeSet();
    loaded = false;
}


/* ************************************************************************* */
#pragma mark File Management




void Set::newSet(
                 unsigned int _width,
                 unsigned int _height,
                 unsigned int _nLayers
) {
    EngineProperties::getInstance().setMixerWidth ( _width );
    EngineProperties::getInstance().setMixerHeight ( _height );
    
	nLayers = _nLayers;
    
    for (int f=0; f < _nLayers; f++) {
        Layers::getInstance().add();
    }
    Scenes::getInstance().newScene("First Scene");
    /*
	Scene *newScene = NULL;
	newScene = new Scene("First Scene");
	addSceneToList(newScene);
     */

    currentSceneNumber = 1;
    setCurrentScene(0);
    loaded = true;

}


json
Set::getScenesState() {
    json state;
    
    for(auto scene:Scenes::getInstance().getList()) {
        state.push_back(scene->getState());
    }
    
    return state;
}


bool Set::openSet(string _filePath) {
    json state = SetFile::load(_filePath);
    Engine::getInstance()->setState(state);
    
    return true;
}


void Set::saveSetAs(string _filePath) {
	filePath = _filePath;
    SetFile::save(_filePath, Engine::getInstance()->getState());
}





void Set::saveSet() {
    saveSetAs(filePath);
    /*
    ofXml xml;
    int count;
    
    xml.addChild("set");
    xml.setTo("set");
    xml.addChild("configuration");
    xml.setTo("configuration");
    xml.addValue("width", EngineProperties::getInstance().getMixerWidth());
    xml.addValue("height", EngineProperties::getInstance().getMixerHeight());
    xml.setToParent();
    
    
    // save layers
    xml.addChild("layers");
    xml.setTo("layers");
    
    count = 0;
    for (auto layer:Layers::getInstance().getList()) {
        LayerProperties *layerProperties;
        
        xml.addChild("layer");
        xml.setToChild(count);
        
        layerProperties = layer->getProperties();
        
        xml.addValue("alpha", layerProperties->getAlpha ());
        xml.addValue("red", layerProperties->getRed () );
        xml.addValue("green", layerProperties->getGreen ());
        xml.addValue("blue", layerProperties->getBlue ());
        xml.addValue("brightness", layerProperties->getBrightness ());
        xml.addValue("contrast", layerProperties->getContrast ());
        xml.addValue("saturation", layerProperties->getSaturation ());
        xml.addValue("blur", layerProperties->getBlurH ());
        xml.addValue("blend", layerProperties->getBlendMode ());
        xml.addValue("name", layerProperties->getName ());
        
        xml.setToParent();
        
        count++;
    }
    xml.setToParent();
    
    // save visuals
    xml.addChild("visuals");
    xml.setTo("visuals");
    count = 0;
    for(VisualsListIterator i = visualsList.begin();
        i!=visualsList.end();
        i++)
    {
        
        Visual *visual;
        
        visual = (*i);
        xml.addChild("visual");
        xml.setToChild(count);
        
        xml.addValue("number", count);
        xml.addValue("type", visual->getType());
        
        if (visual->getType () == VisualType_Video) {
            xml.addValue("file", ((VisualVideo *)visual)->getFilePath());
        }

        if (visual->getType () == VisualType_Camera) {
            xml.addValue("deviceId", ((VisualCamera *)visual)->deviceId);
            xml.addValue("frameRate", ((VisualCamera *)visual)->frameRate);
            xml.addValue("width", ((VisualCamera *)visual)->width);
            xml.addValue("height", ((VisualCamera *)visual)->height);
        }
        
        xml.setToParent();
        count++;
        
    }
    xml.setToParent();
    
    count=0;
    xml.addChild("scenes");
    xml.setTo("scenes");
    for(auto scene:Scenes::getInstance().getList()) {
        
        if (scene!=NULL) {
            xml.addChild("scene");
            xml.setToChild(count);
            
            xml.addValue("name", scene->getSceneName () );
            xml.addChild("visuals");
            xml.setTo("visuals");
            int visualsCount = 0;
            for(VisualInstanceListIterator j = scene->visualsInstanceList.begin();
                j!=scene->visualsInstanceList.end();
                j++)
            {
                VisualInstance  *instance;
                Visual          *visual;
                int             visualNumber;
                int             visualCounter;
                
                
                instance = (*j);
                
                xml.addChild("visual");
                xml.setToChild(visualsCount);
                
                visualNumber = -1;
                // traverse all the visuals and get the index of this instance
                visual = instance->visual;
    
                visualCounter = 0;
                for (auto k:Set::getInstance().visualsList) {
                    if (k == visual) {
                        visualNumber = visualCounter;
                        continue;
                    }
                    visualCounter++;
                }
                
                xml.addValue("number",  visualNumber);
                xml.addValue("layer",   instance->getProperties()->getLayer () );
                xml.addValue("column",  instance->getProperties()->getColumn () );
                xml.addValue("snap", (unsigned int) instance->getProperties()->getBeatSnap () );
                xml.setToParent();
                visualsCount++;
            }
            xml.setToParent();
            
            
            xml.setToParent();
        }
        
        
        count++;

    }
    
    xml.save(filePath);
    
    // emptu setData
    //setData.clear();
    
    
	//setData.saveFile(filePath);
*/
}


void Set::closeSet() {
    Visuals::getInstance().empty();
	Scenes::getInstance().empty();
    loaded = false;
}


/* ************************************************************************* */
#pragma mark Visuals Management








/**
 *  Adds a visual to a list from a file
 *
 *  @param filePath string with the file path to the visual to add
 */
void Set::addVisualVideoToListFromFile(string filePath)
{
    VisualVideo	*visual;
		// check if the visual is already on the list
    if (Visuals::getInstance().isFileInList(filePath)) return;
	
	visual = new VisualVideo(filePath);
    //NSLog(@"Loading visual into %x an file %s",(unsigned int) visual, filePath.c_str());
	Visuals::getInstance().add((Visual *)visual);
}



void Set::addVisualCameraToList(unsigned int id, unsigned int rate, unsigned int w, unsigned int h) {
    VisualCamera *visual = NULL;
    
    visual = new VisualCamera(id, rate, w, h);
    Visuals::getInstance().add((Visual *)visual);
}


void Set::addVisualSyphonToList(string serverName, string appName){
    VisualSyphon *visual;
    
    visual = new VisualSyphon(serverName, appName);
    Visuals::getInstance().add((Visual *)visual);
}





Scene* Set::addScene(string sceneName, unsigned char nVisualsInScene, unsigned char *visualsInScene) {
    Scene *newScene;
    
    newScene = new Scene(sceneName);
    addScene(newScene);
    
    return newScene;
}

void Set::addScene(Scene *newScene) {
    Scenes::getInstance().add(newScene);
}


Scene* Set::newScene() {
    return addScene("new Scene", 0,0);
}


void Set::setNameToCurrentScene(string newName) {
    if (currentScene == NULL) return;
    currentScene->setName(newName);
}


void Set::removeCurrentScene() {
    ScenesList scenesList = Scenes::getInstance().getList();
    unsigned int nextScene = this->currentSceneNumber;
    if (nextScene >0) nextScene--;
    
    this->currentScene->visualInstances.empty();
    bool isFirst = false;
    if (this->currentScene == scenesList.front()) isFirst = true;
    
    bool isLast = false;
    if (this->currentScene == scenesList.back()) isLast = true;
    scenesList.remove(this->currentScene);
    
        // mover para a frente ou para tras...
        //TERMINAR
    
    this->setCurrentScene(nextScene);
}




 
/**
 *  Change the current scene
 *
 *  @param _sceneNumber the scene numbe
 */
void Set::setCurrentScene(unsigned int _sceneNumber) {
    ScenesList scenesList = Scenes::getInstance().getList();
    
  	if (_sceneNumber>scenesList.size()-1) return;
	currentSceneNumber = _sceneNumber;
	ScenesListIterator i = scenesList.begin();
	std::advance(i, _sceneNumber);
	currentScene = (*i);
    if (currentScene == NULL) return;
    currentScene->visualInstances.loadAll();
}




void Set::gotoPreviousScene() {
    if (currentSceneNumber>0) setCurrentScene(currentSceneNumber-1);
}

void Set::gotoNextScene() {
    if (currentSceneNumber < ( Scenes::getInstance().getList().size() - 1 ) ) {
        setCurrentScene(currentSceneNumber+1);
    }
}


// todo: remove or have the code here instead of in the Engine::
void Set::setActiveVisualInstance(unsigned int layerN, unsigned int column)
{
        //currentLayer = layerN;
        //currentScene = column;

	
}




VisualInstance* Set::getVisualInstanceInCorrentSet(unsigned int layer, unsigned int column)
{
	if (currentScene==NULL) return NULL;
	
	return currentScene->visualInstances.get(layer, column);
}

Boolean Set::isVisualInstantInColumn(unsigned int layerN, unsigned int column)
{
	if (currentScene==NULL) return NULL;
	
	return currentScene->visualInstances.inColumn(column, layerN);
}

void Set::emptyVisualInstanceOnAllScenes()
{
	for(auto scene:Scenes::getInstance().getList()) {
        scene->visualInstances.empty();;
	}
}

unsigned int Set::getTotalScenes() {
    return (unsigned int) 	Scenes::getInstance().getList().size();
}



/* ************************************************************************* */

#pragma mark debug

void Set::print() {
    ScenesList scenesList = Scenes::getInstance().getList();
    
	cout << "** SET **********************************************************************"<<endl;
	cout << "file path: "<<filePath<<endl;
	cout << "number of videos: " << numVideosFound<<endl;
	cout << "total of scenes: " << totalScenes<<endl;
	cout << "current scene: " << currentSceneNumber<<endl;
	cout << endl;
	
	cout << "** VISUALS *******************************************************************"<<endl;
    cout << "number of visuals: " << Visuals::getInstance().count() << endl;
    Visuals::getInstance().print();
	cout << endl;
	
	cout << "** SCENES ********************************************************************"<<endl;
	cout << "number of scenes: " << scenesList.size() << endl;
	unsigned int count = 1;
    
    
    for (auto scene:scenesList){
		cout << endl;
		cout << "** SCENE "<<count<<": ******************"<<endl;
		scene->print();
		count++;
	}
	cout << endl;
}



#pragma mark cleanup


void Set::cleanup() {
    if (currentScene!=NULL) currentScene->cleanup();
}
