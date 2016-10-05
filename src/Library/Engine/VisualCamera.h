//
//  VisualCamera.h
//  FigTree
//
//  Created by Daniel Almeida on 02/05/14.
//
//

#ifndef __FigTree__VisualCamera__
#define __FigTree__VisualCamera__

#include <iostream>

#include "Visual.h"


class VisualCamera : public Visual {
    ofVideoGrabber      videoGrabber;
    Boolean             ready;
    unsigned long long  openTimestamp;


public:
    unsigned int    deviceId;
    unsigned int    frameRate;
    unsigned int    width, height;
    Boolean         isOpened;
    
    
    
    VisualCamera(unsigned int _deviceId,
                 unsigned int _frameRate    = 60,
                 unsigned int _width        = 640,
                 unsigned int _height       = 480);
    ~VisualCamera();

    string getThumbnailPath();
    void setThumbnail();
    void saveThumbnail();
    void createThumbnail();
    
    void print();
    
    void open();
    void close();
    
    void draw(unsigned int x, unsigned int y, unsigned int w, unsigned int h);
    void update();
    
    ofVideoGrabber *getVideoGrabber();

};





#endif /* defined(__FigTree__VisualCamera__) */
