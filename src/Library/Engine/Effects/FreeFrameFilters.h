/*
 *  FreeFrameFilter.h
 *  VJingApp
 *
 *  Created by Daniel Almeida on 1/8/12.
 *  Copyright 2012 __MyCompanyName__. All rights reserved.
 *
 */

#include "ofMain.h"


#ifdef _OFX_FFGL_HOST
#include "ofxFreeFrame.h"

#ifndef _FREEFRAMEFILTER_H_
#define _FREEFRAMEFILTER_H_



/*!
 @class FreeFrameFilter
 @abstract  
 @discussion
 */
class FreeFrameFilter {
    string filterName;
    unsigned int number;
    bool active;
    bool loaded;

public:
	
	FreeFrameFilter(string _filterName, unsigned int _number = 0);
	~FreeFrameFilter(){};
	
	void load();
};



typedef std::vector<FreeFrameFilter *> FreeFrameFilterList;
typedef FreeFrameFilterList::iterator FreeFrameFilterListIterator;


class FreeFrameFilterHost {
    ofxFFGLHost     ffHost;
    FreeFrameFilterList freeFrameList;
    Boolean	pluginsScanned;
    Boolean locked;
    unsigned int width, height;
    unsigned int loadedPlugins;


public:
	
	FreeFrameFilterHost();
	~FreeFrameFilterHost();
	
	void init(unsigned int _width, unsigned int _height);
	void loadPlugin(string pluginName);
	void scanForPlugins();
	
	string getPluginName(unsigned int pos);
	FreeFrameFilter* getFilter(unsigned int filterN);
	void draw(unsigned int x, unsigned int y,unsigned int width, unsigned int height);
	void loadData(unsigned char *data, unsigned int _width, unsigned int _height);
	void process();
};



class FreeFrameFilterInstance {
    ofxFFGLPlugin			plugin;
    FreeFrameFilterHost *host;
    FreeFrameFilter		*filter;
    Boolean				active;
    typedef std::vector<string> ParameterList;
    typedef ParameterList::iterator ParameterListIterator;
    ParameterList parameterList;


public:

	
	FreeFrameFilterInstance(FreeFrameFilterHost *_host, FreeFrameFilter *_filter = NULL);
	~FreeFrameFilterInstance();
	
	void setActive(Boolean _active) {active = _active;}
	unsigned int getNumberOfParameters();
	string getParameterName(unsigned int position);
};

 

typedef std::vector<FreeFrameFilterInstance *> FreeFrameFilterInstanceList;
typedef FreeFrameFilterInstanceList::iterator FreeFrameFilterInstanceListIterator;


#endif // end _FREEFRAMEFILTER_H_
#endif // end _OFX_FFGL_HOST
