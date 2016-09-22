/*
 *  Properties.h
 *  VJingApp
 *
 *  Created by Daniel Almeida on 12/24/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */


#ifndef __PROPERTIES_H__
#define __PROPERTIES_H__

#include "ofMain.h"


class Properties {

    string name;
    float alpha; //0.0 - 1.0
    float red, green, blue;
    float brightness, contrast, saturation;
    
public:

	
	Properties();
	~Properties();
	
    void reset();
    
	// debug
	void print();
    
    
    /** getters and setters **/
    
    string getName() {return name;}
    void setName(string _input) {name = _input;}

    float getAlpha() {return alpha;}
    void setAlpha(float _input) {alpha = _input;}

    float getRed() {return red;}
    void setRed(float _input) {red = _input;}

    float getGreen() {return green;}
    void setGreen(float _input) {green = _input;}

    float getBlue() {return blue;}
    void setBlue(float _input) {blue = _input;}

    float getBrightness() {return brightness;}
    void setBrightness(float _input) {brightness = _input;}

    float getContrast() {return contrast;}
    void setContrast(float _input) {contrast = _input;}

    float getSaturation() {return saturation;}
    void setSaturation(float _input) {saturation = _input;}

    
	
};

#endif