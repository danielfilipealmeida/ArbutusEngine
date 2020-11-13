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


void ofApp::initIPC()
{
    void *context = zmq_ctx_new ();
    void *responder = zmq_socket (context, ZMQ_REP);
    int rc = zmq_bind (responder, "ipc:///tmp/arbutus-state");
    assert (rc == 0);
    
    // the following needs to go in a thread
    /*
    while (1) {
        char buffer [10];
        zmq_recv (responder, buffer, 10, 0);
        printf ("Received Hello\n");
        sleep (1);          //  Do some 'work'
        zmq_send (responder, "World", 5, 0);
    }
    return 0;
     */
}

//--------------------------------------------------------------
void ofApp::setup(){
    initEngine();
    tcp.init(DEFAULT_TCP_PORT);
    initIPC();
}

//--------------------------------------------------------------
void ofApp::update(){
    //updateTCPServer();
    tcp.update(handleJSONRequestForClient);
    
    Engine::getInstance()->render();
}


void ofApp::close(){
    tcp.close();
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
