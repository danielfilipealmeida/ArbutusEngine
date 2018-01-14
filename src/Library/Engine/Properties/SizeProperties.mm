//
//  SizeProperties.cpp
//  ArbutusEngine
//
//  Created by Daniel Almeida on 21/10/2017.
//

#include "SizeProperties.h"
#include "Engine.h"
#include "Utils.h"

SizeProperties::SizeProperties() {
    if (Engine::getInstance() != NULL) {
        width = EngineProperties::getInstance().getMixerWidth();
        height = EngineProperties::getInstance().getMixerHeight();
    }
    else {
        width = PROPERTY_MAX_WIDTH;
        height = PROPERTY_MAX_HEIGHT;
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
        {"title", "Width"},
        {"type", Utils::getStateTypeForTypeidName(typeid(width).name())},
        {"value", getWidth()},
        {"min", widthLimits.min},
        {"max", widthLimits.max}
    };
    fullState["height"] =  {
        {"title", "Height"},
        {"type", Utils::getStateTypeForTypeidName(typeid(height).name())},
        {"value", getHeight()},
        {"min", heightLimits.min},
        {"max", heightLimits.max}
    };

    return fullState;
}
