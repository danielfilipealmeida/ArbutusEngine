/*
 *  Metronome.h
 *  ARBUTUS
 *
 *  Created by Daniel Almeida on 1/2/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#ifndef __FILEMANAGER_H__
#define __FILEMANAGER_H__

#include "ofMain.h"
#include "ofThread.h"

class FileManager : public ofThread{
    
public:
    
    FileManager();
    void start();
    void stop();
    void reset();
    void threadedFunction();
};

#endif