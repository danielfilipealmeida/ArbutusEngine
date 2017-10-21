/*
 *  Properties.h
 *  VJingApp
 *
 *  Created by Daniel Almeida on 12/24/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */


#ifndef __PROPERTIES_H__
#define __PROPERTIES_H__

#include "ofMain.h"
#include "json.hpp"

using json = nlohmann::json;

typedef struct {
    float min;
    float max;
} floatLimits;


/*!
 \brief  Base class for properties
 
 Implements common functionality to handle properties
 */
class Properties {

protected:
    string  name;
    float   alpha; //0.0 - 1.0
    float   red, green, blue;
    float   brightness, contrast, saturation;
    
    std::map<string, floatLimits> floatPropertiesLimits;
    
public:

	/*!
     \brief Constructor
     */
	Properties();

    /*!
     \brief Destructor
     */
    ~Properties();
	
    /*!
     \brief Sets the maximum and minimum limits of affected properties
     */
    void setLimits();
    
    /**!
     @abstract ...
     */
    void reset();
    
    /**!
     @abstract ...
     */
	void print();
    
    
    /**!
     @abstract ...
     */
    string getName();
    
    
    /**!
     @abstract ...
     */
    void setName(string _input);
    

    /**!
     @abstract ...
     */
    float getAlpha();
    
    
    /**!
     @abstract ...
     */
    void setAlpha(float _input);
    

    /**!
     @abstract ...
     */
    float getRed();
    
    
    /**!
     @abstract ...
     */
    void setRed(float _input);
    

    /**!
     @abstract ...
     */
    float getGreen();
    
    
    /**!
     @abstract ...
     */
    void setGreen(float _input);

    
    /**!
     @abstract ...
     */
    float getBlue();
    
    
    /**!
     @abstract ...
     */
   void setBlue(float _input);

    /**!
     @abstract ...
     */
    float getBrightness();
    
    
    /**!
     @abstract ...
     */
    void setBrightness(float _input);
    

    /**!
     @abstract ...
     */
    float getContrast();
    
    
    /**!
     @abstract ...
     */
    void setContrast(float _input);
    

    /**!
     @abstract ...
     */
    float getSaturation();
    
    
    /**!
     @abstract ...
     */
    void setSaturation(float _input);
    
    
    /**!
     @abstract ...
     */
    json getState();
	
    /**
     \brief Returns the complete state information
     
     The complete state isn't changeable. It contains the datatype and the limits.
     */
    json getFullState();
};

#endif
