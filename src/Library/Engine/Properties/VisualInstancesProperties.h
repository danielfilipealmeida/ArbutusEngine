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
#include "SizeProperties.h"
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
 \brief Stores and handles properties of a visual instance
 */
class VisualInstancesProperties : public Properties, public SizeProperties {
    float zoomX, zoomY;
    float centerX, centerY;
    int x, y, layer, column;
    Boolean retrigger, isPlaying;
    float percentagePlayed, startPercentage, endPercentage, effects_drywet;
    
    LoopMode loopMode;
    PlayheadDirection direction;
    TriggerMode triggerMode;

    Boolean beatSnap;
    Boolean isTriggered;

    unsigned long long openedTimestamp, lastPlayedTimestamp;

    
    
    std::map<string, floatLimits> floatPropertiesLimitsVisualInstances;
    const uintLimits loopModeLimits = {LoopMode_Normal, LoopMode_Inverse};
    const uintLimits playheadDirectionLimits = {Direction_Left, Direction_Right};
    const uintLimits triggerModeLimits = {TriggerMode_MouseDown, TriggerMode_Piano};


public:
	
	
    /**!
     @abstract ...
     */
	VisualInstancesProperties();

    
    /**!
     @abstract ...
     */
    ~VisualInstancesProperties();
	
       
    /*!
     \brief Set all properties to default values
     */
    void reset();
    
    /*!
    \brief Set minimum and maximum valies of properties
    */
    void setLimits();

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
    //int getWidth ();
    
    
    /**!
     @abstract ...
     */
    //int getHeight ();
    
    
    
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
    
    
    /*!
     \brief ...
     */
    void setPercentagePlayed ( float _val );
    
    
    
    /*!
     \brief ...
     */
    void setStartPercentage ( float _val );
    
    
    /*!
     \brief ...
     */
    void setEndPercentage ( float _val );
    
    
    /*!
     \brief ...
     */
    float getEffectMix();
    
    /*!
     \brief ...
     */
    void setEffectMix(float _val);
    
    /*!
     \brief ...
     */
    PlayheadDirection getDirection ();
    
    
    /*!
     \brief ...
     */
    void setDirection ( PlayheadDirection _val );
    
    
    /*!
     \brief ...
     */
    Boolean getBeatSnap ();
    
    
    /*!
     \brief ...
     */
    void setBeatSnap (Boolean _val );
    
    
    
    /*!
     \brief ...
     */
    Boolean getIsTriggered ();
    
    
    /*!
     \brief ...
     */
    void setIsTriggered (Boolean _val );
    
    
    
    /*!
     \brief ...
     */
    unsigned long long getOpenedTimestamp ();
    
    
    /*!
     \brief ...
     */
    unsigned long long getLastPlayedTimestamp ();
    
    
    /*!
     \brief ...
     */
    void setOpenedTimestampToNow ();
    
    
    /*!
     \brief ...
     */
    void setLastPlayedTimestampToNow ();
    
    
    
    
    /*!
     \brief ...
     */
    TriggerMode getTriggerMode ();
    
    
    /*!
     \brief ...
     */
    void setTriggerMode ( TriggerMode _val );
    
    
    /*!
     \brief ...
     */
    json getState();
    
    /**
     \brief Returns the complete state information
     
     The complete state isn't changeable. It contains the datatype and the limits.
     */
    json getFullState();
    
};



#endif
