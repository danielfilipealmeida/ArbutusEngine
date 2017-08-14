/*
 *  Video.mm
 *  VJingApp
 *
 *  Created by Daniel Almeida on 12/13/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#include "Visual.h"


Visual::Visual() {
    caption = "Untitled";
}

Visual::~Visual() {
	//if (loaded == true) closeVisual();
    //cout << "visual destroy" <<endl;
    
}

json Visual::getState()
{
    json state;
    
    state = json::object({
        {"type", getType()},
        {"caption", getCaption()},
        {"address", ofToString(this)}
    });
    
    return state;
}

// debug
void Visual::print(){
    cout << "Visual Data"<<endl;
    cout << "address: " << this<<endl;

}

void Visual::drawScreenshot(float x, float y, float w, float h){
    if (screenshot.bAllocated() == false) {
        return;
    }
	this->screenshot.draw(x, y, w, h);
};

void Visual::drawThumbnail(float x, float y, float w, float h) {
    if (this->screenshot.bAllocated() == false) {
        return;
    }
	//GUIThumbnail(&screenshot, x, y, w, h);
}




/**
 *  Setup the thumbnail. First checks if it already is set. if yes, get it, if not, create it and save it
 */
void Visual::setThumbnail()  {
    thumbnailPath = getThumbnailPath();
        //cout << thumbnailPath << endl;
    
    
    
}

/**
 *  Save the thumbnail on the apps preferences folder
 */
void Visual::saveThumbnail() {
    screenshot.saveImage(thumbnailPath);
   
}



void Visual::createThumbnail(){
    ofSetColor(255,255,255);
    ofDisableAlphaBlending();
    ofDisableAntiAliasing();
    ofDisableBlendMode();
    ofDisableLighting();
    ofDisableDepthTest();
    ofDisableSmoothing();
}




/** geters and setters ***/


string Visual::getCaption()
{
    return caption;
}



