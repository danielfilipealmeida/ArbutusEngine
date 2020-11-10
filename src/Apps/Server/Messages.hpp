//
//  messages.hpp
//  ArbutusEngine
//
//  Created by Daniel Almeida on 19/11/2017.
//

#ifndef Messages_hpp
#define Messages_hpp

#include <stdio.h>
#include "ofJson.h"


/*!
 Parses a ofJson request comming from a client and acts upon it.
 Replies to the user if necessary
 
 @param ofJson request
 @return ofJson
 */
ofJson handleJSONRequestForClient(ofJson request);

/*!
 Handles requests the ask to set the state
 */
ofJson handleSetState(ofJson request);


/*!
 Sets the value of a controller
 
 @param ofJson data for changing a layer
 @return ofJson
 */
ofJson setLayerControl(ofJson data);

/*!
 Traverses the input data and sets those parameters, returning the final set value to the client
 
 @param ofJson data for changing a state
 @return ofJson
 */
ofJson updateState(ofJson data);

ofJson updateLayers(ofJson layerData);

#endif /* messages_hpp */
