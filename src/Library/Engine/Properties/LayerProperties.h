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


typedef enum {
	BLEND_ALPHA     = OF_BLENDMODE_ALPHA,
	BLEND_ADD       = OF_BLENDMODE_ADD,
	BLEND_MULTIPLY  = OF_BLENDMODE_MULTIPLY,
	BLEND_SUBTRACT  = OF_BLENDMODE_SUBTRACT,
	BLEND_SCREEN    = OF_BLENDMODE_SCREEN
} BlendMode;

class LayerProperties : public Properties {

    unsigned int width;
    unsigned int height;
    BlendMode blendMode;
    float blurH, blurV;
    
public:

	
	LayerProperties();
	~LayerProperties();
	
    void reset();
    
	void print();
    
    /** setters and getters **/
    
    unsigned int getWidth() { return width;}
    void setWidth(unsigned int _width) {width = _width;}
    
    unsigned int getHeight() { return height;}
    void setHeight(unsigned int _height) {height = _height;}
    
    BlendMode getBlendMode() { return blendMode;}
    void setBlendMode(BlendMode _blendMode) { blendMode = _blendMode;}
    
    
    unsigned int getBlurH() { return blurH;}
    void setBlurH(unsigned int _blurH) {blurH = _blurH;}

    unsigned int getBlurV() { return blurV;}
    void setBlurV(unsigned int _blurV) {blurV = _blurV;}

    
};





#endif