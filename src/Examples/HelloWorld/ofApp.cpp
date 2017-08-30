#include "ofApp.h"
#include "Engine.h"
#include "JsonLoad.hpp"


//--------------------------------------------------------------
void ofApp::setup(){
    Engine *engine = new Engine();
    string filePath = ofFilePath::getCurrentExeDir() + "../Resources/set.json";

    try {
        engine->openSet(filePath);
    }
    catch (string &exception) {
        cout << "Error: " << exception << endl;
    }
    
    std::cout << engine->getState().dump(4) << std::endl;
    //json loadedState;
    //std::string filePath;
    
    //
    //loadedState = JsonLoad::load(filePath);

}

//--------------------------------------------------------------
void ofApp::update(){
    Engine::getInstance()->render();

}

//--------------------------------------------------------------
void ofApp::draw(){
    Engine::getInstance()->drawOutput();
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key){

}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){

}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y){

}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h){

}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg){

}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo){ 

}