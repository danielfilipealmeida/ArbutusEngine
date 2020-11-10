//
//  messages.cpp
//  ArbutusEngine
//
//  Created by Daniel Almeida on 19/11/2017.
//

#include "Messages.hpp"
#include "Engine.h"
#include "Utils.h"
#include "ofJson.h"

ofJson handleJSONRequestForClient(ofJson request) {
    ofJson response = {
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

ofJson handleSetState(ofJson request) {
    ofJson result;
    
    if (!request["data"].is_object()) throw std::runtime_error("No data sent for state change.");

   Engine::getInstance()->setState(request["data"]);
        
    return result;
}

ofJson setLayerControl(ofJson data) {
    ofJson result;
    string controlName = data["name"].get<string>();
    float value = ofToFloat(data["value"].get<string>());
    
    ofJson newLayerControlState = {
        {controlName, value}
    };
    
    Layer *layer = Layers::getInstance().get(data["layer"].get<int>());
    
    layer->setState(newLayerControlState);
    ofJson newState = layer->getState();
    
    result = {
        {"result", value == newState["alpha"].get<float>()}
    };
    
    return result;
}

ofJson updateState(ofJson data) {
    ofJson result;
    
    result["layers"] = updateLayers(data["layers"]);
    result = {
        {"result", true}
    };
    return result;
}

ofJson updateLayers(ofJson layerData) {
    ofJson result;
    
    unsigned int currentLayerIndex = 0;
    for(auto layer:layerData) {
        ofJson layerResult;
        
        Layer *currentLayer = Layers::getInstance().get(currentLayerIndex);
        currentLayer->setState(layer);
        
        result.push_back(layerResult);
        currentLayerIndex++;
    }
    
    return result;
    
}
