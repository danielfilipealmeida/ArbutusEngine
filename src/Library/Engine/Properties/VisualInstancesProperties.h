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
#include "json.hpp"


using json = nlohmann::json;


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
 @abstract ...
 @discussion ...
 */
class VisualInstancesProperties : public Properties {
    int width, height;
    float zoomX, zoomY;
    float centerX, centerY;
    int x, y, layer, column;
    Boolean retrigger, isPlaying;
    float percentagePlayed, startPercentage, endPercentage, effects_drywet;
    LoopMode loopMode;
    PlayheadDirection direction;

    Boolean beatSnap;
    Boolean isTriggered;

    unsigned long long openedTimestamp, lastPlayedTimestamp;

    TriggerMode triggerMode;

public:
	
	
    /**!
     @abstract ...
     */
	VisualInstancesProperties();

    
    /**!
     @abstract ...
     */
    ~VisualInstancesProperties();
	
    
    /**!
     @abstract ...
     */
    static VisualInstancesProperties *getCurrent();
    
    
    /**!
     @abstract ...
     */
    void reset();
    
    
    /**!
     @abstract ...
     */
    void setLoopMode(LoopMode _loopMode);
    
    
    /**!
     @abstract ...
     */
    LoopMode getLoopMode();
    
    
    /**!
     @abstract ...
     */
	void print();
    
    
    /**!
     @abstract ...
     */
    int getWidth ();
    
    
    /**!
     @abstract ...
     */
    int getHeight ();
    
    
    
    /**!
     @abstract ...
     */
    float getZoomX ();
    
    
    /**!
     @abstract ...
     */
    void setZoomX (float _zoomX);
    
    
    /**!
     @abstract ...
     */
    float getZoomY ();
    
    
    /**!
     @abstract ...
     */
    void setZoomY (float _zoomY);
    
    
    
    
    /**!
     @abstract ...
     */
    float getCenterX();
    
    
    /**!
     @abstract ...
     */
    float getCenterY();
    
    
    /**!
     @abstract ...
     */
    ofPoint getCenter();
    
    
    
    /**!
     @abstract ...
     */
    void setCenterX(float _centerX);
    
    
    /**!
     @abstract ...
     */
    void setCenterY(float _centerY);
    
    
    /**!
     @abstract ...
     */
    int getX ();
    
    
    /**!
     @abstract ...
     */
    int getY ();
    
    
    /**!
     @abstract ...
     */
    int getLayer ();
    
    
    /**!
     @abstract ...
     */
    void setLayer (int _layer);
    
    
    /**!
     @abstract ...
     */
    int getColumn ();
    
    
    /**!
     @abstract ...
     */
    void setColumn (int _column);
    
    
    
    /**!
     @abstract ...
     */
    Boolean getRetrigger ();
    
    
    /**!
     @abstract ...
     */
    void setRetrigger (bool _retrigger);
    
    

    /**!
     @abstract ...
     */
    Boolean getIsPlaying();
    
    
    /**!
     @abstract ...
     */
    void setIsPlaying ( Boolean _isPlaying );
    
    
    
    /**!
     @abstract ...
     */
    float getPercentagePlayed ();
    
    
    /**!
     @abstract ...
     */
    float getStartPercentage ();
    
    
    /**!
     @abstract ...
     */
    float getEndPercentage ();
    
    
    /**!
     @abstract ...
     */
    void setPercentagePlayed ( float _val );
    
    
    
    /**!
     @abstract ...
     */
    void setStartPercentage ( float _val );
    
    
    /**!
     @abstract ...
     */
    void setEndPercentage ( float _val );
    
    
  
    /**!
     @abstract ...
     */
    PlayheadDirection getDirection ();
    
    
    /**!
     @abstract ...
     */
    void setDirection ( PlayheadDirection _val );
    
    
    /**!
     @abstract ...
     */
    Boolean getBeatSnap ();
    
    
    /**!
     @abstract ...
     */
    void setBeatSnap (Boolean _val );
    
    
    
    /**!
     @abstract ...
     */
    Boolean getIsTriggered ();
    
    
    /**!
     @abstract ...
     */
    void setIsTriggered (Boolean _val );
    
    
    
    /**!
     @abstract ...
     */
    unsigned long long getOpenedTimestamp ();
    
    
    /**!
     @abstract ...
     */
    unsigned long long getLastPlayedTimestamp ();
    
    
    /**!
     @abstract ...
     */
    void setOpenedTimestampToNow ();
    
    
    /**!
     @abstract ...
     */
    void setLastPlayedTimestampToNow ();
    
    
    
    
    /**!
     @abstract ...
     */
    TriggerMode getTriggerMode ();
    
    
    /**!
     @abstract ...
     */
    void setTriggerMode ( TriggerMode _val );
    
    
    /**!
     @abstract ...
     */
    json getState();
    
};



#endif
