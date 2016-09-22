//
//  SyphonOutputManager.hpp
//  Arbutus
//
//  Created by Daniel Almeida on 22/05/16.
//
//

#ifndef SyphonOutputManager_h
#define SyphonOutputManager_h

#include "ofMain.h"
#include <stdio.h>
#include "ofxSyphon.h"

#define N_SYPHON_CHANNEL_OUTPUTS    4

/*
typedef enum
{
    SyphonOutput_MainChannel = 0,
    SyphonOutput_Channel1,
    SyphonOutput_Channel2,
    SyphonOutput_Channel3,
    SyphonOutput_Channel4
} SyphonOutputChannelTypes;

*/

class SyphonOutputManager {
    ofxSyphonServer mainOutput;
    ofxSyphonServer channelsOutput[N_SYPHON_CHANNEL_OUTPUTS];
    
    bool mainOutputActive;
    bool channelOutputActive[0];
public:
    
    SyphonOutputManager();
    
    static SyphonOutputManager* getSingleton();
    
    void setSyphonMainOutput(string name);
    string getSyphonMainOutput();
    void publishMainOutputScreen(ofTexture* inputTexture);
    
    
    void setSyphonChannelOutput(unsigned short int channel, string name);
    string getSyphonChannelOutput(unsigned short int channel);
    void publishChannelOutputScreen(unsigned short int channel, ofTexture* inputTexture);
    
    void setMainOutputActive(bool active);
    bool getMainOuputActive();
    void setChannelOutputActive(unsigned short int channel, bool active);
    bool setChannelOutputActive(unsigned short int channel);
    
};

#endif /* SyphonOutputManager_h */
