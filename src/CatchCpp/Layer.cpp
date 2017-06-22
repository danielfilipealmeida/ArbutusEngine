//
//  Layer.cpp
//  ArbutusEngine
//
//  Created by Daniel Almeida on 10/03/17.
//
//

#include <stdio.h>


#include <stdio.h>
#include "catch.hpp"
#include "Layer.h"
#include "json.hpp"

using json = nlohmann::json;



void testNewLayer(json layer) {
    //cout << layer.dump();
    REQUIRE(layer["Alpha"].get<float>() == 1.0);
    REQUIRE(layer["Brightness"].get<float>() == 1.0);
    REQUIRE(layer["Contrast"].get<float>() == 1.0);
    REQUIRE(layer["Saturation"].get<float>() == 1.0);
    REQUIRE(layer["Red"].get<float>() == 1.0);
    REQUIRE(layer["Green"].get<float>() == 1.0);
    REQUIRE(layer["Blue"].get<float>() == 1.0);
    REQUIRE(layer["BlurH"].get<float>() == 0.0);
    REQUIRE(layer["BlurV"].get<float>() == 0.0);
    
}


TEST_CASE("New layer should have expected data", "[constructor]") {
    Layer *layer;
    
    layer = new Layer(false);
    testNewLayer(layer->getState());
}


TEST_CASE("Layer label should be properly created", "[label]") {
    Layer           *layer = nullptr;
    LayerProperties *properties;
    json            testData;

    testData = json::array({
        {
            {"blendMode",       BLEND_ALPHA},
            {"layerNumber",     0},
            {"alpha",           1.0},
            {"expectedResult",  "Layer 1|ALPHA|100%"}
        },
        {
            {"blendMode",       BLEND_MULTIPLY},
            {"layerNumber",     1},
            {"alpha",           0.5},
            {"expectedResult",  "Layer 2|MULT|50%"}
        },
        {
            {"blendMode",       BLEND_ADD},
            {"layerNumber",     2},
            {"alpha",           0.2},
            {"expectedResult",  "Layer 3|ADD|20%"}
        },
        {
            {"blendMode",       BLEND_SUBTRACT},
            {"layerNumber",     2},
            {"alpha",           0.0},
            {"expectedResult",  "Layer 3|SUBT|0%"}
        },
        {
            {"blendMode",       BLEND_SCREEN},
            {"layerNumber",     0},
            {"alpha",           0.9},
            {"expectedResult",  "Layer 1|SCRN|90%"}
        }
    });
    
    for (auto& element : testData) {
        layer = new Layer(false);
        layer->setLayerNumber(element["layerNumber"]);
        properties = layer->getProperties();
        properties->setBlendMode((BlendMode) element["blendMode"].get<int>());
        properties->setAlpha(element["alpha"]);
        
        std::cout <<layer->label()<<" -- "<<element["expectedResult"].get<std::string>()<<std::endl;
        
        
        REQUIRE(layer->label().compare(element["expectedResult"].get<std::string>()) == 0);
        
        delete layer;
    }
    
   // std::cout << layer->label() << std::endl;
}
