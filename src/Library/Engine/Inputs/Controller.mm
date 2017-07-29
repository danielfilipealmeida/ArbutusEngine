/*
 *  Controller.cpp
 *  ARBUTUS
 *
 *  Created by Daniel Almeida on 7/16/10.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */

#include "Controller.h"
#include "Engine.h"


//Engine *enginePtr;

vector<string> MIDIKeysNames;

void setUpMIDIKeysNames()
{
	//MIDIKeysNames[0] = "C-3";
	//MIDIKeysNames[1] = "C-3#";
	MIDIKeysNames.push_back("C-2");
	MIDIKeysNames.push_back("C#-2");
	MIDIKeysNames.push_back("D-2");
	MIDIKeysNames.push_back("D#-2");
	MIDIKeysNames.push_back("E-2");
	MIDIKeysNames.push_back("F-2");
	MIDIKeysNames.push_back("F#-2");
	MIDIKeysNames.push_back("G-2");
	MIDIKeysNames.push_back("G#-2");
	MIDIKeysNames.push_back("A-2");
	MIDIKeysNames.push_back("A#-2");
	MIDIKeysNames.push_back("B-2");

	MIDIKeysNames.push_back("C-1");
	MIDIKeysNames.push_back("C#-1");
	MIDIKeysNames.push_back("D-1");
	MIDIKeysNames.push_back("D#-1");
	MIDIKeysNames.push_back("E-1");
	MIDIKeysNames.push_back("F-1");
	MIDIKeysNames.push_back("F#-1");
	MIDIKeysNames.push_back("G-1");
	MIDIKeysNames.push_back("G#-1");
	MIDIKeysNames.push_back("A-1");
	MIDIKeysNames.push_back("A#-1");
	MIDIKeysNames.push_back("B-1");

	MIDIKeysNames.push_back("C0");
	MIDIKeysNames.push_back("C#0");
	MIDIKeysNames.push_back("D0");
	MIDIKeysNames.push_back("D#0");
	MIDIKeysNames.push_back("E0");
	MIDIKeysNames.push_back("F0");
	MIDIKeysNames.push_back("F#0");
	MIDIKeysNames.push_back("G0");
	MIDIKeysNames.push_back("G#0");
	MIDIKeysNames.push_back("A0");
	MIDIKeysNames.push_back("A#0");
	MIDIKeysNames.push_back("B0");

	MIDIKeysNames.push_back("C1");
	MIDIKeysNames.push_back("C#1");
	MIDIKeysNames.push_back("D1");
	MIDIKeysNames.push_back("D#1");
	MIDIKeysNames.push_back("E1");
	MIDIKeysNames.push_back("F1");
	MIDIKeysNames.push_back("F#1");
	MIDIKeysNames.push_back("G1");
	MIDIKeysNames.push_back("G#1");
	MIDIKeysNames.push_back("A1");
	MIDIKeysNames.push_back("A#1");
	MIDIKeysNames.push_back("B1");
	
	MIDIKeysNames.push_back("C2");
	MIDIKeysNames.push_back("C#2");
	MIDIKeysNames.push_back("D2");
	MIDIKeysNames.push_back("D#2");
	MIDIKeysNames.push_back("E2");
	MIDIKeysNames.push_back("F2");
	MIDIKeysNames.push_back("F#2");
	MIDIKeysNames.push_back("G2");
	MIDIKeysNames.push_back("G#2");
	MIDIKeysNames.push_back("A2");
	MIDIKeysNames.push_back("A#2");
	MIDIKeysNames.push_back("B2");

	MIDIKeysNames.push_back("C3");
	MIDIKeysNames.push_back("C#3");
	MIDIKeysNames.push_back("D3");
	MIDIKeysNames.push_back("D#3");
	MIDIKeysNames.push_back("E3");
	MIDIKeysNames.push_back("F3");
	MIDIKeysNames.push_back("F#3");
	MIDIKeysNames.push_back("G3");
	MIDIKeysNames.push_back("G#3");
	MIDIKeysNames.push_back("A3");
	MIDIKeysNames.push_back("A#3");
	MIDIKeysNames.push_back("B3");

	MIDIKeysNames.push_back("C4");
	MIDIKeysNames.push_back("C#4");
	MIDIKeysNames.push_back("D4");
	MIDIKeysNames.push_back("D#4");
	MIDIKeysNames.push_back("E4");
	MIDIKeysNames.push_back("F4");
	MIDIKeysNames.push_back("F#4");
	MIDIKeysNames.push_back("G4");
	MIDIKeysNames.push_back("G#4");
	MIDIKeysNames.push_back("A4");
	MIDIKeysNames.push_back("A#4");
	MIDIKeysNames.push_back("B4");

	MIDIKeysNames.push_back("C5");
	MIDIKeysNames.push_back("C#5");
	MIDIKeysNames.push_back("D5");
	MIDIKeysNames.push_back("D#5");
	MIDIKeysNames.push_back("E5");
	MIDIKeysNames.push_back("F5");
	MIDIKeysNames.push_back("F#5");
	MIDIKeysNames.push_back("G5");
	MIDIKeysNames.push_back("G#5");
	MIDIKeysNames.push_back("A5");
	MIDIKeysNames.push_back("A#5");
	MIDIKeysNames.push_back("B5");

	MIDIKeysNames.push_back("C6");
	MIDIKeysNames.push_back("C#6");
	MIDIKeysNames.push_back("D6");
	MIDIKeysNames.push_back("D#6");
	MIDIKeysNames.push_back("E6");
	MIDIKeysNames.push_back("F6");
	MIDIKeysNames.push_back("F#6");
	MIDIKeysNames.push_back("G6");
	MIDIKeysNames.push_back("G#6");
	MIDIKeysNames.push_back("A6");
	MIDIKeysNames.push_back("A#6");
	MIDIKeysNames.push_back("B6");

	MIDIKeysNames.push_back("C7");
	MIDIKeysNames.push_back("C#7");
	MIDIKeysNames.push_back("D7");
	MIDIKeysNames.push_back("D#7");
	MIDIKeysNames.push_back("E7");
	MIDIKeysNames.push_back("F7");
	MIDIKeysNames.push_back("F#7");
	MIDIKeysNames.push_back("G7");
	MIDIKeysNames.push_back("G#7");
	MIDIKeysNames.push_back("A7");
	MIDIKeysNames.push_back("A#7");
	MIDIKeysNames.push_back("B7");
	
	MIDIKeysNames.push_back("C8");
	MIDIKeysNames.push_back("C#8");
	MIDIKeysNames.push_back("D8");
	MIDIKeysNames.push_back("D#8");
	MIDIKeysNames.push_back("E8");
	MIDIKeysNames.push_back("F8");
	MIDIKeysNames.push_back("F#8");
	MIDIKeysNames.push_back("G8");
	
}

string getMIDIKeyName(int position)
{
	if(MIDIKeysNames.empty()) setUpMIDIKeysNames();
	return MIDIKeysNames[position];
}
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


Controller::Controller(ControllerType _type, int _control)
{
	type        = _type;
	control     = _control;
	callback    = NULL;
    action      = NULL;
}

Controller::~Controller()
{
}


/*
void Controller::setControlledElement(GUIElement *_element)
{
	element = _element;
}
*/


int Controller::getValue()
{
	return value;
}

void Controller::setValue(int _value)
{
	value = _value;
}


void Controller::setCallback(void (*_callback)(Controller *controller)) {
	callback=_callback;
}


/*
void Controller::setCallback(void (*_callback)(GUIElement *element)) {
	GUIcallback = _callback;
	
}
*/

string Controller::getControlString() {
	string val;
	switch (type) {
		case KeyController:
			char asciiChar[1];
			sprintf(asciiChar, "%c", (char) control);
			val = asciiChar;
			 break;
		
		case MIDIController:
			if(MIDIKeysNames.empty()) setUpMIDIKeysNames();
			
			// keys
			if (midiStatus == 144)
			{
				val = MIDIKeysNames[control];
			}
			
			// knobs
			if (midiStatus == 176)
			{
				std::string s;
				std::stringstream out;
				out << control;
				s = out.str();
				val = "code "+s;
			}
			break;

		case SignalController:
			break;

			
		default:
			break;
	}
	return val;
}

void Controller::printInfo() {
	cout << "Control Type: ";
	if (type == 0) cout << "Key";
	if (type == 1) cout << "MIDI";
	if (type == 2) cout << "Signal";
	cout << endl;
	cout << "Control: "<<control<<endl;
	cout << "Value: "<<value<<endl;
	cout << "Midi Status: "<< midiStatus<<endl;
	//cout << "Element Address: "<<element<<endl;
}


void Controller::setAction(Action *_action) {
    action = _action;
}


bool Controller::runAction() {
    if (action == NULL) return false;
    
    return action->run();
}


void printControllerListInfo(Controllers controllerList) {
	for (ControllersIterator i=controllerList.begin();i<controllerList.end();i++) {
		Controller *controller = *i;
		controller->printInfo();
	}
}




///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


ControllerGroup::ControllerGroup()
{
	isAllocated = true;
}

ControllerGroup::~ControllerGroup()
{
	
}


void ControllerGroup::initDefaultControllers() {
    typedef struct {
        int layer, column;
    } visualLocation;
    
    map<int, visualLocation> triggerKeys;
    map<int, int> layerKeys;

    
    // layer 0
    triggerKeys[12].layer   = 0;    //q
    triggerKeys[12].column  = 1;
    triggerKeys[13].layer   = 0;    //w
    triggerKeys[13].column  = 2;
    triggerKeys[14].layer   = 0;    //e
    triggerKeys[14].column  = 3;
    triggerKeys[15].layer   = 0;    //r
    triggerKeys[15].column  = 4;
    
    // layer 1
    triggerKeys[0].layer    = 1;    //A
    triggerKeys[0].column   = 1;
    triggerKeys[1].layer    = 1;    //S
    triggerKeys[1].column   = 2;
    triggerKeys[2].layer    = 1;    //D
    triggerKeys[2].column   = 3;
    triggerKeys[3].layer    = 1;    //E
    triggerKeys[3].column   = 4;

    
    // layer 2
    triggerKeys[50].layer   = 2;    //<
    triggerKeys[50].column  = 1;
    triggerKeys[6].layer    = 2;    //z
    triggerKeys[6].column   = 2;
    triggerKeys[7].layer    = 2;    //x
    triggerKeys[7].column   = 3;
    triggerKeys[8].layer    = 2;    //c
    triggerKeys[8].column   = 4;

    
    Controller *controller;
    
    for (map<int, visualLocation>::iterator i=triggerKeys.begin();
         i!=triggerKeys.end();
         ++i) {
        controller = new Controller(KeyController, (*i).first);
        controller->setAction(Action::newTriggerVisualAction((*i).second.layer,
                                                             (*i).second.column));
        addController(controller);
    }

    // layer keys
    layerKeys[18] = 1;
    layerKeys[19] = 2;
    layerKeys[20] = 3;
    layerKeys[21] = 4;
    

    for (map<int, int>::iterator i=layerKeys.begin();
         i!=layerKeys.end();
         ++i) {
        controller = new Controller(KeyController, (*i).first);
        controller->setAction(Action::newChangeLayerAction((*i).second));
        addController(controller);
    }

}

void ControllerGroup::addController(Controller *controller){
	isAllocated=false;
	controllers.push_back(controller);
}


void ControllerGroup::handleControllers() {


}

void ControllerGroup::handleKeyboardControllers(int key) {
	for (ControllersIterator i = controllers.begin(); i!=controllers.end(); i++){
		Controller *controller = (*i);
		if (controller->getType() == KeyController){
			if (key == controller->getControl ()){
                /*
                if (controller->action!=NULL) {
                    controller->action->run();
                    return;
                }
                */
                
                if (controller->runAction() == true) return;
				if (controller->callback!=NULL) {
					controller->callback(controller);
				}
            }
		}
	}
}


void ControllerGroup::handleMIDIController(ofxMidiMessage& eventArgs)
{
    int byteOne, byteTwo, channel, port, status;
    
	byteOne = eventArgs.value;      // key/controler number
	byteTwo = eventArgs.control;	// weight/controler value
	channel = eventArgs.channel;
	port    = eventArgs.portNum;
	status  = eventArgs.status;		// 144 - key; 176 - controler; 224 - pitch blend wheel; 192 - program change
	//double timestamp = eventArgs.timestamp;
	
	for (ControllersIterator i = controllers.begin();
		 i!=controllers.end();
		 i++)
    {
		Controller *controller = (*i);
		if (controller->getType() == MIDIController){
			if (byteOne == controller->getControl() && status == controller->getMidiStatus () ) {
				if (controller->callback!=NULL) controller->callback(controller);
            }
		}
	}
}


void ControllerGroup::print()
{

}

Controller *ControllerGroup::getRecord(int recordNum)
{
	return controllers[recordNum];
}

int ControllerGroup::getRecordNum()
{
	//if (isAllocated==0) return 0;
	return (controllers.size());
}


void ControllerGroup::printInfo() {
	printControllerListInfo(controllers);
}
