//
//  Osc.cpp
//  VJApp
//
//  Created by Daniel Filipe Almeida on 11/05/15.
//
//

#include "Osc.h"
#include "AppProtocol.h"
#include "Engine.h"

#include <assert.h>
#include <string>



Osc             *oscInstance = NULL;
extern Engine *_engine;

Osc::Osc(int port) {
     if (oscInstance != NULL) return oscInstance;
    
    _port       = port;
    oscInstance = this;
    try {
        oscReceiver = new ofxOscReceiver();
        oscReceiver->setup(port);
    }
    catch (std::runtime_error err) {
        /*
        NSException *e = [NSException raise:@"OSC" format:@"%s", err.what()];
        @throw e;
         */
        //throw(err);
        //cout << err.what()<<endl;
        NSException *e = [NSException exceptionWithName:@"OSC exception" reason:[NSString stringWithFormat:@"%s", err.what()] userInfo:nil];
        [e raise];
        return;
    }
}

Osc::~Osc() {
    oscInstance = NULL;
    _port = 0;
    delete oscReceiver;
    
}

Osc *Osc::getOscInstance() {
    return oscInstance;
}


void Osc::update() {
    while (oscReceiver->hasWaitingMessages()) {
        ofxOscMessage msg;
        oscReceiver->getNextMessage(&msg);
        
        checkVisualTrigger(msg);
        
        cout << description(msg) << endl;
    }
}

void Osc::checkVisualTrigger(ofxOscMessage msg) {
    int layer, column;
    
    if (msg.getAddress() != "/trigger/visual") return;
    
    
    // TODO: make a callback to run this
    //_engine->getApp()->newOscMessage(getVisualTriggerActionString(msg));
}


string Osc::getVisualTriggerActionString(ofxOscMessage msg) {
    int layer = msg.getArgAsInt32(0);
    int column = msg.getArgAsInt32(1);
    
    char buffer[50];
    int n = sprintf (buffer, "%s/%i/%i", msg.getAddress().c_str(), layer, column);
    std::string theString = buffer;
    
    return theString;
    //return msg.getAddress() + "/" + std::to_string(layer) + "/" + std::to_string(column);
}



string Osc::description(ofxOscMessage msg) {
    string msg_string;
    msg_string = msg.getAddress();
    msg_string += ": ";
    for(int i = 0; i < msg.getNumArgs(); i++){
        // get the argument type
        msg_string += msg.getArgTypeName(i);
        msg_string += ":";
        // display the argument - make sure we get the right type
        if(msg.getArgType(i) == OFXOSC_TYPE_INT32){
            msg_string += ofToString(msg.getArgAsInt32(i));
        }
        else if(msg.getArgType(i) == OFXOSC_TYPE_FLOAT){
            msg_string += ofToString(msg.getArgAsFloat(i));
        }
        else if(msg.getArgType(i) == OFXOSC_TYPE_STRING){
            msg_string += msg.getArgAsString(i);
        }
        else{
            msg_string += "unknown";
        }
    }
    return msg_string;
}