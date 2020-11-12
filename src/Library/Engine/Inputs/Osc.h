//
//  Osc.h
//  VJApp
//
//  Created by Daniel Filipe Almeida on 11/05/15.
//
//

#ifndef __VJApp__Osc__
#define __VJApp__Osc__

#include <stdio.h>
#include "ofxOsc.h"




/*!
 @class Osc
 @abstract  Singleton Class to wrap OSC usage
 @discussion
 */
class Osc {
    ofxOscReceiver *oscReceiver;
    int _port;

public:
    
    static Osc* getInstance(int port);

    /*!
     @abstract Constructor
     @param port the osc port
     */
    Osc(int port);
    
    
    /*!
     @abstract Destructor
     */
    ~Osc();
    
    /*!
     @abstract Returns the current osc instance.
     @todo: REMOVE THIS. DO NOT USE SINGLETON PATTERN
     */
    static Osc *getOscInstance();
    
    /*!
     @abstract updates OSC 
     */
    void update();
    
    
    /*!
     @param msg input OSC message
     */
    void checkVisualTrigger(ofxOscMessage msg);
    
    /*!
     @param msg input OSC message
     @return the action string
     */
    std::string getVisualTriggerActionString(ofxOscMessage msg);
    
    /*!
     @param msg input OSC message
     @return the description string from an OSC message
     */
    std::string description(ofxOscMessage msg);
};

#endif /* defined(__VJApp__Osc__) */


