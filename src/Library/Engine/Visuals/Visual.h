/*
 *  Video.h
 *  VJingApp
 *
 *  Created by Daniel Almeida on 12/13/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */


#ifndef __VISUAL_H__
#define __VISUAL_H__

#include "ofMain.h"
#include <stdlib.h>
#include "json.hpp"


using json = nlohmann::json;


typedef enum VisualType {
    VisualType_Video = 0,
    VisualType_Camera,
    VisualType_Syphon,
    VisualType_Generator
} VisualTypes;

#define THUMBNAIL_WIDTH 160



/*!
 @class Visual
 @abstract ...
 @discussion ...
 */
class Visual {
    VisualType type;
    string caption;
    string thumbnailPath;
    string filePath;
	

public:
    ofImage screenshot;
    
	
	Visual();
	virtual ~Visual();
	
	
		
	// debug
	void print();	
	
	// screenshot
	void drawScreenshot(float x, float y, float w, float h);
    void setThumbnail();
    void saveThumbnail();
	void createThumbnail();
	void drawRoundedCornersScreenshot(float x, float y, float w, float h);
	void drawThumbnail(float x, float y, float w, float h);
    
    
    /** setters and getters **/
    
    VisualType getType () { return type; }
    void setType (VisualType _val) { type = _val; }
    
    string getCaption();
    void setCaption(string _val) { caption = _val; }
    
    string getThumbnailPath() { return thumbnailPath; }
    void setThumbnailPath(string _val) { thumbnailPath = _val; }
    
    
    /** setters and getters **/
    string getFilePath () { return filePath; }
    void setFilePath (string _val) { filePath = _val; }
    
    virtual json getState();

};


typedef std::list<Visual *> VisualsList;
typedef VisualsList::iterator VisualsListIterator;


#endif
