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
#include "EngineProperties.h"


using json = nlohmann::json;


/*!
 @class Layer
 \brief ...
 @discussion ...
 */
class Layer {
    LayerProperties properties;
    unsigned int layerNumber;
    VisualInstance *activeInstance, *schedulledInstance;
    ofFbo *buffer;
    ofShader shader;

public:
    
    /*!
     \brief Layer constructor
     \param _loadShaders a boolean to set if the shaders should be loaded when creating a new layer
     */
	Layer(bool _loadShaders = true);
    
    /*!
     \brief Destructor
     */
	~Layer();
	
    
    /*!
     \brief ...
     */
    void loadShaders();

    /*!
     \brief ...
     */
    void loadShadersFromOSXBundle();
    
    
    /*!
     \brief ...
     */
	void render();
    
    /*!
     @abstact Draws the layer buffer
     \param x ...
     \param y ...
     \param width ...
     \param height ...
    */
	void
    draw(int x, int y, int width, int height);
	
    
    /*!
     \brief returns a label to be used on the frontend to tag the layer
     @discussion Concat several information regarding the layer, like ID, blend mode and transparency.
     */
    string label();
    
    /*!
     \brief ...
     */
	void print();
	
    /*!
     \brief ...
     */
	void initBuffer();
    
    /*!
     \brief ...
     */
	void destroyBuffer();
	
#pragma mark Video Instances
    
    /*!
     \brief ...
     */
	void setActiveVisualInstance(VisualInstance *_activeInstance);
	
    /*!
     \brief ...
     */
    void stopActiveVisualInstance();
	
    /*!
     \brief Stop the current playing visual instance in this layer.
     */
    void stop();
    
    /*!
     \brief ...
     */
    VisualInstance* getActiveVisualInstance() {return activeInstance;}
    
    /*!
     \brief ...
     */
    void
    schedulleInstance(VisualInstance *_instance);
    
    /*!
     \brief ...
     */
    void
    activateSchedulledInstance();
    
    /*!
     \brief ...
     */
    void
    playVisualInstance(VisualInstance *newInstance);
    
    /*!
     \brief Gets the current textue
     \returns ofTexture*
     */
    ofTexture* getTexture();
        
    

#pragma mark Free Frame
    
#ifdef _FREEFRAMEFILTER_H_
    
    FreeFrameFilterInstanceList freeFrameInstanceList;

    /*!
     \brief
     */
	void
    addFreeFrameInstance(unsigned int instanceSlotNumber);
    
    /*!
     \brief
     */
    void
    removeFreeFrameInstance(unsigned int instanceSlotNumber);
	
    /*!
     \brief
     */
    FreeFrameFilterInstance*
    getFilterInstance(unsigned int instanceSlotNumber);
    
#endif
    
    
    
#pragma mark Getters and setters
    
    /*!
     \brief ...
     */
    LayerProperties*
    getProperties () { return &properties; }
    
    
    /*!
     \brief ...
     */
    unsigned int
    getLayerNumber () { return layerNumber; }
    
    
    /*!
     \brief ...
     */
    void
    setLayerNumber ( unsigned int _input ) { layerNumber = _input;}
    
    
    /*!
     \brief ...
     */
    VisualInstance*
    getActiveInstance () { return activeInstance; }
    
    
    /*!
     \brief ...
     */
    VisualInstance*
    getSchedulledInstance () { return schedulledInstance; }
	
    
    /*!
     \brief ...
     */
    ofFbo*
    getBuffer() {return buffer;}
    
    
    /*!
     \brief ...
     */
    json
    getState();
    
    /*!
     \brief ...
     */
    void setState(json state);
    
    
#pragma mark Actions
    
    /*!
     \brief ...
     */
    void handleAction(string parameter, json data);
    
};

typedef std::list<Layer *> LayersList;
typedef LayersList::iterator LayersListIterator;
typedef LayersList::reverse_iterator LayersListReverseIterator;



/**!
 */
class Layers {
    LayersList layersList;
    
    
    Layers() {}
    
public:
    
    static Layers& getInstance();
    Layers(Layers const&) = delete;
    void operator=(Layers const&) = delete;
    
    /*!
     \brief ...
     */
    Layer*
    add(bool _loadShaders = true);
    
    /*!
     \brief ...
     */
    void
    addToList(Layer *newLayer);
    
    /*!
     \brief ...
     */
    void empty();
    
    /*!
     \brief ...
     */
    void remove(unsigned int layerN);
    
    /*!
     \brief ...
     */
    Layer* get(unsigned int layerN);
    
    /*!
     \brief ...
     */
    Layer* getCurrent();
    
    /*!
     \brief ...
     */
    unsigned int getCurrentId();
    
    /*!
     \brief NOTE!!! isn't getSelectedLayer == getCurrentLayer
     */
    Layer* getSelected();
    
    /*!
     \brief ...
     */
    void setActive (unsigned int activeLayer);
    
    
    /*!
     @brief ...
     */
    void activateFirst();
    
    /*!
     @brief ...
     */
    void activatePrevious();
    
    /*!
     @brief ...
     */
    void activateNext();
    
    /*!
     @brief ...
     */
    void activateLast();
    
    /*!
     @brief Returns the number of layers
     @returns the number of layers
     */
    int count();
    
    /*!
     \brief ...
     */
    void setCount (unsigned int _val);

    /*!
     \brief Returns the actual STL list of the layers in the app
     */
    LayersList getList();
    
    
    /*!
     \brief Stops the visual instance playing at layer position
     */
    void stopAt(unsigned int position);

    
    /*!
     \brief Stops all playing visual instances
     */
    void stopAll();
    
#pragma mark State Handling
    
    /*!
     \brief ...
     */
    void setState(json state);
    
    /*!
     \brief ...
     */
    json getState();
    
    /*!
     \brief ...
     */
    json getFullState();
};

#endif
