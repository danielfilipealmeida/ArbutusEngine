//
//  VisualSyphon.h
//  FigTree
//
//  Created by Daniel Almeida on 05/05/14.
//
//

#ifndef __FigTree__VisualSyphon__
#define __FigTree__VisualSyphon__

#include <iostream>

#include "Visual.h"
#include "ofxSyphon.h"
#include "ofJson.h"


/*!
 @class VisualSyphon
 @abstract
 @discussion
 */
class VisualSyphon : public Visual {
    ofxSyphonClient     client;
    bool                active;
    long long           loadTimestamp;
    bool                screenshotGenerated;
    string              serverName;
    string              appName;
public:
    
    
    VisualSyphon(string _serverName, string _appName);
    ~VisualSyphon();
    
    ofJson getState();
    void setState(ofJson state);
    
    string  getThumbnailPath();
    void    setThumbnail();
    void    saveThumbnail();
    void    createThumbnail();
    
    void    draw(unsigned int x, unsigned int y, unsigned int w, unsigned int h);
    
    
    string          getAppName();
    string          getServerName();
    
    bool            getActive();
    void            setActive(bool _active);
    
};

#endif /* defined(__FigTree__VisualSyphon__) */
