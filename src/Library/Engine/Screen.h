//
//  Screen.h
//  FigTree
//
//  Created by Daniel Almeida on 17/05/14.
//
//

#ifndef __FigTree__Screen__
#define __FigTree__Screen__

#include <iostream>
#include <stdlib.h>
#include "ofMain.h"
#import <Foundation/Foundation.h>

class Screen {
    unsigned int x, y, width, height;
    bool primaryScreen;
  
public:
    Screen();
    ~Screen();
    
    void setLocation(unsigned int _x, unsigned int _y);
    void setDimension(unsigned int _width, unsigned int _height);
    void setPrimaryScreen(bool _primaryScreen);
    
    bool isPrimaryScreen();
    
    NSRect getNSRect();
};


typedef std::list<Screen *> ScreensList;
typedef ScreensList::iterator ScreensListIterator;


NSRect getMainScreenRect();

#endif /* defined(__FigTree__Screen__) */
