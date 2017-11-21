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
 Hanldes requests the ask to set the state
 */
json handleSetState(json request);


#endif /* messages_hpp */
