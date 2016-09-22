/*
 *  Metronome.cpp
 *  ARBUTUS
 *
 *  Created by Daniel Almeida on 1/2/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#include "Metronome.h"
#include "ofApp.h"
#include "Engine.h"

extern Engine *enginePtr;



metronome::metronome(){
    setBPM(120);
    beatCount       = 1;
    longBeatCount   = 1;
}

unsigned int metronome::getBPM() {
    return BPM;
}

void metronome::start() {
    startThread();
}


void metronome::stop(){
    stopThread();
}

void metronome::resetMetronome() {
    stop();
    waitForThread();
    start();
}


void metronome::setBPM(unsigned int _bpm){
	BPM = _bpm;
	beatDuration = 60000 / BPM;
	
}

unsigned int metronome::getBeatCount() {
    return beatCount;
}

unsigned int metronome::getLongBeatCount() {
    return longBeatCount;
}

void metronome::threadedFunction(){
	while (isThreadRunning() != 0){
		if(lock()){
            (beatCount < 4) ?  beatCount++ : beatCount = 1;
            (longBeatCount < 64) ? longBeatCount++ : longBeatCount = 1;
            //beatCount++;
            //if (beatCount>4) beatCount=1;
            
			//cout << "beat" << endl;
			enginePtr->beat();
			
            
			unlock();
			ofSleepMillis(beatDuration);
		}
	}
}