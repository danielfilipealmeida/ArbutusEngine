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
    alpha=1.0;
    red = 1.0; green = 1.0; blue=1.0;
    brightness = 1.0; contrast = 1.0; saturation = 1.0;
}


// debug
void Properties::print() {
	cout << "alpha: "<<alpha<<endl;
	cout << "RGB: "<<red<<", "<<green<<", "<<blue<<endl;
	cout << "brightness: "<< brightness <<", contrast: "<<contrast<<endl;
}