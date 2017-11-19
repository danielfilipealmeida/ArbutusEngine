#include "ofApp.h"
#include "Engine.h"
#include "JsonLoad.hpp"
#include "Utils.h"
#include "Messages.hpp"


void ofApp::initEngine() {
    Engine *engine = new Engine();
    string filePath = ofFilePath::getCurrentExeDir() + "../Resources/set.json";
    
    try {
        engine->openSet(filePath);
    }
    catch (string &exception) {
        cout << "Error: " << exception << endl;
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

void ofApp::initTCPServer() {
    TCP.setup(8080);
    TCP.setMessageDelimiter("\n");
    lastSent = 0;
}

void ofApp::updateTCPServer() {
    uint64_t now = ofGetElapsedTimeMillis();
    if(now - lastSent >= 100){
        for(int i = 0; i < TCP.getLastID(); i++){
            if( !TCP.isClientConnected(i) ) continue;
            
            string str = TCP.receive(i);
            if( str.length() > 0 ) {
                json jsonRequest = json::parse(str);
                json jsonResponse;
                
                if (jsonRequest.is_object()) {
                    try {
                        jsonResponse = handleJSONRequestForClient(jsonRequest);
                    }
                    catch (std::exception &e) {
                        jsonResponse = {
                            {"success", false},
                            {"message", e.what()},
                            {"data", {}}
                        };
                    }
                     TCP.send(i, jsonResponse.dump());
                }
            }
        }
        lastSent = now;
    }
}


//--------------------------------------------------------------
void ofApp::setup(){
    initEngine();
    initTCPServer();
}

//--------------------------------------------------------------
void ofApp::update(){
    updateTCPServer();
    
    
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
