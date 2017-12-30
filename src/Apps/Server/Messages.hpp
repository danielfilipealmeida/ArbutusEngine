//
//  messages.hpp
//  ArbutusEngine
//
//  Created by Daniel Almeida on 19/11/2017.
//

#ifndef Messages_hpp
#define Messages_hpp

#include <stdio.h>
#include "json.hpp"

using json = nlohmann::json;

/*!
 Parses a json request comming from a client and acts upon it.
 Replies to the user if necessary
 
 @param json request
 @return json
 */
json handleJSONRequestForClient(json request);

/*!
 Handles requests the ask to set the state
 */
json handleSetState(json request);


/*!
 Sets the value of a controller
 
 @param json data for changing a layer 
 @return json
 */
json setLayerControl(json data);

/*!
 Traverses the input data and sets those parameters, returning the final set value to the client
 
 @param json data for changing a state
 @return json
 */
json updateState(json data);

json updateLayers(json layerData);

#endif /* messages_hpp */
