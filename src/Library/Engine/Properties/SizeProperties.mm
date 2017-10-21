//
//  SizeProperties.cpp
//  ArbutusEngine
//
//  Created by Daniel Almeida on 21/10/2017.
//

#include "SizeProperties.h"
#include "Engine.h"

extern Engine *enginePtr;


SizeProperties::SizeProperties() {
    if (enginePtr != NULL) {
        width = EngineProperties::getInstance().getMixerWidth();
        height = EngineProperties::getInstance().getMixerHeight();
    }
}

SizeProperties::~SizeProperties() {}


unsigned int SizeProperties::getWidth() {
    return width;
}

void SizeProperties::setWidth(unsigned int _width) {
    width = ofClamp(_width, widthLimits.min, widthLimits.max);
}

unsigned int SizeProperties::getHeight() {
    return height;
}

void SizeProperties::setHeight(unsigned int _height) {
    height = ofClamp(_height, heightLimits.min, heightLimits.max);
}

json SizeProperties::getState(json state) {
    state["width"] = getWidth();
    state["height"] = getHeight();
    
    return state;
}

json SizeProperties::getFullState(json fullState) {
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

    return fullState;
}
