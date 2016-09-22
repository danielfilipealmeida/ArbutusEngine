/*
 *  FreeFrameFilter.mm
 *  VJingApp
 *
 *  Created by Daniel Almeida on 1/8/12.
 *  Copyright 2012 __MyCompanyName__. All rights reserved.
 *
 */

#include "FreeFrameFilters.h"

#ifdef _FREEFRAMEFILTER_H_


#include <sys/types.h>
#include <dirent.h>
#include <errno.h>
#include <iostream>
#include <string>
#include <sstream>
using namespace std;

#pragma mark FreeFrameFilter 

ofxFFGLHost *freeframeHost;

FreeFrameFilter::FreeFrameFilter(string _filterName, unsigned int _number) {
	filterName = _filterName;
	number = _number;
	loaded = false;
}


void FreeFrameFilter::load() {
	if (loaded == true) return;
	freeframeHost->loadPlugin(filterName.c_str(), "freeframe/");
	loaded = true;
	
}

#pragma mark FreeFrameFilterHost


FreeFrameFilterHost::FreeFrameFilterHost() {}

void FreeFrameFilterHost::init(unsigned int _width, unsigned int _height) {
	width = _width;
	height = _height;
	loadedPlugins = 0;
    this->ffHost.allocate(width, height, GL_RGBA);	
	freeframeHost = &this->ffHost;
	pluginsScanned = false;
}


FreeFrameFilterHost::~FreeFrameFilterHost() {

}


string FreeFrameFilterHost::getPluginName(unsigned int pos) {
	//if (pos>=freeFrameList.size()) pos = (freeFrameList.size()-1);
	if (pos>=freeFrameList.size()) return "";
	FreeFrameFilter *filter = freeFrameList[pos];
	return filter->filterName;
}


void FreeFrameFilterHost::loadPlugin(string pluginName) {
	
	//cout << "opening free frame plugin '"<<pluginName<<"'."<<endl;
	//ffHost.loadPlugin(pluginName.c_str(), "freeframe/");
	FreeFrameFilter *filter;
	filter = new FreeFrameFilter(pluginName, loadedPlugins);
	//ffHost.setPluginFloatParameter(loadedPlugins, 0, 0.5);
	freeFrameList.push_back(filter);
	loadedPlugins++;
	filter->load();
}


void FreeFrameFilterHost::scanForPlugins() {
		ofDirectory dir;

	if (locked == true) return;
	locked = true;
	
	if (pluginsScanned==true) return;
	//cout << "Scaning Free Frame Plugins"<<endl;
	dir.open("freeframe/");

	dir.listDir();
	dir.sort();
	for(int f=0;f<(int) dir.size();f++) {
		string file = dir.getName(f);
		//cout << "Found " << file << endl;
		int pos = file.find(".bundle");
		string pluginName = file.substr(0, pos);
		loadPlugin(pluginName);
	}
	
	pluginsScanned=true;
	locked = false;
}


FreeFrameFilter* FreeFrameFilterHost::getFilter(unsigned int filterN) {
	if (freeFrameList.size() == 0) return NULL;
	if (filterN >= freeFrameList.size()) filterN = freeFrameList.size()-1;
	return freeFrameList[filterN];
}

void FreeFrameFilterHost::draw(unsigned int x, unsigned int y,unsigned int width, unsigned int height) {
	ffHost.draw(x, y, width, height);
}

void FreeFrameFilterHost::loadData(unsigned char *data, unsigned int _width, unsigned int _height){
	ffHost.loadData(data, _width, _height, GL_RGBA);
}


void FreeFrameFilterHost::process() {
	ffHost.process();
}


////////////////////////////////////////////////////////////////////////////
#pragma mark FreeFrameFilterInstance


FreeFrameFilterInstance::FreeFrameFilterInstance(FreeFrameFilterHost *_host, FreeFrameFilter *_filter) {
	host = _host;
	filter = _filter;
	active = true;

	plugin = host->ffHost.getPlugin(filter->number);

	// get the parameters number
	for (int f=0; f<plugin.getTotalParameters();f++) {
		const char *parameterName = plugin.getParameterName(f);
		stringstream ss;
		string s;
		ss << parameterName;
		ss >> s;
		parameterList.push_back(s);
	}
}

FreeFrameFilterInstance::~FreeFrameFilterInstance() {

}

unsigned int FreeFrameFilterInstance::getNumberOfParameters() {
	return plugin.getTotalParameters();
}

string FreeFrameFilterInstance::getParameterName(unsigned int position) {
	if (position>parameterList.size()) return "";
	return (parameterList[position]);
}

#endif