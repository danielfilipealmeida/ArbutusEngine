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

#define PROPERTY_MAX_WIDTH  1920
#define PROPERTY_MAX_HEIGHT 1080

extern Engine *enginePtr;

LayerProperties::LayerProperties() {
    if (enginePtr != NULL) {
        width = EngineProperties::getInstance().getMixerWidth();
        height = EngineProperties::getInstance().getMixerHeight();
    }
    blendMode   = BLEND_ADD;
    reset();
}

LayerProperties::~LayerProperties() {}

void LayerProperties::reset() {
    Properties::reset();
    setAlpha (1.0);
    setBlurH (0.0);
    setBlurV (0.0);
    setAlpha (1.0);
    setRed (1.0);
    setGreen (1.0);
    setBlue (1.0);
    setBrightness (1.0);
    setContrast (1.0);
    setSaturation (1.0);
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

unsigned int LayerProperties::getWidth() {
    return width;
}


void LayerProperties::setWidth(unsigned int _width) {
    width = ofClamp(_width, 0, PROPERTY_MAX_WIDTH);
}


unsigned int LayerProperties::getHeight() {
    return height;
}


void LayerProperties::setHeight(unsigned int _height) {
    height = ofClamp(_height, 0, PROPERTY_MAX_HEIGHT);
}


BlendMode LayerProperties::getBlendMode() {
    return blendMode;
}


void LayerProperties::setBlendMode(BlendMode _blendMode) {
    blendMode = _blendMode;
}


unsigned int LayerProperties::getBlurH() {
    return blurH;
}


void LayerProperties::setBlurH(unsigned int _blurH) {
    blurH = ofClamp(_blurH, 0, 10);
}


unsigned int LayerProperties::getBlurV() {
    return blurV;
}


void LayerProperties::setBlurV(unsigned int _blurV) {
    blurV = ofClamp(_blurV, 0, 10);
}


json LayerProperties::getState() {
    json state;
    
    state = Properties::getState();
    state["width"] = getWidth();
    state["height"] = getHeight();
    state["blendMode"] = getBlendMode();
    state["blurH"] = getBlurH();
    state["blurV"] = getBlurV();
    
    return state;
}
