#include "ofApp.h"
#include "JsonLoad.hpp"
#include "Utils.h"
#include "Messages.hpp"





void ofApp::setupTestSet() {
    string filePath = ofFilePath::getCurrentExeDir() + "../Resources/set.json";
    
    try {
        engine->openSet(filePath);
    }
    catch (string &exception) {
        ofLog(ofLogLevel::OF_LOG_ERROR, exception);
    }
    Set::getInstance().setCurrentScene(0);
    engine->play({
        {"layer", 0},
        {"column", 0}
    });
    engine->play({
        {"layer", 1},
        {"column", 0}
    });
}

void ofApp::initEngine() {
    ofSetFrameRate(DEFAULT_FRAME_RATE);
    this->engine = new Engine();
    
    setupTestSet();
}


//--------------------------------------------------------------
void ofApp::setup(){
    initEngine();
    tcp.init({{"port", (int) DEFAULT_TCP_PORT}});
    ipc.init({{"uri", DEFAULT_IPC_URI}});
}

//--------------------------------------------------------------
void ofApp::update(){
    tcp.update(handleJSONRequestForClient);
    ipc.update(handleJSONRequestForClient);
    
    Engine::getInstance()->render();
}


void ofApp::close(){
    tcp.close();
    ipc.close();
}

//--------------------------------------------------------------
void ofApp::draw(){
    ofClear(0,0,0);
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
