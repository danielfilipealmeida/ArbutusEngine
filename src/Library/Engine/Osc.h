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
 Singleton Class to wrap OSC usage
 */

class Osc {
    ofxOscReceiver *oscReceiver;
    int _port;
public:

    /*!
     
     */

    Osc(int port);
    
    
    /*!
     
     */

    ~Osc();
    
    
    /*!
     
     */
    
    static  Osc *getOscInstance();
    
    
    /*!
     
     */

    void    update();
    
    
    /*!
     
     */

    void    checkVisualTrigger(ofxOscMessage msg);
    
    
    
    /*!
     
     */

    string  getVisualTriggerActionString(ofxOscMessage msg);
    
    
    /*!
     
     */
    
    string  description(ofxOscMessage msg);
};

#endif /* defined(__VJApp__Osc__) */


