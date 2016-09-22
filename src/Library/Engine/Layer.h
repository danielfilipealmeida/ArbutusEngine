/*
 *  Layer.h
 *  VJingApp
 *
 *  Created by Daniel Almeida on 12/24/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#ifndef __LAYER_H__
#define __LAYER_H__

#include "ofMain.h"
#include "LayerProperties.h"
#include <stdlib.h>
#include "VisualInstance.h"


class Layer {
    LayerProperties     properties;
    unsigned int        layerNumber;
    VisualInstance      *activeInstance;
    VisualInstance      *schedulledInstance;
    ofFbo               *buffer;
    ofShader            shader;

public:
    
	Layer();
	~Layer();
	
    
    
	// render
	void render();
	void draw(int x, int y, int width, int height);
	
	//debug
	void print();
	
	// buffer
	void initBuffer();
	void destroyBuffer();	
	
	// video instances
	void setActiveVisualInstance(VisualInstance *_activeInstance);
	void stopActiveVisualInstance();
	VisualInstance *getActiveVisualInstance() {return activeInstance;}
    void schedulleInstance(VisualInstance *_instance);
    void activateSchedulledInstance();
    void playVisualInstance(VisualInstance *newInstance);
    
    ofTexture* getTexture();
        
    

	/* free frame */
#ifdef _FREEFRAMEFILTER_H_
    FreeFrameFilterInstanceList freeFrameInstanceList;

	void addFreeFrameInstance(unsigned int instanceSlotNumber);
	void removeFreeFrameInstance(unsigned int instanceSlotNumber);
	FreeFrameFilterInstance *getFilterInstance(unsigned int instanceSlotNumber);
#endif
    
    
    
    /** getters and setters **/
    
    LayerProperties *getProperties () { return &properties; }
    
    unsigned int getLayerNumber () { return layerNumber; }
    void setLayerNumber ( unsigned int _input ) { layerNumber = _input;}
    
    VisualInstance *getActiveInstance () { return activeInstance; }
    
    VisualInstance *getSchedulledInstance () { return schedulledInstance; }
	
};

typedef std::list<Layer *> LayersList;
typedef LayersList::iterator LayersListIterator;
typedef LayersList::reverse_iterator LayersListReverseIterator;

#endif