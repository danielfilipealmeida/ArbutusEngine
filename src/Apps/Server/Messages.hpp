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

json handleJSONRequestForClient(json request);


#endif /* messages_hpp */
