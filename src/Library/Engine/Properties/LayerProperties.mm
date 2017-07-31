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
    if (enginePtr != NULL) {
        width = EngineProperties::getInstance().getMixerWidth();
        height = EngineProperties::getInstance().getMixerHeight();
    }
    blendMode   = BLEND_ADD;
    reset();
}

LayerProperties::~LayerProperties() {}

void
LayerProperties::reset() {
    Properties::reset();
    setAlpha (1.0);
    setBlurH (0.0);
    setBlurV (0.0);
}

void
LayerProperties::print() {
	Properties::print();
}

string
LayerProperties::blendModeToString(BlendMode mode) {
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

