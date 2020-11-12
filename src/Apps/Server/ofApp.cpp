#include "ofApp.h"
#include "JsonLoad.hpp"
#include "Utils.h"
#include "Messages.hpp"
#include "zmq.h"




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

void ofApp::initTCPServer() {
    TCP.setup(serverPort);
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
                    // cout << "message sent: " << jsonResponse.dump(4) << endl;
                    
                    TCP.send(i, jsonResponse.dump());
                }
            }
        }
        lastSent = now;
    }
}


void ofApp::initIPC()
{
    void *context = zmq_ctx_new ();
    void *responder = zmq_socket (context, ZMQ_REP);
    int rc = zmq_bind (responder, "ipc:///tmp/arbutus-state");
    assert (rc == 0);
}

//--------------------------------------------------------------
void ofApp::setup(){
    initEngine();
    initTCPServer();
    initIPC();
}

//--------------------------------------------------------------
void ofApp::update(){
    updateTCPServer();
    
    
    Engine::getInstance()->render();
}


void ofApp::close(){
    TCP.close();
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
