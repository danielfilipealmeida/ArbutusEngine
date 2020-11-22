#include "ofApp.h"
#include "JsonLoad.hpp"
#include "Utils.h"
#include "Messages.hpp"
#include "IPC.h"
#include <iostream>
#include <filesystem>


//--------------------------------------------------------------
void ofApp::setup(){
    gui.setup();
    
    tcpEnabled.addListener(this, &ofApp::tcpEnabledChanged);
    ipcEnabled.addListener(this, &ofApp::ipcEnabledChanged);
    
    gui.add(tcpEnabled.set("TCP", false));
    gui.add(ipcEnabled.set("IPC", false));
    
    gui.add(pingButton.setup("Ping"));
    pingButton.addListener(this, &::ofApp::handlePingButton);
    
    logs = Logs::getInstance();
}

//--------------------------------------------------------------
void ofApp::update(){
    
}


void ofApp::close(){
}

//--------------------------------------------------------------
void ofApp::draw(){
    ofClear(0,0,0);
    gui.draw();
    
    unsigned int x=250, y=0, lineHeight=30;
    unsigned int count = 0;
    ofSetColor(255, 255, 255);
    logs->forEach([&](std::string log){
        ofDrawBitmapString(log, x, y + (count + 1) * lineHeight);
        count++;
    });
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


#pragma mark Listeners


void ofApp::tcpEnabledChanged(bool & value) {
}

void ofApp::ipcEnabledChanged(bool & value) {
    value ? ipc.connect(URI) : ipc.close();
}

void ofApp::handlePingButton() {
    ipc.send(PING_MESSAGE.dump(4));
    
}
