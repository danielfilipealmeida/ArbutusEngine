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


extern Engine *enginePtr;


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
    Scenes::getInstance().newScene("First Scene", 0);
    /*
	Scene *newScene = NULL;
	newScene = new Scene("First Scene", 0);
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

json
Set::getVisualsState() {
    json state;
    
    for(auto visual:visualsList) {
        state.push_back(visual->getState());
    }
    
    return state;
}


bool Set::openSet(string _filePath) {
    SetFile::load(_filePath);
    
    return true;
    /*
    bool    result;
    ofXml   xml;
    bool    res;
    int     width;
    int     height;
    
    result      = false;
    filePath    = _filePath;
	res         = xml.load(filePath);
  
    if (!res) throw std::runtime_error ("Error opening file '" + _filePath + "'.");

    xml.setTo("set");
    
    // load configuration
    xml.setTo("configuration");
    
    width   = xml.getIntValue("width");
    height  = xml.getIntValue("height");
    
    EngineProperties::getInstance().setMixerWidth(width);
    EngineProperties::getInstance().setMixerHeight(height);
    
    xml.setToParent();
    
    // handle layers
    xml.setTo("layers");
    int layers = xml.getNumChildren();
    for (int f=0;f<layers;f++) {
        Layer           *newLayer;
        LayerProperties *layerProperties;
        
        xml.setToChild(f);
        
        newLayer        = new Layer();
        layerProperties = newLayer->getProperties();
        
        layerProperties->setAlpha (xml.getFloatValue("alpha"));
		layerProperties->setRed (xml.getFloatValue("red"));
		layerProperties->setGreen (xml.getFloatValue("green"));
		layerProperties->setBlue (xml.getFloatValue("blue"));
		layerProperties->setBrightness (xml.getFloatValue("brightness"));
		layerProperties->setContrast (xml.getFloatValue("contrast"));
		layerProperties->setSaturation (xml.getFloatValue("saturation"));
		layerProperties->setBlurH (xml.getFloatValue("blur"));
		layerProperties->setBlurV (xml.getFloatValue("blur"));
		layerProperties->setName (xml.getValue("name"));
        newLayer->setLayerNumber (f);
        Layers::getInstance().addToList(newLayer);
        
        xml.setToParent();
    }
    xml.setToParent();
   

    
    // handle visuals
    xml.setTo("visuals");
    int visuals = xml.getNumChildren();
    for(int f=0;f<visuals;f++) {
        xml.setToChild(f);
        
        switch (xml.getIntValue("type")) {
            case VisualType_Video:
                addVisualVideoToListFromFile(xml.getValue("file"));
                break;
                
            case VisualType_Camera:
                addVisualCameraToList(xml.getIntValue("deviceId"),
                                      xml.getIntValue("frameRate"),
                                      xml.getIntValue("width"),
                                      xml.getIntValue("height"));
                break;
                
            case VisualType_Syphon:
                addVisualSyphonToList(xml.getValue("serverName"),
                                      xml.getValue("appName"));
                break;
        }
        
         xml.setToParent();
    }
    xml.setToParent();
    
    
    // handle scenes
    xml.setTo("scenes");
    int scenes = xml.getNumChildren();
    for(int f=0;f<scenes;f++) {
        xml.setToChild(f);
    
        string sceneName = xml.getValue("name");
        Scene *scene;
        xml.setTo("visuals");
        int videosInScene = xml.getNumChildren();
        
        scene = new Scene(sceneName, videosInScene);
        for (int g = 0; g<videosInScene;g++) {
            int     videoNumber;
            int     layer;
            int     column;
            Boolean snap;
            Visual  *visual;
            
            xml.setToChild(g);
            
            videoNumber = xml.getIntValue("number");
            layer       = xml.getIntValue("layer");
            column      = xml.getIntValue("column");
            snap        = (Boolean) xml.getBoolValue("snap");
            
            visual      = getVisualFromList(videoNumber);
            if (visual!=NULL) {
                VisualInstance *addedVisual;
                
                addedVisual = scene->addVisualToInstanceList(visual, layer, column);
                addedVisual->getProperties()->setBeatSnap (snap);
            }
            xml.setToParent();
        }
        addSceneToList(scene);
        xml.setToParent();
        xml.setToParent();

    }
    xml.setToParent();
    currentSceneNumber = 1;
    setCurrentScene(0);
    result = true;
    loaded = true;
    
    return result;
     */
}


void Set::saveSetAs(string _filePath) {
	filePath = _filePath;
    SetFile::save(_filePath, Engine::getInstance()->getState());
}





void Set::saveSet() {
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
    /*
    for (LayersListIterator i = enginePtr->getLayersList().begin();
         i!=enginePtr->getLayersList().end();
         i++)
    {
		Layer           *layer;
     */
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
                for(VisualsListIterator k = enginePtr->getCurrentSet()->visualsList.begin();
                    k!=enginePtr->getCurrentSet()->visualsList.end();
                    k++) {
                    if ((*k) == visual)visualNumber = visualCounter;
                    
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
}

void Set::closeSet() {
	emptyVisualsList();
	//emptyScenesList();
    Scenes::getInstance().empty();
    loaded = false;
}


/* ************************************************************************* */
#pragma mark Visuals Management


void Set::addVisualToList(Visual *visual) {
	if (visual==NULL) return;
	visualsList.push_back(visual);
}

Boolean	Set::isFileInVisualsList(string filePath) {
	Boolean found = false;
	
	if (visualsList.empty() != true) {
		
		for (VisualsListIterator i = visualsList.begin();
			 i != visualsList.end();
             i++)
        {
			Visual *visual = ((Visual *) *i);
            
            switch (visual->getType()) {
                case VisualType_Video:
                    if (filePath.compare(((VisualVideo*)visual)->getFilePath () ) == 0 ) return true;
                    break;
                    
                case VisualType_Camera:
                    break;
                    
                case VisualType_Generator:
                    
                    break;
                    
                case VisualType_Syphon:
                    
                    break;
                    
            }
            
			
		}
	}
	return found;
}


unsigned int Set::getNumberOfVisuals() {
    return visualsList.size();
    
}



/**
 *  Adds a visual to a list from a file
 *
 *  @param filePath string with the file path to the visual to add
 */
void
Set::addVisualVideoToListFromFile(
                                  string filePath
                                  ) {
    VisualVideo	*visual;
	Boolean result;

	// check if the visual is already on the list
	if (isFileInVisualsList(filePath)) return;
	
	visual = new VisualVideo(filePath);
    //NSLog(@"Loading visual into %x an file %s",(unsigned int) visual, filePath.c_str());
	addVisualToList((Visual *)visual);
}



void Set::addVisualCameraToList(unsigned int id, unsigned int rate, unsigned int w, unsigned int h) {
    VisualCamera *visual = NULL;
    Boolean result;
    
    //if (isCameraInVisualList(id)) return;
    
    visual = new VisualCamera(id, rate, w, h);
    addVisualToList((Visual *)visual);    
}


void Set::addVisualSyphonToList(string serverName, string appName){
    VisualSyphon *visual;
    
    visual = new VisualSyphon(serverName, appName);
    addVisualToList(visual);
    
}

// traverse the Visuals list and return the visual
Visual* Set::getVisualFromList(int pos){
	int counter = 0;
	
	// traverse
	for (VisualsListIterator i = visualsList.begin();i!=visualsList.end(); i++){
		Visual *visual = (*i);
		if (counter == pos) return visual;
        counter++;
	}
	return NULL;
}


void Set::emptyVisualsList(){
	while (!visualsList.empty()){
		visualsList.pop_front();
	}
}



Scene* Set::addSceneToList(string sceneName, unsigned char nVisualsInScene, unsigned char *visualsInScene) {
    Scene *newScene;
    
    newScene = new Scene(sceneName, nVisualsInScene);
    //scenesList.push_back(newScene);
    Scenes::getInstance().add(newScene);
    
    return newScene;
}


Scene* Set::newScene() {
    return addSceneToList("new Scene", 0,0);
}


void Set::setNameToCurrentScene(string newName) {
    if (currentScene == NULL) return;
    currentScene->setName(newName);
}


void Set::removeCurrentScene() {
    ScenesList scenesList = Scenes::getInstance().getList();
    unsigned int nextScene = this->currentSceneNumber;
    if (nextScene >0) nextScene--;
    
    this->currentScene->emptyVisualInstancesList();
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
    currentScene->loadAllVisuals();
}




void Set::gotoPreviewScene() {
    if (currentSceneNumber>0) setCurrentScene(currentSceneNumber-1);
}

void Set::gotoNextScene() {
    if (currentSceneNumber < ( Scenes::getInstance().getList().size() - 1 ) ) {
        setCurrentScene(currentSceneNumber+1);
    }
}


void Set::setActiveVisualInstanceNumberForLayer(unsigned int column, unsigned int layerN){
        //currentLayer = layerN;
        //currentScene = column;

	
}



VisualInstance*
Set::getVisualInstanceInCorrentSet(
                                   unsigned int column,
                                   unsigned int layerN
) {
	if (currentScene==NULL) return NULL;
	
	return currentScene->getVisualInstance(column, layerN);
}

Boolean Set::isVisualInstantInColumn(unsigned int column, unsigned int layerN) {
	if (currentScene==NULL) return NULL;
	
	return currentScene->isVisualInstantInColumn(column, layerN);
}

void Set::emptyVisualInstanceOnAllScenes() {
	for(auto scene:Scenes::getInstance().getList()) {
        scene->emptyVisualInstancesList();
	}
}

unsigned int Set::getTotalScenes() {
    return Scenes::getInstance().getList().size();
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
	cout << "number of visuals: "<<visualsList.size()<<endl;
	int count = 1;
	for (VisualsListIterator i = visualsList.begin();i!=visualsList.end(); i++){
		cout << endl;
		Visual *visual = (*i);
		cout << "VISUAL "<<count<<":"<<endl;
		visual->print();
		count++;
	}
	cout << endl;
	
	cout << "** SCENES ********************************************************************"<<endl;
	cout << "number of scenes: " << scenesList.size() << endl;
	count = 1;
    
    
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
