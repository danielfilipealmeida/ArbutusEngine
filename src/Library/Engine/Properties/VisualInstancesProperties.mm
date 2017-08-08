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
    column = layer = 0;
    percentagePlayed = 0;
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


void VisualInstancesProperties::setLoopMode(LoopMode _loopMode) {
    loopMode = _loopMode;
}


LoopMode VisualInstancesProperties::getLoopMode() {
    return loopMode;
}


Boolean VisualInstancesProperties::getBeatSnap ()
{
    return beatSnap;
}

void VisualInstancesProperties::setBeatSnap (Boolean _val )
{
    beatSnap = _val;
}

int VisualInstancesProperties::getWidth () {
    return width; }
int VisualInstancesProperties::getHeight () {
    return height; }

float VisualInstancesProperties::getZoomX () {
    return zoomX; }
void VisualInstancesProperties::setZoomX (float _zoomX) {
    zoomX = _zoomX;
}

float VisualInstancesProperties::getZoomY () {
    return zoomY;
}
void VisualInstancesProperties::setZoomY (float _zoomY) {
    zoomY = _zoomY;
}

float VisualInstancesProperties::getCenterX() {
    return centerX;
}
float VisualInstancesProperties::getCenterY() {
    return centerY;
}
ofPoint VisualInstancesProperties::getCenter() {
    ofPoint point; point.x=centerX; point.y = centerY; return point;
}
void VisualInstancesProperties::setCenterX(float _centerX) {
    centerX = _centerX;
}
void VisualInstancesProperties::setCenterY(float _centerY) {
    centerY = _centerY;
}

int VisualInstancesProperties::getX () {
    return x;
}
int VisualInstancesProperties::getY () {
    return y;
}

int VisualInstancesProperties::getLayer () {
    return layer;
}
void VisualInstancesProperties::setLayer (int _layer) {
    layer = _layer;
}

int VisualInstancesProperties::getColumn () {
    return column;
}


void VisualInstancesProperties::setColumn (int _column) {
    column = _column;
}


Boolean VisualInstancesProperties::getRetrigger () {
    return retrigger;
}


void VisualInstancesProperties::setRetrigger (bool _retrigger) {
    retrigger = _retrigger;
}


Boolean VisualInstancesProperties::getIsPlaying() {
    return isPlaying;
}


void VisualInstancesProperties::setIsPlaying ( Boolean _isPlaying ) {
    isPlaying = _isPlaying;
}


float VisualInstancesProperties::getPercentagePlayed () {
    return percentagePlayed;
}


float VisualInstancesProperties::getStartPercentage () {
    return startPercentage;
}


float VisualInstancesProperties::getEndPercentage () {
    return endPercentage;
}


void VisualInstancesProperties::setPercentagePlayed ( float _val ) {
    percentagePlayed = ofClamp(_val, 0.0, 1.0);
}


void VisualInstancesProperties::setStartPercentage ( float _val ) {
    startPercentage = ofClamp(_val, 0.0, 1.0);
}


void VisualInstancesProperties::setEndPercentage ( float _val ) {
    endPercentage = ofClamp(_val, 0.0, 1.0);
}


PlayheadDirection VisualInstancesProperties::getDirection () {
    return direction;
}


void VisualInstancesProperties::setDirection ( PlayheadDirection _val ) {
    direction = _val;
}


Boolean VisualInstancesProperties::getIsTriggered () {
    return isTriggered;
}
void VisualInstancesProperties::setIsTriggered (Boolean _val ) {
    isTriggered = _val;
}

unsigned long long VisualInstancesProperties::getOpenedTimestamp () {
    return openedTimestamp;
}


unsigned long long VisualInstancesProperties::getLastPlayedTimestamp () {
    return lastPlayedTimestamp;
}


void VisualInstancesProperties::setOpenedTimestampToNow () {
    openedTimestamp = ofGetElapsedTimeMillis();
}


void VisualInstancesProperties::setLastPlayedTimestampToNow () {
    lastPlayedTimestamp = ofGetElapsedTimeMillis();
}


TriggerMode VisualInstancesProperties::getTriggerMode () {
    return triggerMode;
}


void VisualInstancesProperties::setTriggerMode ( TriggerMode _val ) {
    triggerMode = _val;
}


json VisualInstancesProperties::getState() {
    json state;
    
    state = Properties::getState();
    state["width"] = getWidth();
    state["height"] = getHeight();
    state["zoomX"] = getZoomX();
    state["zoomY"] = getZoomY();
    state["centerX"] = getCenterX();
    state["centerY"] = getCenterY();
    state["x"] = getX();
    state["y"] = getY();
    state["layer"] = getLayer();
    state["column"] = getColumn();
    state["retrigger"] = getRetrigger();
    state["isPlaying"] = getIsPlaying();
    state["percentagePlayed"] = getPercentagePlayed();
    state["startPercentage"] = getStartPercentage();
    state["endPercentage"] = getEndPercentage();
    state["effects_drywet"] = effects_drywet; // TODO: Make setter and getter
    state["loopMode"] = getLoopMode();
    state["direction"] = getDirection();
    state["beatSnap"] = getBeatSnap();
    state["isTriggered"] = getIsTriggered();
    state["openedTimestamp"] = getOpenedTimestamp();
    state["lastPlayedTimestamp"] = getLastPlayedTimestamp();
    state["triggerMode"] = getTriggerMode();
    
    
    return state;
    
}
