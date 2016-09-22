/*
 *  VisualInstance.mm
 *  VJingApp
 *
 *  Created by Daniel Almeida on 12/13/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */




#include "VisualInstance.h"
#include <fstream> 
#include "ofApp.h"
#include "Engine.h"




#define VISUAL_CLOSE_MINUTES_SINCE_OPEN 1
#define VISUAL_CLOSE_MINUTES_SINCE_LAST_PLAY 1


extern ofApp *app;
extern Engine *_engine;

VisualInstance::VisualInstance() {
	visual = NULL;
	properties.setIsPlaying (false);
}

VisualInstance::VisualInstance(Visual *_visual, unsigned int layer, unsigned int column) {
	visual = _visual;
	properties.setLayer (layer);
	properties.setColumn (column);
	properties.setIsPlaying (false);
}


VisualInstance::~VisualInstance() {
    unloadVideo();
}


bool VisualInstance::loadVideo() {
	bool result;
    
    // confirm if this is a video visual
    
    
	properties.setIsPlaying ( false );
	if (visual!=NULL) {
		bool fileExists;
		
        
        if (visual->getType () == VisualType_Video) {
            VisualVideo *visualVideo = (VisualVideo *) visual;
        
            // check if file exists
            fstream fin;
            string fileNameInOF = ofToDataPath( visualVideo->getFilePath () );
            fin.open(fileNameInOF.c_str(),ios::in);
            if ( fin.is_open() ) {
                fileExists = true;
            }
            fin.close();
            if (!fileExists) return false;
		
		
            // open the file
            result = this->video.loadMovie(visualVideo->getFilePath ());
            
            if (result==true) {
                properties.setOpenedTimestampToNow();
                //properties.setOpenedTimestamp (ofGetElapsedTimeMillis());
                    //cout << "Video instance for video loaded" << endl;
            }
            
            return result;
        }
	}	return false;
}


bool VisualInstance::unloadVideo() {
    properties.setIsPlaying (false);
    if (video.isLoaded() == false) return false;
	video.close();
        //cout << "Video instance for video UNloaded" << endl;
    return true;
}



void VisualInstance::unload() {
    if (visual->getType () == VisualType_Video) unloadVideo();
}


void VisualInstance::play(bool forcePlay) {
	if (visual == NULL) return;
    
    properties.setIsTriggered (false);
    properties.setLastPlayedTimestampToNow ();
    
    
    if (visual->getType () == VisualType_Video) {
        if (video.isLoaded()==false) loadVideo();
        if (video.isLoaded()==false) return;
        //video.getTextureReference().texData.bFlipTexture = true;
        
        
        if (properties.getBeatSnap ()   == true &&
            _engine->isMetronomeOn ()   == true &&
            forcePlay                   == false)
        {
            properties.setIsTriggered (true);
        } else {
            video.play();
        }
    }
    
    if (visual->getType () == VisualType_Camera) {
        VisualCamera *camera;
        camera = (VisualCamera *)visual;
        camera->open();
    }
    
	properties.setIsPlaying ( true );
    //print();
}




/**
 * Play the video again from the beggining.
 * If the video is set to snap and metronome is on, just set it to trigger on the next beat snap
 */
void VisualInstance::retrigger() {
    if (properties.getBeatSnap () == true && _engine->isMetronomeOn() == true ) {
        properties.setIsTriggered (true);
    }
    else {
        video.firstFrame();
        properties.setLastPlayedTimestampToNow();
        //properties.lastPlayedTimestamp = ofGetElapsedTimeMillis();
    }
}


void VisualInstance::stop() {
	if (visual == NULL) return;
    if (visual->getType () == VisualType_Video) {
        if (video.isLoaded()==false) return;
        video.stop();
    }
    if (visual->getType () == VisualType_Camera) {
        VisualCamera *camera;
        camera = (VisualCamera *)visual;
        //camera->close();
    }

	properties.setIsPlaying ( false );
}




/* ************************************************************************* */


void VisualInstance::autoLoadAndAutoPlayVideo() {
    if (visual->getType () != VisualType_Video) return;
    if (video.isLoaded() == false) loadVideo();
    if (video.isPlaying() == false || properties.getIsPlaying() == false) play();
        
    
 
}

bool VisualInstance::isFreeFrameFilterActive() {
    bool res = false;
    
#ifdef _FREEFRAMEFILTER_H_
    if (freeFrameInstanceList.size() == 0) return false;
    
    for(FreeFrameFilterInstanceListIterator it = freeFrameInstanceList.begin();
        it< freeFrameInstanceList.end();
        it++
        ) {
        
        FreeFrameFilterInstance *instance = *it;
        if (instance->filter->active == true) res = true;
            
    }
#endif
    return res;
}


/**
 * Draws the current visual instance.
 *
 * @param [unsigned int] x
 * @param [unsigned int] y
 * @param [unsigned int] width
 * @param [unsigned int] height
 */
void VisualInstance::draw(unsigned int x,
                          unsigned int y,
                          unsigned int width,
                          unsigned int height
                          ) {
    
    //int videoX, videoY, videoWidth, videoHeight;
    
	if (visual==NULL) return;
    autoLoadAndAutoPlayVideo();
	update();
	
	
	// check if there are free frame videos active
#ifdef _FREEFRAMEFILTER_H_
	unsigned int activeFreeFrameFilters = false;
	if (freeFrameInstanceList.size()>0) {
		for(FreeFrameFilterInstanceListIterator it = freeFrameInstanceList.begin();it< freeFrameInstanceList.end();it++) {
			FreeFrameFilterInstance *instance = *it;
			if (instance->filter->active == true) activeFreeFrameFilters = true;
			
		}
	}
#endif
	
    this->calculateDisplayRect(width, height);
    ofClear(0,0,0);
    
    switch (visual->getType()) {
        case VisualType_Video:
            video.draw(videoX, videoY, videoWidth, videoHeight);
            break;
            
        case VisualType_Camera:
            ((VisualCamera *)visual)->draw(videoX, videoY, videoWidth, videoHeight);
            break;
            
        case VisualType_Syphon:
            ((VisualSyphon *)visual)->draw(videoX, videoY, videoWidth, videoHeight);
            break;
            
        default:
            // does nothing
            break;
    }
    
    
#ifdef _FREEFRAMEFILTER_H_
	if (activeFreeFrameFilters==true) {
		ofEnableAlphaBlending();
		ofSetColor(255, 255, 255, 255*properties.effects_drywet);

		app->engine.freeFrameHost.draw(x, y, width, height);
		ofSetColor(255,255,255,0);
		ofDisableAlphaBlending();
	}
#endif
}



void VisualInstance::calculateDisplayRect(unsigned int width,
                                          unsigned int height
                                          ) {
    
    /*
    static int magicNumber;
    int currentMagicNumber = (int) round((this->properties.getZoomX()+this->properties.getZoomY()+this->properties.getCenterX() + this->properties.getCenterY()) * 1000);
    
    if (magicNumber==currentMagicNumber) return;
    magicNumber = currentMagicNumber;
    */
    //NSLog(@"%d", currentMagicNumber);
    
    videoWidth  = this->properties.getWidth () * this->properties.getZoomX ();
    videoHeight = this->properties.getHeight () * this->properties.getZoomY ();
    
    videoX      = (int) (((float) width / 2.0) - ( (float) (this->properties.getWidth () * this->properties.getZoomX () ) ) / 2.0 ) + (this->properties.getCenterX ()  *  ( (float) width / 2.0) );
    videoY      = (int) (((float) height / 2.0) - ( (float) (this->properties.getHeight () * this->properties.getZoomY () ) ) / 2.0 ) + (this->properties.getCenterY ()  *  ( (float) height / 2.0) );
}



void VisualInstance::drawVisualScreenshot(
                                          unsigned int x,
                                          unsigned int y,
                                          unsigned int width,
                                          unsigned int height
                                          ) {
	visual->drawScreenshot(x, y, width, height);
}






void VisualInstance::drawVisualThumbnail(unsigned int x, unsigned int y, unsigned int width, unsigned int height) {
	visual->drawThumbnail(x, y, width, height);
	
}


void VisualInstance::calculateCurrentPlayeadPosition(float position) {
    switch(properties.getLoopMode ()) {
        case LoopMode_Normal:
            handleNormalLoopMode(position);
            break;
            
        case LoopMode_PingPong:
            handlePingPongLoopMode(position);
            break;
            
        case LoopMode_Inverse:
            handleInverseLoopMode(position);
            break;
    }

}

void VisualInstance::handleNormalLoopMode(float position) {
    switch (properties.getDirection ()) {
        case Direction_Right:
            if (position>properties.getEndPercentage () ) {
                position = properties.getStartPercentage ();
                video.setPosition(position);
            }
            break;
            
        case Direction_Left:
            properties.setDirection (Direction_Right);
            position = properties.getStartPercentage ();
            video.setPosition(position);
            break;
    }
    

}


void VisualInstance::handlePingPongLoopMode(float position) {
    switch (properties.getDirection () ) {
        case Direction_Right:
            if (position>properties.getEndPercentage ()) {
                properties.setDirection (Direction_Left);
                position = properties.getEndPercentage ();
                    //video.setSpeed(video.getSpeed() * -1.0);
                if(video.getSpeed()>0) video.setSpeed( -1.0 * video.getSpeed());
                video.setPosition(position);
            }
            
            break;
            
        case Direction_Left:
            if (position<properties.getStartPercentage () ) {
                properties.setDirection (Direction_Right);
                position = properties.getStartPercentage ();
                    //video.setSpeed(video.getSpeed() * -1.0);
                if(video.getSpeed()<0) video.setSpeed( -1.0 * video.getSpeed());
                
                video.setPosition(position);
            }
            break;
    }
    
}

void VisualInstance::handleInverseLoopMode(float position) {
    switch (properties.getDirection () ) {
        case Direction_Left:
            if (position < properties.getStartPercentage () ) {
                position = properties.getEndPercentage ();
                video.setPosition(position);
            }
            if (position >properties.getEndPercentage () ) {
                position = properties.getEndPercentage ();
                video.setPosition(position);

            }
            break;
            
        case Direction_Right:
            if(video.getSpeed()>0) video.setSpeed( -1.0 * video.getSpeed());
            properties.setDirection (Direction_Left);
            break;
    }
    
}

/*
void VisualInstance::handleVideoGoingLeft() {
    float currentVideoPosition = video.getPosition();
    if (currentVideoPosition < properties.startPercentage) {
         switch (properties.loopMode) {
            case LoopMode_Normal:
                 
                video.setPosition(properties.startPercentage);
                break;
                
            case LoopMode_PingPong:
                properties.direction = Direction_Right;
                video.setPosition(properties.startPercentage);
                video.setSpeed(abs(video.getSpeed()));
                break;
                
            case LoopMode_Inverse:
                video.setPosition(properties.endPercentage);
                break;
         }

    }
    
}


void VisualInstance::handleVideoGoingRight() {
    float currentVideoPosition = video.getPosition();

    if (currentVideoPosition > properties.endPercentage) {
         switch (properties.loopMode) {
            case LoopMode_Normal:
                video.setPosition(properties.startPercentage);
                break;
            
            case LoopMode_PingPong:
                properties.direction = Direction_Right;
                video.setPosition(properties.startPercentage);
                video.setSpeed(abs(video.getSpeed()) * -1.0);
                break;
                
            case LoopMode_Inverse:
                video.setPosition(properties.endPercentage);
                break;
         }

    }
}

*/

void VisualInstance::update() {
	if (visual==NULL) return;
		
    
    if (visual->getType() == VisualType_Video) {
        if (video.isLoaded()==false) return;
        if (video.isPlaying()==false) return;

       video.update();
        
        
        
            // THIS NEEDS TO BE TESTED
        float currentVideoPosition = video.getPosition();
        calculateCurrentPlayeadPosition(currentVideoPosition);
        
        
        /*
        switch (properties.direction) {
            case Direction_Left:
                this->handleVideoGoingLeft();
                break;
                
            case Direction_Right:
                this->handleVideoGoingRight();
                break;
        }
        */
        
        
        /*
        
        // limit the frame
        if (properties.direction == Direction_Left) {
            if (currentVideoPosition<properties.startPercentage) {
                
                switch(properties.loopMode) {
                        
                    case LoopMode_Normal:
                        video.setPosition(properties.startPercentage);
                        break;
                        
                    case LoopMode_PingPong:
                        properties.direction = Direction_Right;
                        video.setPosition(properties.startPercentage);
                        video.setSpeed(video.getSpeed() * -1.0);
                        break;
                        
                    case LoopMode_Inverse:
                        video.setPosition(properties.endPercentage);
                        break;
                }

            }
            else if (currentVideoPosition>properties.endPercentage) {
                
                switch(properties.loopMode) {
                    case LoopMode_Normal:
                        video.setPosition(properties.startPercentage);
                        break;
                        
                    case LoopMode_PingPong:
                        properties.direction = Direction_Right;
                        video.setPosition(properties.endPercentage);
                        video.setSpeed(video.getSpeed() * -1.0);
                        break;
 
                    case LoopMode_Inverse:
                        video.setPosition(properties.endPercentage);
                        break;
                }
            }
        }
        
        else if (properties.direction == Direction_Right) {
            
            if (currentVideoPosition<properties.startPercentage) {
                
                switch(properties.loopMode) {
                    case LoopMode_Normal:
                        video.setPosition(properties.endPercentage);
                        break;
                        
                    case LoopMode_PingPong:
                        properties.direction = Direction_Left;
                        video.setPosition(properties.startPercentage);
                        video.setSpeed(video.getSpeed() * -1.0);
                        break;
                        
                    case LoopMode_Inverse:
                        video.setPosition(properties.endPercentage);
                        break;
                        
                        
                }

                
            }
            else if (video.getPosition()>properties.endPercentage) {
                
                switch(properties.loopMode) {
                    case LoopMode_Normal:
                        video.setPosition(properties.startPercentage);
                        break;
                        
                    case LoopMode_PingPong:
                        properties.direction = Direction_Right;
                        video.setPosition(properties.endPercentage);
                        video.setSpeed(video.getSpeed() * -1.0);
                        break;
                        
                    case LoopMode_Inverse:
                        video.setPosition(properties.endPercentage);
                        break;
                        
                        
                }

            }		
        }
         */

    }

    
    if (visual->getType() == VisualType_Camera) {
        ((VisualCamera *)visual)->update();
    }

	//video.idleMovie();
	
    
    
		
	
	// check if there are free frame plugins on and turn on only the used plugins
#ifdef _FREEFRAMEFILTER_H_
    unsigned int activeFreeFrameFilters = false;
	if (freeFrameInstanceList.size()>0) {
		for(FreeFrameFilterInstanceListIterator it = freeFrameInstanceList.begin();it< freeFrameInstanceList.end();it++) {
			FreeFrameFilterInstance *instance = *it;
			if (instance->filter->active == true) {
				activeFreeFrameFilters = true;
				
				unsigned int pluginNumber = instance->filter->number;
				//instance->host->ffHost.setPluginActive(pluginNumber, true);
				app->engine.freeFrameHost.ffHost.setPluginActive(pluginNumber, true);
			}
			
		}
	}
	if (activeFreeFrameFilters==true) {
		// proccess
		if (this->video.isFrameNew()) {
		    unsigned char *data = this->video.getPixels();
            app->engine.freeFrameHost.loadData(data, this->video.width, this->video.height);
			app->engine.freeFrameHost.process();
		}
	
		// turn them off
		for(FreeFrameFilterInstanceListIterator it = freeFrameInstanceList.begin();it< freeFrameInstanceList.end();it++) {
			FreeFrameFilterInstance *instance = *it;
			if (instance->filter->active == true) {
				unsigned int pluginNumber = instance->filter->number;
				//instance->host->ffHost.setPluginActive(pluginNumber, false);
				app->engine.freeFrameHost.ffHost.setPluginActive(pluginNumber, false);
			}
			
		}
	}
#endif
}

//debug
void VisualInstance::print(){
	cout        << "visual address: "<< visual<<endl;
	cout        << "size of object: "<< sizeof(this)<<endl;
	if (visual->getType() == VisualType_Video) {
        cout    << "          type: video"<<endl;
        cout    << "          file: "<< ((VisualVideo *)visual)->getFilePath ()  << endl;
    }
    //cout << "visual file path: " << visual->filePath<<endl;
	cout        << "         video: "<<&video<<endl;
	cout        << "        loaded: ";
	if(video.isLoaded() == true) cout << "Yes"; else cout << "No";
	cout << endl;
	properties.print();
}

///////////////////////////////////////////////////////////////////////////

#pragma mark Set & Get


void VisualInstance::setLoopMode(LoopMode _loopMode) {
	properties.setLoopMode(_loopMode);
	if (_loopMode == LoopMode_Normal) {
		this->video.setLoopState(OF_LOOP_NORMAL);
		this->video.setSpeed(abs(this->video.getSpeed()));
		properties.setDirection (Direction_Right);
	}
	if (_loopMode == LoopMode_PingPong) {
		this->video.setLoopState(OF_LOOP_PALINDROME);
		if (this->video.getSpeed()>0) properties.getDirection () == Direction_Right;
		else properties.setDirection (Direction_Left);
		
	}
	if (_loopMode == LoopMode_Inverse) {
		this->video.setLoopState(OF_LOOP_NORMAL);
		this->video.setSpeed(-1.0 * abs(this->video.getSpeed()));	
		properties.setDirection (Direction_Left);
	}	
}



#pragma mark information


float VisualInstance::getPercentagePlayed() {
    return ((float) video.getCurrentFrame()/ (float) video.getTotalNumFrames());
}

void  VisualInstance::setPercentagePlayed(float percentage) {
    if (!video.isLoaded()) return;
    video.setFrame(percentage * video.getTotalNumFrames());
}


/**
 *  Check if the elapsed time after opened and play as past
 *
 *  @return true or false
 */
bool VisualInstance::checkCloseCondition() {
    
    if (this->video.isPlaying()) return false;
    
    unsigned long long  currentTimestamp = ofGetElapsedTimeMillis();
    if (currentTimestamp - properties.getOpenedTimestamp () > VISUAL_CLOSE_MINUTES_SINCE_OPEN * 60000 &&
        currentTimestamp - properties.getLastPlayedTimestamp () > VISUAL_CLOSE_MINUTES_SINCE_LAST_PLAY * 60000) return true;
    
    return false;
    
}


///////////////////////////////////////////////////////////////////////////

#pragma mark Free Frame Functions

#ifdef _FREEFRAMEFILTER_H_

void VisualInstance::addFreeFrameInstance(unsigned int instanceSlotNumber) {
	// get the free frame from the host
	FreeFrameFilter *filter = app->engine.freeFrameHost.getFilter(instanceSlotNumber);
	if (filter == NULL) return;
	
	// create an instance
	FreeFrameFilterInstance *freeFrameInstance = new FreeFrameFilterInstance(&(app->engine.freeFrameHost), filter);
	
	// add it to the list
	freeFrameInstanceList.push_back(freeFrameInstance);
}

void VisualInstance::removeFreeFrameInstance(unsigned int instanceSlotNumber) {
	if (instanceSlotNumber >= freeFrameInstanceList.size()) return;
	freeFrameInstanceList.erase(freeFrameInstanceList.begin()+instanceSlotNumber);
}




#pragma mark getters and setters

VisualType VisualInstance::getVisualType() {
    return visual->getType();
}


#endif