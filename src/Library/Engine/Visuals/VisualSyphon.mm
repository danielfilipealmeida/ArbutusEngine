//
//  VisualSyphon.cpp
//  FigTree
//
//  Created by Daniel Almeida on 05/05/14.
//
//

// meter



#include "VisualSyphon.h"


VisualSyphon::VisualSyphon(string _serverName, string _appName) {
    serverName = _serverName;
    appName = _appName;
    
    client.setup();
    client.set(_serverName, _appName);
    setType (VisualType_Syphon);
    //createThumbnail();
    //client.getTextureReference().texData.bFlipTexture=true;
    loadTimestamp = ofGetElapsedTimeMillis();
    screenshotGenerated = false;
    active = true;
    setCaption("Syphon: " + ( (!_appName.empty()) ? _appName : _serverName));
}


VisualSyphon::~VisualSyphon() {
    
}

ofJson
VisualSyphon::getState()
{
    ofJson state;
    
    state = Visual::getState();
    
    state["serverName"] = serverName;
    state["appName"] = appName;    
    
    return state;
}

void VisualSyphon::setState(ofJson state) {
    Visual::setState(state);
}


string VisualSyphon::getThumbnailPath() {
    return Visual::getThumbnailPath();
}

void VisualSyphon::setThumbnail() {
    Visual::setThumbnail();
}

void VisualSyphon::saveThumbnail() {
    Visual::saveThumbnail();
}



void VisualSyphon::createThumbnail() {
    Visual::createThumbnail();
    
	screenshot.allocate(client.getWidth(), client.getHeight(), OF_IMAGE_COLOR);
    screenshot.clear();
   
    ofTexture texture = client.getTexture();
    if (texture.texData.bAllocated==false) return;
    
    ofPixels pixels;
    client.getTexture().readToPixels(pixels);
    screenshot.setFromPixels(pixels);
    /*
    ofFbo fbo;
    
    fbo.allocate(client.getWidth(), client.getHeight());
	fbo.begin();
    client.draw(0, 0, client.getWidth(), client.getHeight());
    fbo.end();
    
    ofTexture texture = fbo.getDepthTexture();
    
    
    ofPixels pixels;
    
    fbo.readToPixels(pixels);
    
    
    screenshot.setFromPixels(pixels.getPixels(), client.getWidth(), client.getHeight(), OF_IMAGE_COLOR, true);
    //pixels.clear();
    */
    
    screenshotGenerated = true;
    //screenshot.saveImage("syphonVisual.png");
    
}


void VisualSyphon::draw(unsigned int x, unsigned int y, unsigned int w, unsigned int h) {
    if (!active) return;
    
    client.draw(x, y, w, h);
    
    if (!screenshotGenerated) createThumbnail();
}

string  VisualSyphon::getAppName() {
    return client.getApplicationName();
}

string  VisualSyphon::getServerName()  {
    return client.getServerName();
}


bool VisualSyphon::getActive() {
    return active;
}


void VisualSyphon::setActive(bool _active) {
    active = _active;
}
