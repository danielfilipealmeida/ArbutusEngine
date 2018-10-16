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


Visual::~Visual() {}

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

void Visual::setState(json state) {
    if (state["caption"].is_string()) setCaption(state["caption"].get<string>());
}

// debug
void Visual::print(){
    cout << "Visual Data"<<endl;
    cout << "address: " << this<<endl;

}

ofImage* Visual::getScreenshot()
{
    if (!screenshot.isAllocated()) {
        
    }
    
    return &screenshot;
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
}




/**
 *  Setup the thumbnail. 
First checks if it already is set. if yes, get it, if not, create it and save it
 */
void Visual::setThumbnail()  {
    /// ???? WHAT IS THIS??? THIS IS CRAP! TODO: FIX
    thumbnailPath = getThumbnailPath();
}


void Visual::saveThumbnail() {
    if (!ofDirectory::doesDirectoryExist(ofFilePath::getEnclosingDirectory(thumbnailPath, false)))
    {
        ofFilePath::createEnclosingDirectory(thumbnailPath, false, true);
    }
    screenshot.save(thumbnailPath);
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

VisualType Visual::getType ()
{
    return type;
}

void Visual::setType (VisualType _val)
{
    type = _val;
}

string Visual::getCaption()
{
    return caption;
}

void Visual::setCaption(string _val)
{
    caption = _val;
}

string Visual::getThumbnailPath()
{
    return thumbnailPath;
}

void Visual::setThumbnailPath(string _val)
{
    thumbnailPath = _val;
}

string Visual::getFilePath () {
    return filePath;
}

void Visual::setFilePath (string _val)
{
    filePath = _val;
}

