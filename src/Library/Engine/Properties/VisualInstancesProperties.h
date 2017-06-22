/*
 *  VisualInstancesProperties.h
 *  VJingApp
 *
 *  Created by Daniel Almeida on 12/24/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */



#ifndef __VISUALINSTANCESPROPERTIES_H__
#define __VISUALINSTANCESPROPERTIES_H__


#include "Properties.h"


typedef enum {
	LoopMode_Normal = 1,
	LoopMode_PingPong = 2,
	LoopMode_Inverse = 3
} LoopMode;

typedef enum {
	Direction_Left=1,
	Direction_Right
} PlayheadDirection;


typedef enum {
    TriggerMode_MouseDown = 1,
    TriggerMode_MouseUp,
    TriggerMode_Piano
} TriggerMode;



/*!
 @class VisualInstancesProperties
 @abstract
 @discussion
 */
class VisualInstancesProperties : public Properties {
    int     width, height;
    float   zoomX, zoomY;
    float   centerX, centerY;
    int     x, y;
    int     layer;
    int     column;
    Boolean retrigger;
    float   effects_drywet;
    Boolean isPlaying;
    float   percentagePlayed, startPercentage, endPercentage;
    LoopMode loopMode;
    PlayheadDirection direction;

    Boolean beatSnap;
    Boolean isTriggered;

    unsigned long long openedTimestamp, lastPlayedTimestamp;

    TriggerMode triggerMode;

public:
	
	
	VisualInstancesProperties();
	~VisualInstancesProperties();
	
    
    static VisualInstancesProperties *getCurrent();
    
    void reset();
    
	void setLoopMode(LoopMode _loopMode){loopMode = _loopMode;}
	LoopMode getLoopMode() {return loopMode;}
	
	// debug
	void print();
    
    
    /** getters and setters **/
    int getWidth () { return width; }
    int getHeight () { return height; }
    
    float getZoomX () { return zoomX; }
    void setZoomX (float _zoomX) { zoomX = _zoomX; }
    
    float getZoomY () { return zoomY; }
    void setZoomY (float _zoomY) { zoomY = _zoomY; }
    
    float getCenterX() { return centerX; }
    float getCenterY() { return centerY; }
    ofPoint getCenter() { ofPoint point; point.x=centerX; point.y = centerY; return point;}
    void setCenterX(float _centerX) { centerX = _centerX; }
    void setCenterY(float _centerY) { centerY = _centerY; }
    
    int getX () { return x; }
    int getY () { return y; }
    
    int     getLayer () { return layer; }
    void    setLayer (int _layer) { layer = _layer; }
    
    int     getColumn () { return column; }
    void    setColumn (int _column) { column = _column; }
    
    Boolean getRetrigger () { return retrigger; }
    void    setRetrigger (bool _retrigger) { retrigger = _retrigger; }

    Boolean getIsPlaying() { return isPlaying; }
    void    setIsPlaying ( Boolean _isPlaying ) { isPlaying = _isPlaying; }
    
    float   getPercentagePlayed () { return percentagePlayed; }
    float   getStartPercentage () { return startPercentage; }
    float   getEndPercentage () { return endPercentage; }
    void    setPercentagePlayed ( float _val ) { percentagePlayed = ofClamp(_val, 0.0, 1.0); }
    void    setStartPercentage ( float _val ) { startPercentage = ofClamp(_val, 0.0, 1.0); }
    void    setEndPercentage ( float _val ) { endPercentage = ofClamp(_val, 0.0, 1.0); }
  
    PlayheadDirection getDirection () { return direction; }
    void setDirection ( PlayheadDirection _val ) { direction = _val; }
    
    Boolean getBeatSnap ();
    void    setBeatSnap (Boolean _val );
    
    Boolean getIsTriggered () { return isTriggered; }
    void    setIsTriggered (Boolean _val ) { isTriggered = _val; }
    
    unsigned long long getOpenedTimestamp () { return openedTimestamp; }
    unsigned long long getLastPlayedTimestamp () { return lastPlayedTimestamp; }
    void setOpenedTimestampToNow () { openedTimestamp = ofGetElapsedTimeMillis(); }
    void setLastPlayedTimestampToNow () { lastPlayedTimestamp = ofGetElapsedTimeMillis(); }
    
    
    TriggerMode getTriggerMode () { return triggerMode; }
    void setTriggerMode ( TriggerMode _val ) { triggerMode = _val; }
    

    
};



#endif
