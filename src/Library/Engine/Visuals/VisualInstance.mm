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
#include "Utils.h"
#include "Engine.h"




#define VISUAL_CLOSE_MINUTES_SINCE_OPEN 1
#define VISUAL_CLOSE_MINUTES_SINCE_LAST_PLAY 1


extern ofApp *app;
extern Engine *enginePtr;

VisualInstance::VisualInstance() {
	visual = NULL;
	properties.setIsPlaying (false);
}

VisualInstance::VisualInstance(Visual *_visual, unsigned int layer, unsigned int column) {
	if (_visual == NULL) throw "Invalid visual";
    
    visual = _visual;
	properties.setLayer (layer);
	properties.setColumn (column);
	properties.setIsPlaying (false);
}


VisualInstance::~VisualInstance() {
    unloadVideo();
}


bool VisualInstance::loadVideo() {
	string filePath;
    
	properties.setIsPlaying ( false );
    
    if (visual == NULL) return false;
    if (visual->getType () != VisualType_Video) return false;
    
    filePath = ((VisualVideo *) visual)->getFilePath ();
    if (!checkFileExists(filePath)) throw "File '" + filePath + "' doesn't exist.";
    if (!this->video.load(filePath)) throw "Error opening file '" + filePath + "'";
            
    properties.setOpenedTimestampToNow();
    
    return true;
}


bool
VisualInstance::checkFileExists(string path) {
    fstream fin;
    bool fileExists;
    
    string fileNameInOF = ofToDataPath(path);
    fin.open(fileNameInOF.c_str(),ios::in);
    if ( fin.is_open() ) {
        fileExists = true;
    }
    fin.close();
    
    return (fileExists) ? true : false;
}


bool
VisualInstance::unloadVideo() {
    properties.setIsPlaying (false);
    if (video.isLoaded() == false) return false;
	video.close();
        //cout << "Video instance for video UNloaded" << endl;
    return true;
}



void VisualInstance::unload() {
    if (visual->getType () == VisualType_Video) unloadVideo();
}





void VisualInstance::play(bool forcePlay)
{
	if (visual == NULL) return;
    
    properties.setIsTriggered (false);
    properties.setLastPlayedTimestampToNow ();
    
    
    if (visual->getType () == VisualType_Video) {
        if (video.isLoaded()==false) loadVideo();
        if (video.isLoaded()==false) return;
        
        if (properties.getBeatSnap ()   == true &&
            EngineProperties::getInstance().isMetronomeOn ()   == true &&
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
    if (
        properties.getBeatSnap () == true &&
        EngineProperties::getInstance().isMetronomeOn() == true
    ) {
        properties.setIsTriggered (true);
    }
    else {
        video.firstFrame();
        properties.setLastPlayedTimestampToNow();
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
 * @param  x x position
 * @param  y y position
 * @param width the width
 * @param height the height
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

void
VisualInstance::updateVideo() {
    if (visual->getType() != VisualType_Video) return;
    if (video.isLoaded()==false) return;
    if (video.isPlaying()==false) return;
        
    video.update();
        
        
        
    // THIS NEEDS TO BE TESTED
    //float currentVideoPosition = video.getPosition();
    //calculateCurrentPlayeadPosition(currentVideoPosition);
    
}

void
VisualInstance::update() {
	if (visual==NULL) return;
    updateVideo();
    

    
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
void
VisualInstance::print()
{
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



#pragma mark getters and setters

VisualType
VisualInstance::getVisualType()
{
    return visual->getType();
}




#pragma mark State Handling


json
VisualInstance::getState() {
    json state;
    
    state = json::object();
    state["properties"] = properties.getState();
    state["videoX"] = videoX;
    state["videoY"] = videoX;
    state["videoWidth"] = videoWidth;
    state["videoHeight"] = videoHeight;
    state["visual"] = (visual!=NULL) ? visual->getState() : json::object();
    
    return state;
}


#pragma mark Actions

void VisualInstance::handleAction(string parameter, json data) {
    
    float value;
    //cout << data.dump() << endl;
    //cout << parameter<<endl;
    
    
    value = data["value"].get<float>();
    
    switch (str2int(parameter.c_str())) {
        case str2int("Alpha"):
            properties.setAlpha(value);
            break;

        case str2int("Brightness"):
            properties.setBrightness(value);
            break;
            
            
        case str2int("Contrast"):
            properties.setContrast(value);
            break;
            
        case str2int("Saturation"):
            properties.setSaturation(value);
            break;
            
        case str2int("Red"):
            properties.setRed(value);
            break;
            
        case str2int("Green"):
            properties.setGreen(value);
            break;
            
        case str2int("Blue"):
            properties.setBlue(value);
            break;

        case str2int("Zoom X"):
            properties.setZoomX(value);
            break;
            
        case str2int("Zoom Y"):
            properties.setZoomY(value);
            break;
            
        case str2int("Center X"):
            properties.setCenterX(value);
            break;

        case str2int("Center Y"):
            properties.setCenterY(value);
            break;

        case str2int("Start"):
            properties.setStartPercentage(value);
            break;

        case str2int("End"):
            properties.setEndPercentage(value);
            break;

        case str2int("Played"):
            properties.setPercentagePlayed(value);
            break;

        case str2int("Direction"):
            PlayheadDirection direction;
            direction = (PlayheadDirection) round(value);
            properties.setDirection(direction);
            break;
            
        case str2int("Loop Mode"):
            LoopMode loopMode = (LoopMode) round(value);
            properties.setLoopMode(loopMode);
            break;
    }
}




#pragma mark VisualInstances


unsigned int VisualInstances::getIndex(VisualInstance *instance) {
    unsigned int counter = 0;
    for(auto visualInstance:visualInstanceList) {
        if (visualInstance == instance) break;
        
        counter++;
    }
    return counter;
}

json VisualInstances::getState() {
    json state;

    for(auto visualInstance:visualInstanceList) {
        json instanteState = visualInstance->getState();
        instanteState["index"] = getIndex(visualInstance);
        state.push_back(instanteState);
    }
    
    return state;
}


VisualInstance * VisualInstances::add(Visual *visual, unsigned int layer, unsigned int column) {
    if (inColumn(layer, column) == true) {
        remove(layer, column);
	}
 
	VisualInstance *instance = new VisualInstance(visual, layer, column);
	visualInstanceList.push_back(instance);
	
    return instance;
 }

void VisualInstances::remove(unsigned int layer, unsigned int column) {
    
    for(VisualInstanceListIterator it = visualInstanceList.begin();
        it !=visualInstanceList.end();
        it++) {
        VisualInstance *visualInstance = *it;
        if (visualInstance->getProperties()->getLayer () == layer &&
            visualInstance->getProperties()->getColumn () == column)
        {
            visualInstanceList.erase(it);
            break;
        }
    }
}

void VisualInstances::remove(Visual *visual) {
    for(VisualInstanceListIterator it = visualInstanceList.begin();
        it !=visualInstanceList.end();
        it++) {
        VisualInstance *visualInstance = *it;
        if (visualInstance->visual == visual) {
            visualInstanceList.erase(it);
        }
    }
}

void VisualInstances::empty() {
    
    for(auto visualInstance:visualInstanceList) {
         delete visualInstance;
    }
    
    visualInstanceList.empty();
}


VisualInstance* VisualInstances::get(unsigned int layerN, unsigned int column)
{
    if (count() == 0) return NULL;
    
    for(auto visualInstance:visualInstanceList)
    {
        VisualInstancesProperties properties;
        
        properties = *visualInstance->getProperties();
        
        if (properties.getLayer()  == layerN &&
            properties.getColumn() == column)
        {
            return visualInstance;
        }
    }
    return NULL;
}


void VisualInstances::loadAll() {
    for(auto visualInstance:visualInstanceList) {
        visualInstance->loadVideo();
    }
}


unsigned int VisualInstances::count() {
    return (unsigned int) visualInstanceList.size();
}

Boolean VisualInstances::inColumn(unsigned int layerN, unsigned int column) {
    Boolean res = false;
    for(auto visualInstance:visualInstanceList)
    {
        if (visualInstance->getProperties()->getLayer () == layerN &&
            visualInstance->getProperties()->getColumn () == column)
        {
         res = true;
            break;
        }
    }
    
    return res;
}

int VisualInstances::getLastColumnInLayer(unsigned int layer) {
    int result = -1;
    for(auto visualInstance:visualInstanceList) {
        unsigned int column = visualInstance->getProperties()->getColumn ();
         if (visualInstance->getProperties()->getLayer () == layer &&
            column > result)
         {
            result = column;
             break;
        }
    }
    
    
    return result;
}


void VisualInstances::cleanup() {
    
    if (count() == 0) return;
    
    for(auto visualInstance:visualInstanceList) {
        if (visualInstance->checkCloseCondition() == true) {
            visualInstance->unload();
        }
    }
    
}


void VisualInstances::print() {
    cout << "visual instances number: " << count()<<endl;
    cout << endl;
    cout << "** VISUAL INSTANCES ****"<<endl;
    int count = 1;
    for (auto visualInstance:visualInstanceList) {
         cout << "VISUAL INSTANCE " << count << ":"<<endl;
        visualInstance->print();
        count++;
        cout << endl;;
    }
}




///////////////////////////////////////////////////////////////////////////

#pragma mark Free Frame Functions

#ifdef _FREEFRAMEFILTER_H_

void
VisualInstance::addFreeFrameInstance(unsigned int instanceSlotNumber)
{
    FreeFrameFilter *filter;
    FreeFrameFilterInstance *freeFrameInstance;
    
    filter = app->engine.freeFrameHost.getFilter(instanceSlotNumber);
    if (filter == NULL) {
        return;
    }
    freeFrameInstance = new FreeFrameFilterInstance(&(app->engine.freeFrameHost), filter);
    freeFrameInstanceList.push_back(freeFrameInstance);
}



void
VisualInstance::removeFreeFrameInstance(unsigned int instanceSlotNumber)
{
    if (instanceSlotNumber >= freeFrameInstanceList.size()) return;
    freeFrameInstanceList.erase(freeFrameInstanceList.begin()+instanceSlotNumber);
}

#endif
