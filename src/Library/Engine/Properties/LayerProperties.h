/*
 *  LayerProperties.h
 *  VJingApp
 *
 *  Created by Daniel Almeida on 12/24/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */



#ifndef __LAYERPROPERTIES_H__
#define __LAYERPROPERTIES_H__




#include "Properties.h"
#include "SizeProperties.h"


typedef enum {
	BLEND_ALPHA     = OF_BLENDMODE_ALPHA,
	BLEND_ADD       = OF_BLENDMODE_ADD,
	BLEND_MULTIPLY  = OF_BLENDMODE_MULTIPLY,
	BLEND_SUBTRACT  = OF_BLENDMODE_SUBTRACT,
	BLEND_SCREEN    = OF_BLENDMODE_SCREEN
} BlendMode;


/*!
 \brief Stores and handles the properties of a Layer
 */
class LayerProperties : public Properties, public SizeProperties {
protected:
    //unsigned int    width;
    //unsigned int    height;
    BlendMode       blendMode;
    float           blurH, blurV;
    
    //const uintLimits widthLimits = {0, PROPERTY_MAX_WIDTH};
    //const uintLimits heightLimits = {0, PROPERTY_MAX_HEIGHT};
    const floatLimits blurHLimits = {0, 10};
    const floatLimits blurVLimits = {0, 10};
    
public:

	
    /**!
     @abstract ...
     */
	LayerProperties();

    
    /**!
     @abstract ...
     */
    ~LayerProperties();
	
    /**!
     @abstract ...
     */
    void reset();
    
    /**!
     @abstract ...
     */
	void print();
    
    /*!
     @abstract Get a string with the value of the blend mode.
     @param mode the blend mode 
     @return a string with the label of the blend mode
     */
    static string

    
    /**!
     @abstract ...
     */
    blendModeToString(BlendMode mode);
    
    
    /**!
     @abstract ...
     */
    //unsigned int getWidth();
    
    
    /**!
     @abstract ...
     */
    //void setWidth(unsigned int _width);
    
    
    
    /**!
     @abstract ...
     */
    //unsigned int getHeight();
    
    
    /**!
     @abstract ...
     */
    //void setHeight(unsigned int _height);
    
    
    
    /**!
     @abstract ...
     */
    BlendMode getBlendMode();
    
    
    /**!
     @abstract ...
     */
    void setBlendMode(BlendMode _blendMode);
    
    
    
    
    /**!
     @abstract ...
     */
    unsigned int getBlurH();
    
    
    /**!
     @abstract ...
     */
    void setBlurH(unsigned int _blurH);
    
    

    /**!
     @abstract ...
     */
    unsigned int getBlurV();
    
    
    /**!
     @abstract ...
     */
    void setBlurV(unsigned int _blurV);
    
    
    json getState();
    
    /**
     \brief Returns the complete state information
     
     The complete state isn't changeable. It contains the datatype and the limits.
     */
    json getFullState();
};





#endif
