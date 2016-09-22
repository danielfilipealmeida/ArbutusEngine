/*
 *  VisualInstance.h
 *  VJingApp
 *
 *  Created by Daniel Almeida on 12/13/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#ifndef __VISUALINSTANCE_H__
#define __VISUALINSTANCE_H__



#include "ofMain.h"
#include <stdlib.h>
#include "Visual.h"
#include "VisualVideo.h"
#include "VisualCamera.h"
#include "VisualSyphon.h"
#include "VisualInstancesProperties.h"
#include "FreeFrameFilters.h"


/*!
 @header VisualInstance.h
 @brief Defines an instance of a Visual of any kind.
 @abstract
 */


class VisualInstance {
    VisualInstancesProperties properties;
    int videoX, videoY, videoWidth, videoHeight;
    
    
public:
	Visual *visual;
	ofVideoPlayer video;
    
#ifdef _FREEFRAMEFILTER_H_
	FreeFrameFilterInstanceList freeFrameInstanceList;
#endif 
    
    /*! @brief Simple constructor for the VisualInstance Object */
	VisualInstance();
    
    /*! @brief Standard constructor that allows more information */
	VisualInstance(Visual *_visual, unsigned int layer, unsigned int column);
	~VisualInstance();
	
    
    
	/* actions */
	bool loadVideo();
	bool unloadVideo();
    void unload();
	void play(bool forcePlay = false);
    void retrigger();
	void stop();
	void update();
	
    
    /* processing */
    
    void calculateDisplayRect(unsigned int width, unsigned int height);
    
	/* draw */
	void draw(unsigned int x, unsigned int y, unsigned int width, unsigned int height);
	void drawVisualScreenshot(unsigned int x, unsigned int y, unsigned int width, unsigned int height);
	void drawVisualThumbnail(unsigned int x, unsigned int y, unsigned int width, unsigned int height);
	
	//debug
	void print();
	
	/* set & get options */
	void setLoopMode(LoopMode _loopMode);
	
	/* free frame */
#ifdef _FREEFRAMEFILTER_H_
	void addFreeFrameInstance(unsigned int instanceSlotNumber);
	void removeFreeFrameInstance(unsigned int instanceSlotNumber);
#endif
    
	/* information */
    float   getPercentagePlayed();
    void    setPercentagePlayed(float percentage);
    bool    checkCloseCondition();
    
    
    /* loop and playhead position handling */
        //void handleVideoGoingLeft();
        //void handleVideoGoingRight();
    void calculateCurrentPlayeadPosition(float position);
    void handleNormalLoopMode(float position);
    void handlePingPongLoopMode(float position);
    void handleInverseLoopMode(float position);

    VisualType getVisualType();
    
    
    /** getters and setters **/
    VisualInstancesProperties *getProperties () { return &properties; }
    
    
    
private:
    void autoLoadAndAutoPlayVideo();
    bool isFreeFrameFilterActive();
};


typedef std::list<VisualInstance *> VisualInstanceList;
typedef VisualInstanceList::iterator VisualInstanceListIterator;



#endif