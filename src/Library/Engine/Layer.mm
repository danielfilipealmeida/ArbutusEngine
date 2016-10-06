/*
 *  Layer.mm
 *  VJingApp
 *
 *  Created by Daniel Almeida on 12/24/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#include "Layer.h"

#include "ofApp.h"
#include "Engine.h"


extern ofApp *app;
extern Engine *_engine;



Layer::Layer(){
	buffer = new ofFbo();
	buffer = NULL;
	activeInstance = NULL;
    schedulledInstance = NULL;
    shader.load([[[NSBundle mainBundle] pathForResource:@"layerShader" ofType:@"vert"] UTF8String], [[[NSBundle mainBundle] pathForResource:@"layerShader" ofType:@"frag"] UTF8String]);
}

Layer::~Layer() {
	destroyBuffer();
}

void Layer::render() {
    
	if (buffer==NULL) initBuffer();
	if (this->activeInstance==NULL) return;
	buffer->begin();
	
	// turn on shader and configure
	this->shader.begin();
	this->shader.setUniform1f("blurH", this->properties.getBlurH());
	this->shader.setUniform1f("blurV", this->properties.getBlurV());
	this->shader.setUniform1f("brightness", this->properties.getBrightness());
	this->shader.setUniform1f("contrast", this->properties.getContrast());
	this->shader.setUniform1f("saturation", this->properties.getSaturation());
	this->shader.setUniform1f("redTint", this->properties.getRed());
	this->shader.setUniform1f("greenTint", this->properties.getGreen());
	this->shader.setUniform1f("blueTint", this->properties.getBlue());
	
	//ofClear(0, 0, 0, properties.alpha / 255.0);
    
    unsigned int width, height;
    width   = (unsigned int) buffer->getWidth();
    height  = (unsigned int) buffer->getHeight();
    
	ofEnableAlphaBlending();
	ofSetColor(255, 255, 255, 255 * activeInstance->getProperties()->getAlpha());
	activeInstance->draw(0, 0, width, height);

    
	ofDisableAlphaBlending();
	// turn off shader
	shader.end();

	this->buffer->end();
    
    
    
    
    
    
	
	// check for active free frame filters in this layer
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
		// process freeframe if turned on
		ofPixels pixels;
		buffer->readToPixels(pixels);
		app->engine.freeFrameHost.ffHost.loadData(pixels.getPixels(), properties.width, properties.height, GL_RGBA);
		//app->engine.freeFrameHost.ffHost.setPluginActive(2, true);
		app->engine.freeFrameHost.ffHost.process();
		buffer->begin();
		app->engine.freeFrameHost.ffHost.draw(0, 0, properties.width, properties.height);
	 
		buffer->end();
	
	
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

/**
 *  @param x
 *  @param y
 *  @param width
 *  @param height
 */
void Layer::draw(int x, int y, int width, int height) {
	if (buffer==NULL) return;
	if (activeInstance==NULL) return;
	
	//ofClear(0, 0, 0, properties.alpha / 255.0);
	buffer->draw(x, y, width, height);	
}



void Layer::print() {
	//cout << "Layer number: "<< layerNumber<<endl;
	properties.print();
}

void Layer::initBuffer(){
	if (buffer==NULL) {
		buffer = new ofFbo();
		buffer->allocate(properties.getWidth(), properties.getHeight());
		
		// clear the fbo
		buffer->begin();
		ofClear(0, 0, 0, 0);
		buffer->end();
	}
}

void Layer::destroyBuffer() {
	if (buffer!=NULL) 	{
		delete buffer;
		buffer = NULL;
	}
}

/* ************************************************************************** */

#pragma mark video instances


void Layer::setActiveVisualInstance(VisualInstance *_activeInstance) {
	activeInstance = _activeInstance;
    schedulledInstance = NULL;
}

void Layer::stopActiveVisualInstance() {
	activeInstance = NULL;
}

void Layer::schedulleInstance(VisualInstance *_instance) {
    schedulledInstance = _instance;
}

void Layer::activateSchedulledInstance() {
    if (schedulledInstance==NULL) return;
    if(activeInstance!=NULL && activeInstance->video.isPlaying()) activeInstance->stop();
    activeInstance = schedulledInstance;
    schedulledInstance = NULL;
    
    activeInstance->play(true);
    activeInstance->video.setFrame(0);
}



void Layer::playVisualInstance(VisualInstance *newInstance) {
    VisualInstancesProperties *properties = newInstance->getProperties();
    
        // if snap is on and beat detection is on
    if (properties->getBeatSnap ()  == true &&
        _engine->isMetronomeOn()    == true &&
        _engine->isTriggeringBeat() != true
        ) {
        schedulleInstance(newInstance);
        return;
    }

    if (newInstance!=activeInstance) {
        if (activeInstance!=NULL) {
            activeInstance->stop();
        }
        setActiveVisualInstance(newInstance);
        newInstance->play();
        
    }
    if ( properties->getRetrigger() == true ) newInstance->retrigger();
    
}



ofTexture* Layer::getTexture() {
    return &buffer->getTextureReference();
    //return NULL;
}

///////////////////////////////////////////////////////////////////////////

#pragma mark Free Frame Functions
#ifdef _FREEFRAMEFILTER_H_

void Layer::addFreeFrameInstance(unsigned int instanceSlotNumber) {
	// get the free frame from the host
	FreeFrameFilter *filter = app->engine.freeFrameHost.getFilter(instanceSlotNumber);
	if (filter == NULL) return;
	
	// create an instance
	FreeFrameFilterInstance *freeFrameInstance = new FreeFrameFilterInstance(&(app->engine.freeFrameHost), filter);
	
	// add it to the list
	freeFrameInstanceList.push_back(freeFrameInstance);
}



void Layer::removeFreeFrameInstance(unsigned int instanceSlotNumber) {
	if (instanceSlotNumber >= freeFrameInstanceList.size()) return;
	freeFrameInstanceList.erase(freeFrameInstanceList.begin()+instanceSlotNumber);
}



FreeFrameFilterInstance* Layer::getFilterInstance(unsigned int instanceSlotNumber) {
	if (instanceSlotNumber >= freeFrameInstanceList.size()) return NULL;
	return freeFrameInstanceList[instanceSlotNumber];
}





#endif