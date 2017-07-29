//
//  SyphonOutputManager.cpp
//  Arbutus
//
//  Created by Daniel Almeida on 22/05/16.
//
//

#include "SyphonOutputManager.h"

SyphonOutputManager *syphonOutputManagerSingleton = NULL;


SyphonOutputManager::SyphonOutputManager() {
    syphonOutputManagerSingleton = this;
    
    mainOutputActive = false;
    for (unsigned short int f = 0;
         f < N_SYPHON_CHANNEL_OUTPUTS;
         f++)
    {
        channelOutputActive[f] = false;
    }
    
}

SyphonOutputManager* SyphonOutputManager::getSingleton() {
    return syphonOutputManagerSingleton;
}

void SyphonOutputManager::setSyphonMainOutput(string name) {
    mainOutput.setName(name);
    
}

string SyphonOutputManager::getSyphonMainOutput() {
    return mainOutput.getName();
}

void SyphonOutputManager::publishMainOutputScreen(ofTexture* inputTexture) {
    if (mainOutputActive == false) return;
    if (inputTexture == NULL) mainOutput.publishScreen();
    else mainOutput.publishTexture(inputTexture);

}


void SyphonOutputManager::setSyphonChannelOutput(unsigned short int channel, string name) {
    if (channel >= N_SYPHON_CHANNEL_OUTPUTS) return;
    channelsOutput[channel].setName(name);
}


string SyphonOutputManager::getSyphonChannelOutput(unsigned short int channel) {
    if (channel >= N_SYPHON_CHANNEL_OUTPUTS) return "";
    return channelsOutput[channel].getName();
}


void SyphonOutputManager::publishChannelOutputScreen(unsigned short int channel, ofTexture* inputTexture) {
    if (channel >= N_SYPHON_CHANNEL_OUTPUTS) return;
    if (channelOutputActive[channel] == false) return;
    if (inputTexture == NULL) return;
    
    channelsOutput[channel].publishTexture(inputTexture);
    
}

void SyphonOutputManager::setMainOutputActive(bool active) {
    mainOutputActive = active;
}

bool SyphonOutputManager::getMainOuputActive() {
    return mainOutputActive;
}


void SyphonOutputManager::setChannelOutputActive(unsigned short int channel, bool active) {
    if (channel >= N_SYPHON_CHANNEL_OUTPUTS) return;
    channelOutputActive[channel] = active;
}

bool SyphonOutputManager::setChannelOutputActive(unsigned short int channel) {
     if (channel >= N_SYPHON_CHANNEL_OUTPUTS) return false;
    return channelOutputActive[channel];
}

