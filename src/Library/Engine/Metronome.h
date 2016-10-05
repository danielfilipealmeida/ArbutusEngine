/*
 *  Metronome.h
 *  ARBUTUS
 *
 *  Created by Daniel Almeida on 1/2/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#ifndef __METRONOME_H__
#define __METRONOME_H__

#include "ofMain.h"
#include "ofThread.h"

class metronome : public ofThread{

    unsigned int BPM;
    unsigned int beatDuration;
    unsigned int beatCount;
    unsigned int longBeatCount;

public:
	
    metronome();
	
    void setBPM(unsigned int _bpm);
    unsigned int getBPM();
    unsigned int getBeatCount();
    unsigned int getLongBeatCount();
    
    void start();
    void stop();
    void reset();
    void resetMetronome();
	void threadedFunction();
};

#endif