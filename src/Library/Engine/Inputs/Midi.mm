//
//  Midi.cpp
//  VJApp
//
//  Created by Daniel Filipe Almeida on 09/05/15.
//
//

#include "Midi.h"
#include "AppProtocol.h"

#include <assert.h>
#include <string>


Midi *midiInstance = NULL;


// this is a singleton Class



Midi *Midi::getMidiInstance() {
    return midiInstance;
}


Midi *Midi::getInstance(int port) {
    if (midiInstance == NULL) midiInstance = new Midi(port);
    
    return midiInstance;
}


Midi::Midi(int port) {
    //if (midiInstance != NULL) return midiInstance;
    
    midiIn.openPort(port);
    //midiIn.ignoreTypes(false,false,false);
    midiIn.addListener(this);
    midiIn.setVerbose(true);
    midiInstance = this;
    _port = port;
}


Midi::~Midi() {
    midiIn.closePort();
    midiIn.removeListener(this);
    _port = NULL;
    midiInstance = NULL;
    
}


void Midi::list() {
    ofxMidiIn _midiIn;
    _midiIn.listInPorts();
    
}

int Midi::getNumPorts() {
    ofxMidiIn _midiIn;
    return _midiIn.getNumInPorts();
}

string Midi::getPortName(unsigned int portNumber) {
    ofxMidiIn _midiIn;
    return _midiIn.getInPortName(portNumber);
}


void Midi::newMidiMessage(ofxMidiMessage& msg) {
    midiMessage = msg;
    print();
    
    // keys
    if (midiMessage.status == 144)
    {
        _val = keyNames[(unsigned int) midiMessage.bytes[1]];
    }
    
    // knobs
    if (midiMessage.status == 176)
    {
        std::string s;
        std::stringstream out;
        out << midiMessage.control;
        s = out.str();
        _val = "code "+s;
    }
    
    //TODO: send a message to the app. The code is on an old version
    //app->newMidiMessage (getActionString(msg));
}


string Midi::getActionString(ofxMidiMessage &message) {
    
    char buffer[50];
    int n = sprintf (buffer, "%i C%i %s", midiInstance->port(), message.channel, midiInstance->_val.c_str());
    std::string theString = buffer;
    
    return theString;
}

string Midi::keyName (int val) {
    assert (val >= 0);
    assert (val < sizeof(midiInstance->keyNames));
    
    return midiInstance->keyName(val);
}


void Midi::print() {
    cout << "Received. Status: " << midiMessage.status << "(" << ofxMidiMessage::getStatusString(midiMessage.status) << ")";

    cout << " channel: " << midiMessage.channel;
    cout << " pitch: " << midiMessage.pitch;
    cout << " velocity: " << midiMessage.velocity;
    cout << " control: " << midiMessage.control;
    cout << " value: " << (unsigned int) midiMessage.value;
    cout << " bytes: " << (unsigned int) midiMessage.bytes[1];
    cout << " delta: " << midiMessage.deltatime;
    cout << " portNum: " << midiMessage.portNum;
    cout << " portName: " << midiMessage.portName;

    cout << endl << endl;
}


