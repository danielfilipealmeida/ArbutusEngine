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
 
    /*!
     \brief
     */
    static EngineProperties& getInstance();
    
    /*!
     \brief
     */
    EngineProperties(EngineProperties const&) = delete;
    
    /*!
     \brief
     */
    void operator=(EngineProperties const&) = delete;
    
    /*!
     \brief
     */
    void setDefaults();
    
    
    
#pragma mark getters
    
    /*!
     \brief
     */
    unsigned int getMixerWidth();
    
    /*!
     \brief
     */
    unsigned int getMixerHeight();

    /*!
     \brief
     */
    int getSelectedLayerNumber ();
    
    /*!
     \brief
     */
    int getSelectedColumnNumber ();

    /*!
     \brief
     */
    unsigned int getBeatsToSnap();
  
    /*!
     \brief
     */
    unsigned int getBeatsCounter();

    /*!
     \brief
     */
    Boolean isMetronomeOn ();
  
    /*!
     \brief
     */
    Boolean isTriggeringBeat ();

    /*!
     \brief
     */
    string getCurrentFilePath();

    /*!
     \brief
     */
    Boolean isBeatSnapInProgress();
    
    /*!
     \brief
     */
    string getAppSupportDir();
    
   
#pragma mark setters
    
    /*!
     \brief
     */
    void setMixerWidth ( unsigned int _width );
    
    /*!
     \brief
     */
    void setMixerHeight ( unsigned int _height );
    
    /*!
     \brief
     */
    void setSelectedLayerNumber ( int val );
    
    /*!
     \brief
     */
    void setSelectedColumnNumber ( int val );
    
    /*!
     \brief
     */
    void setBeatsToSnap ( unsigned int val );
    
    /*!
     \brief
     */
    void setBeatsCounter ( unsigned int val );
    
    /*!
     \brief
     */
    void setMetronomeOn ( Boolean val );
    
    /*!
     \brief
     */
    void setTriggeringBeat ( Boolean val );

    /*!
     \brief
     */
    void setNumberOfLayers(unsigned int _numLayers);

    /*!
     \brief
     */
    void setCurrentFilePath(string _path);
    
    /*!
     \brief
     */
    void setIsBeatSnapInProgress(Boolean _val);
    
    /*!
     \brief
     */
    void setAppSupportDir(string _path);
    
#pragma mark stuff
    
    /*!
     \brief
     */
    void incrementTap();
    
    /**!
     \brief process a tap
     \result return the new bpm when the last tap is done or null
     */
    unsigned int tap();
    
    /*!
     \brief
     */
    void  beat();
    
};

#endif /* EngineProperties_h */
