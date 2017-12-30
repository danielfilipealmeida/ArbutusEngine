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
            
        case str2int("setState"):   
            response["data"] = handleSetState(request);
            break;
            
        case str2int("getFullState"):
            response["data"] = Engine::getInstance()->getFullState();
            break;
            
        case str2int("setLayerControl"):
            return setLayerControl(request["data"]);
            break;
            
        case str2int("updateState"):
            response["data"] = updateState(request["data"]);
            break;
                
            
            
        default:
            throw new std::runtime_error("Action not supported");
            break;
    }
    return response;
}

json handleSetState(json request) {
    json result;
    
    if (!request["data"].is_object()) throw std::runtime_error("No data sent for state change.");

   Engine::getInstance()->setState(request["data"]);
        
    return result;
}

json setLayerControl(json data) {
    json result;
    string controlName = data["name"].get<string>();
    float value = ofToFloat(data["value"].get<string>());
    
    json newLayerControlState = {
        {controlName, value}
    };
    
    Layer *layer = Layers::getInstance().get(data["layer"].get<int>());
    
    layer->setState(newLayerControlState);
    json newState = layer->getState();
    
    result = {
        {"result", value == newState["alpha"].get<float>()}
    };
    
    return result;
}

json updateState(json data) {
    json result;
    
    result["layers"] = updateLayers(data["layers"]);
    result = {
        {"result", true}
    };
    return result;
}

json updateLayers(json layerData) {
    json result;
    
    unsigned int currentLayerIndex = 0;
    for(auto layer:layerData) {
        json layerResult;
        
        Layer *currentLayer = Layers::getInstance().get(currentLayerIndex);
        currentLayer->setState(layer);
        
        result.push_back(layerResult);
        currentLayerIndex++;
    }
    
    return result;
    
}
