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
#include "Utils.h"

extern Engine *enginePtr;

VisualInstancesProperties::VisualInstancesProperties() {
    reset();
    setLimits();
}


void VisualInstancesProperties::reset() {
    zoomX = zoomY = 1;
    centerX = 0.0; centerY = 0.0;
    x = 0; y = 0; // limits? is this actually used?
    retrigger = true;
    effects_drywet = 0.5;
    isPlaying = false;
    startPercentage = 0.0;
    endPercentage = 1.0;
    percentagePlayed = 0.0;
    
    loopMode = LoopMode_Normal;
    direction = Direction_Left;
    
    beatSnap = isTriggered = false;
    triggerMode = TriggerMode_MouseDown;
    
    column = layer = 0;
}

void VisualInstancesProperties::setLimits() {
    floatPropertiesLimitsVisualInstances.insert(std::pair<string, floatLimits>("zoomX", {0.0, 8.0}));
    floatPropertiesLimitsVisualInstances.insert(std::pair<string, floatLimits>("zoomY", {0.0, 8.0}));

    floatPropertiesLimitsVisualInstances.insert(std::pair<string, floatLimits>("centerX", {-2.0, 2.0}));
    floatPropertiesLimitsVisualInstances.insert(std::pair<string, floatLimits>("centerY", {-2.0, 2.0}));

    floatPropertiesLimitsVisualInstances.insert(std::pair<string, floatLimits>("startPercentage", {0.0, 1.0}));
    floatPropertiesLimitsVisualInstances.insert(std::pair<string, floatLimits>("endPercentage", {0.0, 1.0}));
    floatPropertiesLimitsVisualInstances.insert(std::pair<string, floatLimits>("percentagePlayed", {0.0, 1.0}));
    
    floatPropertiesLimitsVisualInstances.insert(std::pair<string, floatLimits>("effects_drywet", {0.0, 1.0}));



}

VisualInstancesProperties::~VisualInstancesProperties() {
}




void VisualInstancesProperties::print() {
	Properties::print();
	
    cout << "      width: " << getWidth() << endl;
    cout << "     height: " << getHeight() <<endl;
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


/*
int VisualInstancesProperties::getWidth () {
    return width;
}

int VisualInstancesProperties::getHeight () {
    return height;
    
}
*/

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
    /*
    startPercentage = ofClamp(_val, 0.0, 1.0);
    if (startPercentage > endPercentage) {
        startPercentage = endPercentage;
    }
     */
    startPercentage = (startPercentage <= endPercentage) ? ofClamp(_val, 0.0, 1.0) : endPercentage;
}


void VisualInstancesProperties::setEndPercentage ( float _val ) {
    endPercentage = ofClamp(_val, 0.0, 1.0);
    if (endPercentage < startPercentage) {
        endPercentage = startPercentage;
    }
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


float VisualInstancesProperties::getEffectMix() {
    return effects_drywet;
}

void VisualInstancesProperties::setEffectMix(float _val) {
    effects_drywet = ofClamp(_val, floatPropertiesLimitsVisualInstances["effects_drywet"].min, floatPropertiesLimitsVisualInstances["effects_drywet"].max);
}

json VisualInstancesProperties::getState() {
    json state;
    
    state = Properties::getState();
    state = SizeProperties::getState(state);
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

json VisualInstancesProperties::getFullState() {
    json fullState;
    
    fullState = Properties::getFullState();

    fullState = SizeProperties::getFullState(fullState);
    fullState["zoomX"] =  {
        {"title", "Zoom X"},
        {"type", Utils::getStateTypeForTypeidName(typeid(zoomX).name())},
        {"value", getZoomX()},
        {"min", floatPropertiesLimitsVisualInstances["zoomX"].min},
        {"max", floatPropertiesLimitsVisualInstances["zoomX"].max}
    };
    fullState["zoomY"] =  {
        {"title", "Zoom Y"},
        {"type", Utils::getStateTypeForTypeidName(typeid(zoomY).name())},
        {"value", getZoomY()},
        {"min", floatPropertiesLimitsVisualInstances["zoomY"].min},
        {"max", floatPropertiesLimitsVisualInstances["zoomY"].max}
    };
    
    fullState["centerX"] =  {
        {"title", "Center X"},
        {"type", Utils::getStateTypeForTypeidName(typeid(centerX).name())},
        {"value", getCenterX()},
        {"min", floatPropertiesLimitsVisualInstances["centerX"].min},
        {"max", floatPropertiesLimitsVisualInstances["centerX"].max}
    };
    fullState["centerY"] =  {
        {"title", "Center Y"},
        {"type", Utils::getStateTypeForTypeidName(typeid(centerY).name())},
        {"value", getCenterY()},
        {"min", floatPropertiesLimitsVisualInstances["centerY"].min},
        {"max", floatPropertiesLimitsVisualInstances["centerY"].max}
    };
    
    fullState["startPercentage"] =  {
        {"title", "Start"},
        {"type", Utils::getStateTypeForTypeidName(typeid(startPercentage).name())},
        {"value", getStartPercentage()},
        {"min", floatPropertiesLimitsVisualInstances["startPercentage"].min},
        {"max", floatPropertiesLimitsVisualInstances["startPercentage"].max}
    };
    fullState["endPercentage"] =  {
        {"title", "End"},
        {"type", Utils::getStateTypeForTypeidName(typeid(endPercentage).name())},
        {"value", getEndPercentage()},
        {"min", floatPropertiesLimitsVisualInstances["endPercentage"].min},
        {"max", floatPropertiesLimitsVisualInstances["endPercentage"].max}
    };
    fullState["percentagePlayed"] =  {
        {"title", "Percentage Played"},
        {"type", Utils::getStateTypeForTypeidName(typeid(percentagePlayed).name())},
        {"value", getPercentagePlayed()},
        {"min", floatPropertiesLimitsVisualInstances["percentagePlayed"].min},
        {"max", floatPropertiesLimitsVisualInstances["percentagePlayed"].max}
    };

    fullState["effects_drywet"] =  {
        {"title", "Dry/Wet"},
        {"type", Utils::getStateTypeForTypeidName(typeid(effects_drywet).name())},
        {"value", getEffectMix()},
        {"min", floatPropertiesLimitsVisualInstances["effects_drywet"].min},
        {"max", floatPropertiesLimitsVisualInstances["effects_drywet"].max}
    };

    fullState["loopMode"] =  {
        {"title", "Loop Mode"},
        {"type", StateType_ToggleButtonGroup},
        {"value", getLoopMode()},
        {"options",
            {
                {
                    {"title", "Normal"},
                    {"value", LoopMode_Normal}
                },
                {
                    {"title", "Ping Pong"},
                    {"value", LoopMode_PingPong}
                },
                {
                    {"title", "Inverse"},
                    {"value", LoopMode_Inverse}
                }
            }
        }
    };
    fullState["direction"] =  {
        {"title", "Direction"},
        {"type", StateType_ToggleButtonGroup},
        {"value", getDirection()},
        {"options",
            {
                {
                    {"title", "Left"},
                    {"value", Direction_Left}
                },
                {
                    {"title", "Right"},
                    {"value", Direction_Right}
                }
            }
        }
    };
    fullState["triggerMode"] =  {
        {"title", "Trigger Mode"},
        {"type", StateType_ToggleButtonGroup},
        {"value", getTriggerMode()},
        {"options",
            {
                {
                    {"title", "Mouse Down"},
                    {"value", TriggerMode_MouseDown}
                },
                {
                    {"title", "Mouse Up"},
                    {"value", TriggerMode_MouseUp}
                },
                {
                    {"title", "Piano"},
                    {"value", TriggerMode_Piano}
                }
            }
        }
    };
        
    return fullState;
}

void VisualInstancesProperties::set(string property, float value) {
    Properties::set(property, value);
    switch (str2int(property.c_str())) {
        case str2int("zoomX"):
            setZoomX(value);
            break;
        case str2int("zoomY"):
            setZoomY(value);
            break;
        case str2int("centerX"):
            setCenterX(value);
            break;
        case str2int("centerY"):
            setCenterY(value);
            break;
        case str2int("percentagePlayed"):
            setPercentagePlayed(value);
            break;
        case str2int("startPercentage"):
            setStartPercentage(value);
            break;
        case str2int("endPercentage"):
            setEndPercentage(value);
            break;
        case str2int("effects_drywet"):
            setEffectMix(value);
            break;
       
    }
}

void VisualInstancesProperties::set(string property, unsigned int value) {
    switch (str2int(property.c_str())) {
        case str2int("direction"):
            setDirection((PlayheadDirection) value);
            break;
        case str2int("loopMode"):
            setLoopMode((LoopMode) value);
            break;
        case str2int("triggerMode"):
            setTriggerMode((TriggerMode) value);
            break;
    }
}
