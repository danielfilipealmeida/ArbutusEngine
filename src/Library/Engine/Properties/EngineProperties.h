//
//  EngineProperties.h
//  ArbutusEngine
//
//  Created by Daniel Almeida on 29/07/17.
//
//

#ifndef EngineProperties_h
#define EngineProperties_h

#include <stdio.h>
#include "ofMain.h"

typedef enum  {
    PLAY_MODE = 0,
    LEARN_MODE
} EngineRunMode;

#define MAXIMUM_NUMBER_OF_LAYERS 6

class EngineProperties
{
    EngineProperties() {};
    
    EngineRunMode runMode;
    unsigned int mixerWidth, mixerHeight, mixerNLayers;
    unsigned int beatsToSnap, beatsCounter;
    Boolean metronomeOn, triggeringBeat, beatSnapInProgress;
    unsigned long long taps[4];
    int currentTapIndex = -1;
    string appSupportDir, currentFilePath;
    int selectedLayer, selectedColumn;

public:
 
    static EngineProperties& getInstance();
    EngineProperties(EngineProperties const&) = delete;
    void operator=(EngineProperties const&) = delete;
    
    void setDefaults();
    
    
    
#pragma mark getters
    
    
    unsigned int getMixerWidth();
    
    unsigned int getMixerHeight();

    int getSelectedLayerNumber ();

    int getSelectedColumnNumber ();

    unsigned int getBeatsToSnap();
  
    unsigned int getBeatsCounter();

    Boolean isMetronomeOn ();
  
    Boolean isTriggeringBeat ();

    string getCurrentFilePath();

    Boolean isBeatSnapInProgress();
    
    string getAppSupportDir();
    
   
#pragma mark setters
    
    
    void setMixerWidth ( unsigned int _width );
    
    void setMixerHeight ( unsigned int _height );
    
    void setSelectedLayerNumber ( int val );
    
    void setSelectedColumnNumber ( int val );
    
    void setBeatsToSnap ( unsigned int val );
    
    void setBeatsCounter ( unsigned int val );
    
    void setMetronomeOn ( Boolean val );
    
    void setTriggeringBeat ( Boolean val );

    void setNumberOfLayers(unsigned int _numLayers);

    void setCurrentFilePath(string _path);
    
    void setIsBeatSnapInProgress(Boolean _val);
    
    void setAppSupportDir(string _path);
    
// stuff
    void
    incrementTap();
    
    /**!
     \brief process a tap
     \result return the new bpm when the last tap is done or null
     */
    unsigned int tap();
    
    
// beat - gather all stuff and move to another class
    void  beat();
    
};

#endif /* EngineProperties_h */
