//
//  SizeProperties.hpp
//  ArbutusEngine
//
//  Created by Daniel Almeida on 21/10/2017.
//

#ifndef SizeProperties_h
#define SizeProperties_h

#include <stdio.h>
#include "json.hpp"

using json = nlohmann::json;

typedef struct {
    unsigned int min;
    unsigned int max;
} uintLimits;


#define PROPERTY_MAX_WIDTH  1920
#define PROPERTY_MAX_HEIGHT 1080

class SizeProperties {
    unsigned int    width;
    unsigned int    height;
    
    const uintLimits widthLimits = {0, PROPERTY_MAX_WIDTH};
    const uintLimits heightLimits = {0, PROPERTY_MAX_HEIGHT};

public:
    
    SizeProperties();
    ~SizeProperties();
    
    /*!
      \brief returns the width
     */
    unsigned int getWidth();
    
    
    /*!
      \brief
     */
    void setWidth(unsigned int _width);
    
    
    
    /*!
      \brief returns the height
     */
    unsigned int getHeight();
    
    
    /*!
      \brief
     */
    void setHeight(unsigned int _height);
    
    
    json getState(json state);
    
    /*!
     \brief Returns the complete state information
     
     The complete state isn't changeable. It contains the datatype and the limits.
     */
    json getFullState(json fullState);
    
};

#endif /* SizeProperties_h */
