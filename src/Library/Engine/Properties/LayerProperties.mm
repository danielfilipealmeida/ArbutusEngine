/*
 *  LayerProperties.mm
 *  VJingApp
 *
 *  Created by Daniel Almeida on 12/24/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#include "LayerProperties.h"
#include "Engine.h"

//extern ofApp	*app;



extern Engine *enginePtr;

LayerProperties::LayerProperties() {
    blendMode   = BLEND_ADD;
    reset();
}

LayerProperties::~LayerProperties() {}

void LayerProperties::reset() {
    Properties::reset();
    //setAlpha (1.0);
    setBlurH (0.0);
    setBlurV (0.0);
    setAlpha (1.0);
    //setRed (1.0);
    //setGreen (1.0);
    //setBlue (1.0);
    //setBrightness (1.0);
    //setContrast (1.0);
    //setSaturation (1.0);
    setBlurH (0.0);
    setBlurV (0.0);

}

void LayerProperties::print() {
	Properties::print();
}

string LayerProperties::blendModeToString(BlendMode mode) {
    switch(mode) {
        case BLEND_ALPHA:
        return "ALPHA";
        break;
        
        case BLEND_ADD:
        return "ADD";
        break;
        
        case BLEND_MULTIPLY:
        return "MULT";
        break;
        
        case BLEND_SUBTRACT:
        return "SUBT";
        break;
        
        case BLEND_SCREEN:
        return "SCRN";
        break;

        default:
        return "?";
        break;
    }
}

/*
unsigned int LayerProperties::getWidth() {
    return width;
}


void LayerProperties::setWidth(unsigned int _width) {
    width = ofClamp(_width, widthLimits.min, widthLimits.max);
}


unsigned int LayerProperties::getHeight() {
    return height;
}


void LayerProperties::setHeight(unsigned int _height) {
    height = ofClamp(_height, heightLimits.min, heightLimits.max);
}
*/

BlendMode LayerProperties::getBlendMode() {
    return blendMode;
}


void LayerProperties::setBlendMode(BlendMode _blendMode) {
    if (_blendMode < OF_BLENDMODE_DISABLED) _blendMode = BLEND_ALPHA;
    if (_blendMode > OF_BLENDMODE_SCREEN) _blendMode = BLEND_SCREEN;
    blendMode = _blendMode;
}


unsigned int LayerProperties::getBlurH() {
    return blurH;
}


void LayerProperties::setBlurH(unsigned int _blurH) {
    blurH = ofClamp(_blurH, blurHLimits.min, blurHLimits.max);
}


unsigned int LayerProperties::getBlurV() {
    return blurV;
}


void LayerProperties::setBlurV(unsigned int _blurV) {
    blurV = ofClamp(_blurV, blurVLimits.min, blurVLimits.max);
}


json LayerProperties::getState() {
    json state;
    
    state = Properties::getState();
    state = SizeProperties::getState(state);
    //state["width"] = getWidth();
    //state["height"] = getHeight();
    state["blendMode"] = getBlendMode();
    state["blurH"] = getBlurH();
    state["blurV"] = getBlurV();
    
    return state;
}


json LayerProperties::getFullState() {
    json fullState;
    
    fullState = Properties::getFullState();
    fullState = SizeProperties::getFullState(fullState);
    /*
    fullState["width"] =  {
            {"type", typeid(width).name()},
            {"value", getWidth()},
            {"min", widthLimits.min},
            {"max", widthLimits.max}
    };
    fullState["height"] =  {
        {"type", typeid(height).name()},
        {"value", getHeight()},
        {"min", heightLimits.min},
        {"max", heightLimits.max}
    };
     */
    fullState["blurH"] =  {
        {"type", typeid(blurH).name()},
        {"value", getBlurH()},
        {"min", blurHLimits.min},
        {"max", blurHLimits.max}
    };
    fullState["blurV"] =  {
        {"type", typeid(blurV).name()},
        {"value", getBlurV()},
        {"min", blurVLimits.min},
        {"max", blurVLimits.max}
    };
    fullState["blendMode"] =  {
        {"type", typeid(blendMode).name()},
        {"value", getBlendMode()},
        {"min", BLEND_ALPHA},
        {"max", BLEND_SCREEN}
    };
    
    return fullState;
}
