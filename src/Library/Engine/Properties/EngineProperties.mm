//
//  EngineProperties.c
//  ArbutusEngine
//
//  Created by Daniel Almeida on 29/07/17.
//
//

#include "EngineProperties.h"

EngineProperties&
EngineProperties::getInstance() {
    static EngineProperties instance;
    
    instance.setDefaults();
    
    return instance;
}

void
EngineProperties::setDefaults() {
    mixerWidth=640;
    mixerHeight=480;
    mixerNLayers = 3;
    beatsToSnap = 4;
    beatSnapInProgress = false;
    currentFilePath = "";
    runMode = PLAY_MODE;
 
}

void
EngineProperties::beat() {
    triggeringBeat = false;
    
    ++beatsCounter;
    if (beatsCounter > 32) {
        beatsCounter = 0;
    }
    
    if (beatsCounter % beatsToSnap == 0.0) {
        setTriggeringBeat(true);
        setIsBeatSnapInProgress(true);
        beatSnapInProgress = true;
    }
}



void
EngineProperties::incrementTap() {
    currentTapIndex = (currentTapIndex >- 1) ? ++currentTapIndex : currentTapIndex;
    
}

unsigned int
EngineProperties::tap() {
    unsigned long  long a, b, c;
    float newBpm;
    a = taps[1] - taps[0];
    unsigned long long elapsedTime = ofGetElapsedTimeMillis();

    incrementTap();
    
    taps[currentTapIndex] = elapsedTime;

    if (currentTapIndex != 3) return NULL;
    
    b = taps[2] - taps[1];
    c = taps[3] - taps[2];
    
    
    // eesta formula está errada
    newBpm = (((float)(a+b+c) / 3.0 ));
    newBpm = (60000.0 / (float) (newBpm));
    
    // reset
    currentTapIndex=-1;
    
    return (unsigned int) round(newBpm);
}


// getters
unsigned int
EngineProperties::getMixerWidth() {
    return mixerWidth;
};

unsigned int
EngineProperties::getMixerHeight() {
    return mixerHeight;
};

int
EngineProperties::getSelectedLayerNumber () {
    return selectedLayer;
}

int
EngineProperties::getSelectedColumnNumber () {
    return selectedColumn;
}

unsigned int
EngineProperties::getBeatsToSnap() {
    return beatsToSnap;
}

unsigned int
EngineProperties::getBeatsCounter() {
    return beatsCounter;
}

Boolean
EngineProperties::isMetronomeOn () {
    return metronomeOn;
}

Boolean
EngineProperties::isTriggeringBeat () {
    return triggeringBeat;
}

string
EngineProperties::getCurrentFilePath() {
    return currentFilePath;
}

Boolean
EngineProperties::isBeatSnapInProgress() {
    return beatSnapInProgress;
}

string
EngineProperties::getAppSupportDir() {
    return appSupportDir;
}


// setters
void
EngineProperties::setMixerWidth ( unsigned int _width ) {
    mixerWidth = _width;
}

void
EngineProperties::setMixerHeight ( unsigned int _height ) {
    mixerHeight = _height;
}

void
EngineProperties::setSelectedLayerNumber ( int val ) {
    selectedLayer = val;
}

void
EngineProperties::setSelectedColumnNumber ( int val ) {
    selectedColumn = val; }

void
EngineProperties::setBeatsToSnap ( unsigned int val ) {
    beatsToSnap = val; }

void
EngineProperties::setBeatsCounter ( unsigned int val ) {
    beatsCounter = val;
}

void
EngineProperties::setMetronomeOn ( Boolean val ) {
    metronomeOn = val;
}

void
EngineProperties::setTriggeringBeat ( Boolean val ) {
    triggeringBeat = val;
}

void
EngineProperties::setNumberOfLayers(unsigned int _numLayers) {
    mixerNLayers = _numLayers; }

void
EngineProperties::setCurrentFilePath(string _path) {
    currentFilePath = _path;
}

void
EngineProperties::setIsBeatSnapInProgress(Boolean _val) {
    beatSnapInProgress = _val;
}

void
EngineProperties::setAppSupportDir(string _path) {
    appSupportDir = _path;
}

