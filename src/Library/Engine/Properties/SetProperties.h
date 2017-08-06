//
//  SetProperties.hpp
//  Arbutus
//
//  Created by Daniel Almeida on 12/01/16.
//
//

#ifndef SetProperties_hpp
#define SetProperties_hpp




#include <stdio.h>



/*!
 @class SetProperties
 @abstract
 @discussion
 */
class SetProperties {
    bool stopCurrentVisualIfTriggeredInvalid;
    
public:
    SetProperties();
    
    /**!
     @abstract ...
     */
    void setStopCurrentVisualIfTriggeredInvalid(bool val);

    /**!
     @abstract ...
     */
    bool getStopCurrentVisualIfTriggeredInvalid();
};


#endif /* SetProperties_hpp */
