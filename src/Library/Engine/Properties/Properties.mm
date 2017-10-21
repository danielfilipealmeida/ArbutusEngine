/*
 *  Properties.mm
 *  VJingApp
 *
 *  Created by Daniel Almeida on 12/24/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#include "Properties.h"



Properties::Properties(){
    setLimits();
    reset();
}

Properties::~Properties() {
	
}

void Properties::setLimits() {
    floatPropertiesLimits.insert(std::pair<string, floatLimits>("alpha", {0.0, 1.0}));
    floatPropertiesLimits.insert(std::pair<string, floatLimits>("red", {-1.0, 1.0}));
    floatPropertiesLimits.insert(std::pair<string, floatLimits>("green", {-1.0, 1.0}));
    floatPropertiesLimits.insert(std::pair<string, floatLimits>("blue", {-1.0, 1.0}));
    floatPropertiesLimits.insert(std::pair<string, floatLimits>("brightness", {-1.0, 1.0}));
    floatPropertiesLimits.insert(std::pair<string, floatLimits>("contrast", {-1.0, 1.0}));
    floatPropertiesLimits.insert(std::pair<string, floatLimits>("saturation", {-1.0, 1.0}));
}

void Properties::reset() {
    
    alpha = 1.0;
    red = green = blue = 0.0;
    brightness = contrast = saturation = 0.0;
}


// debug
void Properties::print() {
	cout << "alpha: "<<alpha<<endl;
	cout << "RGB: "<<red<<", "<<green<<", "<<blue<<endl;
	cout << "brightness: "<< brightness <<", contrast: "<<contrast<<endl;
}


string Properties::getName() {
    return name;
}


void Properties::setName(string _input) {
    name = _input;
}


float Properties::getAlpha() {
    return alpha;
}


void Properties::setAlpha(float _input) {
    alpha = ofClamp(_input, floatPropertiesLimits["alpha"].min, floatPropertiesLimits["alpha"].max);
}


float Properties::getRed() {
    return red;
}


void Properties::setRed(float _input) {
    red = ofClamp(_input, floatPropertiesLimits["red"].min, floatPropertiesLimits["red"].max);
}

float Properties::getGreen() {
    return green;
}


void Properties::setGreen(float _input) {
    green = ofClamp(_input, floatPropertiesLimits["green"].min, floatPropertiesLimits["green"].max);
}


float Properties::getBlue() {
    return blue;
}


void Properties::setBlue(float _input) {
    blue = ofClamp(_input, floatPropertiesLimits["blue"].min, floatPropertiesLimits["blue"].max);
}


float Properties::getBrightness() {
    return brightness;
}


void Properties::setBrightness(float _input) {
    brightness = ofClamp(_input, floatPropertiesLimits["brightness"].min, floatPropertiesLimits["brightness"].max);
}


float Properties::getContrast() {
    return contrast;
}


void Properties::setContrast(float _input) {
    contrast = ofClamp(_input,  floatPropertiesLimits["contrast"].min,  floatPropertiesLimits["contrast"].max);
}


float Properties::getSaturation() {
    return saturation;
}


void Properties::setSaturation(float _input) {
    saturation = ofClamp(_input,  floatPropertiesLimits["saturation"].min,  floatPropertiesLimits["saturation"].max);
}


json Properties::getState() {
    return {
        {"name", getName()},
        {"alpha", getAlpha()},
        {"red", getRed()},
        {"green", getGreen()},
        {"blue", getBlue()},
        {"brightness" , getBrightness()},
        {"contrast", getContrast()},
        {"saturation", getSaturation()}
    };
}


json Properties::getFullState() {
    return {
        { "name",
            {
                {"type", typeid(name).name()},
                {"value", getName()}
            }
        },
        { "alpha",
            {
                {"type", typeid(alpha).name()},
                {"value", getAlpha()},
                {"min", floatPropertiesLimits["alpha"].min},
                {"max", floatPropertiesLimits["alpha"].max}
            }
        },
        { "red",
            {
                {"type", typeid(red).name()},
                {"value", getRed()},
                {"min", floatPropertiesLimits["red"].min},
                {"max", floatPropertiesLimits["red"].max}
            }
        },
        { "green",
            {
                {"type", typeid(green).name()},
                {"value", getGreen()},
                {"min", floatPropertiesLimits["green"].min},
                {"max", floatPropertiesLimits["green"].max}
            }
        },
        { "blue",
            {
                {"type", typeid(blue).name()},
                {"value", getBlue()},
                {"min", floatPropertiesLimits["blue"].min},
                {"max", floatPropertiesLimits["blue"].max}
            }
        },
        { "brightness",
            {
                {"type", typeid(blue).name()},
                {"value", getBrightness()},
                {"min", floatPropertiesLimits["brightness"].min},
                {"max", floatPropertiesLimits["brightness"].max}
            }
        },
        { "saturation",
            {
                {"type", typeid(saturation).name()},
                {"value", getSaturation()},
                {"min", floatPropertiesLimits["saturation"].min},
                {"max", floatPropertiesLimits["saturation"].max}
            }
        },
        { "contrast",
            {
                {"type", typeid(contrast).name()},
                {"value", getContrast()},
                {"min", floatPropertiesLimits["contrast"].min},
                {"max", floatPropertiesLimits["contrast"].max}
            }
        }

    };
}
