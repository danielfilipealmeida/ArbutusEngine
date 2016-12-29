/*
 *  VisualInstancesProperties.mm
 *  VJingApp
 *
 *  Created by Daniel Almeida on 12/24/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#include "VisualInstancesProperties.h"
#include "Engine.h"

extern Engine *enginePtr;

VisualInstancesProperties::VisualInstancesProperties() {
	width = 640; height = 480;
    reset();
}


void
VisualInstancesProperties::reset() {
    zoomX = zoomY = 1;
    centerX = 0.0; centerY = 0.0;
    x =0; y = 0;
    retrigger = true;
    effects_drywet = 0.5;
    isPlaying = false;
    startPercentage = 0.0;
    endPercentage = 1.0;
    loopMode = LoopMode_Normal;
    direction = Direction_Left;
    beatSnap = isTriggered = false;
    triggerMode = TriggerMode_MouseDown;
}

VisualInstancesProperties::~VisualInstancesProperties() {
    //return enginePtr->getPropertiesOfCurrentVisualInstance();
}


VisualInstancesProperties *VisualInstancesProperties::getCurrent() {
    return enginePtr->getPropertiesOfCurrentVisualInstance();
}


void VisualInstancesProperties::print() {
	Properties::print();
	
    cout << "      width: " << width << endl;
    cout << "     height: " << height <<endl;
	cout << "center(X,Y): " << centerX <<", "<<centerY<<endl;
	cout << "      (x,y): " << x <<", "<<y<<endl;
	cout << "      layer: " << layer <<endl;
	cout << "     column: " << column <<endl;
    cout << "  rettriger: "; retrigger==true ? cout << "YES":cout << "NO"; cout << endl;
    cout << " fx dry/wet: " << effects_drywet <<endl;
    cout << "    playing: "; isPlaying==true ? cout << "YES":cout << "NO"; cout << endl;
    cout << "    start %: " << startPercentage <<endl;
    cout << "      end %: " << endPercentage <<endl;
    cout << "  loop mode: " << loopMode <<endl;
    cout << "  direction: " << direction <<endl;
    cout << "  beat snap: "; beatSnap==true ? cout << "YES":cout << "NO"; cout << endl;
    cout << "  triggered: "; isTriggered==true ? cout << "YES":cout << "NO"; cout << endl;
    cout << " trig. mode: " << triggerMode <<endl;
}



/**************************/

#pragma mark getters and setters

Boolean VisualInstancesProperties::getBeatSnap ()
{
    return beatSnap;
}

void VisualInstancesProperties::setBeatSnap (Boolean _val )
{
    beatSnap = _val;
}
