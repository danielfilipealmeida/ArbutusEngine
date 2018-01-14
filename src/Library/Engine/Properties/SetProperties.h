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
 \brief Stores and handles properties of a Set
 */
class SetProperties {
    bool stopCurrentVisualIfTriggeredInvalid;
    
public:
    /**!
     \brief Constructure of the SetProperties object
     */
    SetProperties();
    
    /**!
     \brief ...
     */
    void setStopCurrentVisualIfTriggeredInvalid(bool val);

    /**!
     \brief ...
     */
    bool getStopCurrentVisualIfTriggeredInvalid();
};


#endif /* SetProperties_hpp */
