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
    reset();
}

Properties::~Properties() {
	
}

void Properties::reset() {
    alpha = 1.0;
    red = 1.0; green = 1.0; blue = 1.0;
    brightness = 1.0; contrast = 1.0; saturation = 1.0;
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
    alpha = _input;
}


float Properties::getRed() {
    return red;
}


void Properties::setRed(float _input) {
    red = ofClamp(_input, -1.0, 1.0);
}

float Properties::getGreen() {
    return green;
}


void Properties::setGreen(float _input) {
    green = ofClamp(_input, -1.0, 1.0);
}


float Properties::getBlue() {
    return blue;
}


void Properties::setBlue(float _input) {
    blue = ofClamp(_input, -1.0, 1.0);
}


float Properties::getBrightness() {
    return brightness;
}


void Properties::setBrightness(float _input) {
    brightness = ofClamp(_input, -1.0, 1.0);
}


float Properties::getContrast() {
    return contrast;
}


void Properties::setContrast(float _input) {
    contrast = ofClamp(_input, -1.0, 1.0);
}


float Properties::getSaturation() {
    return saturation;
}


void Properties::setSaturation(float _input) {
    saturation = ofClamp(_input, -1.0, 1.0);
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
