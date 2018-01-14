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
     \brief ...
     */
	VisualInstancesProperties();

    /**!
     \brief ...
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
     \brief ...
     */
    void setLoopMode(LoopMode _loopMode);
    
    /**!
     \brief ...
     */
    LoopMode getLoopMode();
    
    /**!
     \brief ...
     */
	void print();
    
    
    /**!
     \brief ...
     */
    //int getWidth ();
    
    
    /**!
     @abstract ...
     */
    //int getHeight ();
    
    /**!
     \brief ...
     */
    float getZoomX ();
    
    /**!
     \brief ...
     */
    void setZoomX (float _zoomX);
    
    /**!
     \brief ...
     */
    float getZoomY ();
    
    /**!
     \brief ...
     */
    void setZoomY (float _zoomY);
    
    /**!
     \brief ...
     */
    float getCenterX();
    
    /**!
     \brief ...
     */
    float getCenterY();
    
    /**!
     \brief ...
     */
    ofPoint getCenter();
    
    /**!
     \brief ...
     */
    void setCenterX(float _centerX);
    
    /**!
     \brief ...
     */
    void setCenterY(float _centerY);
    
    /**!
     \brief ...
     */
    int getX ();
    
    /**!
     \brief ...
     */
    int getY ();
    
    /**!
     \brief ...
     */
    int getLayer ();
    
    /**!
     \brief ...
     */
    void setLayer (int _layer);
    
    /**!
     \brief ...
     */
    int getColumn ();
    
    /**!
     \brief ...
     */
    void setColumn (int _column);
    
    /**!
     \brief ...
     */
    Boolean getRetrigger ();
    
    /**!
     \brief ...
     */
    void setRetrigger (bool _retrigger);
    
    /**!
     \brief ...
     */
    Boolean getIsPlaying();
    
    /**!
     \brief ...
     */
    void setIsPlaying ( Boolean _isPlaying );
    
    /**!
     \brief ...
     */
    float getPercentagePlayed ();
    
    /**!
     \brief ...
     */
    float getStartPercentage ();
    
    /**!
     \brief ...
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
    
    /*!
     \brief Sets a property with a float value
     */
    void set(string property, float value);
    
    void set(string property, unsigned int value);
    
};



#endif
