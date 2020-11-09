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

using json = nlohmann::json;

typedef enum VisualType {
    VisualType_Video = 0,
    VisualType_Camera,
    VisualType_Syphon,
    VisualType_Generator
} VisualTypes;

#define THUMBNAIL_WIDTH 160



/*!
 \class Visual
 \brief ...
 @discussion ...
 */
class Visual {
    VisualType type;
    string caption;
    string thumbnailPath;
    string filePath;
    
protected:
    ofImage screenshot;
	

public:
 	
    /*!
     \brief ...
     */
	Visual();
    
    /*!
     \brief ...
     */
	virtual ~Visual();
	
		
    /*!
     \brief Prints debug information of the Visual
     */
    void print();
	
    
    /*!
     \brief Returns the screenshot
     */
    ofImage* getScreenshot();
    
	/*!
     \brief Draws the screenshot on screen in a rect
     \param x left
     \param y top
     \param w width
     \param h height
     */
	void drawScreenshot(float x, float y, float w, float h);

    /*!
     \brief ...
     */
    void setThumbnail();

    /*!
     \brief Save the thumbnail on the apps preferences folder.
     Creates recusively the enclosing directory if needed
     */
    void saveThumbnail();
	
    /*!
     \brief ...
     */
    void createThumbnail();
	
    /*!
     \brief ...
     */
    void drawRoundedCornersScreenshot(float x, float y, float w, float h);
	
    /*!
     \brief ...
     */
    void drawThumbnail(float x, float y, float w, float h);
    
    
#pragma mark setters and getters **/
    
    /*!
     \brief ...
     */

    VisualType getType ();

    /*!
     \brief ...
     */
    void setType (VisualType _val);
    
    /*!
     \brief ...
     */
    string getCaption();
    
    /*!
     \brief ...
     */
    void setCaption(string _val);
    
    /*!
     \brief ...
     */
    string getThumbnailPath();
    
    /*!
     \brief ...
     */
    void setThumbnailPath(string _val);
    
    
    /*!
     \brief ...
     */
    string getFilePath ();
    
    /*!
     \brief ...
     */
    void setFilePath (string _val);
    
    /*!
     \brief ...
     */
    virtual json getState();
    
    /*!
     \brief ...
     */
    virtual void setState(json state);

};


typedef std::list<Visual *> VisualsList;
typedef VisualsList::iterator VisualsListIterator;


#endif
