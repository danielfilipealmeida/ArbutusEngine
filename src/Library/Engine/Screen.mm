//
//  Screen.cpp
//  FigTree
//
//  Created by Daniel Almeida on 17/05/14.
//
//

#include "Screen.h"

Screen::Screen() {
    primaryScreen = false;
    x = y = width = height = 0;
}

Screen::~Screen() {
    
}

void Screen::setLocation(unsigned int _x, unsigned int _y) {
    x = _x;
    y = _y;

}
void Screen::setDimension(unsigned int _width, unsigned int _height) {
    width = _width;
    height = _height;
    
}

void Screen::setPrimaryScreen(bool _primaryScreen) {
    primaryScreen = _primaryScreen;
    
}

bool Screen::isPrimaryScreen() {
    return primaryScreen;
}

