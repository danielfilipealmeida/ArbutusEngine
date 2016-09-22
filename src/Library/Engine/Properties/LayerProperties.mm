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
    width       = enginePtr->getMixerWidth();
    height      = enginePtr->getMixerHeight();
    blendMode   = BLEND_ADD;
    reset();
}


void LayerProperties::reset() {
    Properties::reset();
    setAlpha (1.0);
    setBlurH (0.0);
    setBlurV (0.0);
}

LayerProperties::~LayerProperties() {
	
}


void LayerProperties::print() {
	Properties::print();
}