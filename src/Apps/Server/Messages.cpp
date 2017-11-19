//
//  messages.cpp
//  ArbutusEngine
//
//  Created by Daniel Almeida on 19/11/2017.
//

#include "Messages.hpp"
#include "Engine.h"
#include "Utils.h"

json handleJSONRequestForClient(json request) {
    json response = {
        {"success", true},
        {"message", ""},
        {"data", {}}
    };
    if (!request["action"].is_string()) throw std::runtime_error ("No action defined");
    
    switch (str2int(request["action"].get<string>().c_str())) {
        case str2int("ping"):
            response["message"] = "pong";
            break;
            
        case str2int("getState"):
            response["data"] = Engine::getInstance()->getState();
            break;
            
        default:
            throw new std::runtime_error("Action not supported");
            break;
    }
    return response;
}
