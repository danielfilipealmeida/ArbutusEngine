//
//  VisualCamera.cpp
//  FigTree
//
//  Created by Daniel Almeida on 02/05/14.
//
//

#include "VisualCamera.h"


VisualCamera::VisualCamera(unsigned int _deviceId, unsigned int _frameRate, unsigned int _width, unsigned int _height) {
    Visual::Visual();
    
    setType (VisualType_Camera);
    deviceId = _deviceId;
    frameRate = _frameRate;
    width = _width;
    height = _height;
    isOpened = false;
    
    open();
    createThumbnail();
    close();

    
    vector<ofVideoDevice> listDevices = videoGrabber.listDevices();
    ofVideoDevice           device = listDevices[_deviceId];
    setCaption("Camera: " + device.deviceName);
}


VisualCamera::~VisualCamera() {
    videoGrabber.close();
    
}

void VisualCamera::open() {
    if (isOpened) return;
    isOpened = true;
    videoGrabber.setDeviceID(deviceId);
	videoGrabber.setDesiredFrameRate(frameRate);
	videoGrabber.initGrabber(width,height);
    //videoGrabber.getTextureReference().texData.bFlipTexture = true;
    ready = false;
    openTimestamp = ofGetElapsedTimeMillis();
}


void VisualCamera::close() {
    isOpened = false;
    videoGrabber.close();
}





string VisualCamera::getThumbnailPath() {
    return Visual::getThumbnailPath();
}

void VisualCamera::setThumbnail() {
    Visual::setThumbnail();
}

void VisualCamera::saveThumbnail() {
    Visual::saveThumbnail();
}


void VisualCamera::createThumbnail() {
    Visual::createThumbnail();
    if (!isOpened) open();
    videoGrabber.update();
	screenshot.allocate(videoGrabber.getWidth(), videoGrabber.getHeight(), OF_IMAGE_COLOR);
	screenshot.setFromPixels(videoGrabber.getPixels().getData(), videoGrabber.getWidth(), videoGrabber.getHeight(), OF_IMAGE_COLOR, true);
    
    
    //screenshot.saveImage("cameraVisual.png");
}

void VisualCamera::print() {
    
    
}

void VisualCamera::draw(unsigned int x, unsigned int y, unsigned int w, unsigned int h) {
    
    if (!isOpened) return;
    
    if(ready) videoGrabber.draw(x,y,w,h);
}




void VisualCamera::update() {
    if (!isOpened) return;
    
    videoGrabber.update();
    if (videoGrabber.isFrameNew()){
        ready = true;
    }
}

ofVideoGrabber *VisualCamera::getVideoGrabber() {
    ofVideoGrabber *grabber;
    grabber = &videoGrabber;
    return grabber;
}
