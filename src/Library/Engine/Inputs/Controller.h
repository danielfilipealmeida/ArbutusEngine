/*
 *  Controller.h
 *  ARBUTUS
 *
 *  Created by Daniel Almeida on 7/16/10.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */


#ifndef __CONTROLLER_H__
#define __CONTROLLER_H__

//#include "GUIElement.h"
#include "ofxMidi.h"
#include "Action.h"


/*!
 The types of controls available
 */
typedef enum
{
	KeyController = 0,
	MIDIController,
	SignalController
} ControllerType;


/*!
 @class AppProtocol
 @abstract  class that defines the basic data and functionality of controller Objects
 @discussion
 */
class Controller
{
    ControllerType  type;
    int             control;
    int             value;		// value or midi byteTwo
    int             midiStatus; // midi status. 144 - key; 176 - controler; 224 - pitch blend wheel; 192 - program change
    
    Action          *action;
    
public:

    Controller(ControllerType _type, int _control);
    ~Controller();

    
	void (*callback)(Controller *controller);
	void setCallback(void (*_callback)(Controller *controller));
    
	
	std::string getControlString();
	std::string getConfigFolder();
	
	/* debug */
	void printInfo();
    
    
    /** getters and setters **/
    ControllerType getType () { return type; }
    
    int getControl () { return control; }
    
    int getValue ();
    void setValue(int _value);
    
    int getMidiStatus () { return midiStatus; }
    
    
    
    // actions
    void setAction(Action *_action);
    bool runAction();
};



typedef std::vector<Controller *> Controllers;
typedef Controllers::iterator ControllersIterator;

void printControllerListInfo(Controllers controllerList);


class ControllerGroup
{
	Controllers     controllers;
    Boolean         isAllocated ;

public:
	
	ControllerGroup();
	~ControllerGroup();
    
    void initDefaultControllers();
	
	void addController(Controller *controller);
	void handleControllers();

	void handleKeyboardControllers(int key);
	void handleMIDIController(ofxMidiMessage& eventArgs);
	void print();
	
	int getRecordNum();
	
	Controller *getRecord(int recordNum);
	
	/* debug */
	void printInfo();
};


std::string getMIDIKeyName(int position);

#endif
