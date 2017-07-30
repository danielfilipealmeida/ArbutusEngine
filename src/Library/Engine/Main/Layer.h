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
#include "json.hpp"



using json = nlohmann::json;


/*!
 @class Layer
 @abstract 
 @discussion
 */
class Layer {
    LayerProperties properties;
    unsigned int layerNumber;
    VisualInstance *activeInstance, *schedulledInstance;
    ofFbo *buffer;
    ofShader shader;

public:
    
    /*!
     @abstract Layer constructor
     @param _loadShaders a boolean to set if the shaders should be loaded when creating a new layer
     */
	Layer(bool _loadShaders = true);
    
    
	~Layer();
	
    
    void loadShaders();
    
	// render
	void render();
    
    
    
    /*!
     @abstact Draws the layer buffer
     @param x ...
     @param y ...
     @param width ...
     @param height ...
    */
	void
    draw(
         int x,
         int y,
         int width,
         int height
    );
	
    
    /*!
     @abstract returns a label to be used on the frontend to tag the layer
     @discussion Concat several information regarding the layer, like ID, blend mode and transparency.
     */
    string
    label();
    
    
    /*!
     @abstract
     */
	void
    print();
	

    /*!
     @abstract
     */
	void
    initBuffer();
    
    
    
    /*!
     @abstract
     */
	void
    destroyBuffer();
	
    
    
#pragma mark Video Instances
    
    
    /*!
     @abstract
     */
	void
    setActiveVisualInstance(VisualInstance *_activeInstance);
	
    
    /*!
     @abstract
     */
    void
    stopActiveVisualInstance();
	
    
    /*!
     @abstract
     */
    VisualInstance*
    getActiveVisualInstance() {return activeInstance;}
    
    
    /*!
     @abstract
     */
    void
    schedulleInstance(VisualInstance *_instance);
    
    
    /*!
     @abstract
     */
    void
    activateSchedulledInstance();
    
    
    /*!
     @abstract
     */
    void
    playVisualInstance(VisualInstance *newInstance);
    
    
    /*!
     @abstract
     */
    ofTexture*
    getTexture();
        
    

#pragma mark Free Frame
    
#ifdef _FREEFRAMEFILTER_H_
    
    FreeFrameFilterInstanceList freeFrameInstanceList;

    
    /*!
     @abstract
     */
	void
    addFreeFrameInstance(unsigned int instanceSlotNumber);
	
    
    /*!
     @abstract
     */
    void
    removeFreeFrameInstance(unsigned int instanceSlotNumber);
	
    
    /*!
     @abstract
     */
    FreeFrameFilterInstance*
    getFilterInstance(unsigned int instanceSlotNumber);
    
#endif
    
    
    
#pragma mark Getters and setters
    
    /*!
     @abstract
     */
    LayerProperties*
    getProperties () { return &properties; }
    
    
    /*!
     @abstract
     */
    unsigned int
    getLayerNumber () { return layerNumber; }
    
    
    /*!
     @abstract
     */
    void
    setLayerNumber ( unsigned int _input ) { layerNumber = _input;}
    
    
    /*!
     @abstract
     */
    VisualInstance*
    getActiveInstance () { return activeInstance; }
    
    
    /*!
     @abstract
     */
    VisualInstance*
    getSchedulledInstance () { return schedulledInstance; }
	
    
    ofFbo*
    getBuffer() {return buffer;}
    
    
    json
    getState();
    
#pragma mark Actions
    
    /*!
     @abstract
     */
    void
    handleAction(
                 string parameter,
                 json data
                 );
    
    
};

typedef std::list<Layer *> LayersList;
typedef LayersList::iterator LayersListIterator;
typedef LayersList::reverse_iterator LayersListReverseIterator;

#endif
