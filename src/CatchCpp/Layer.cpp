//
//  Layer.cpp
//  ArbutusEngine
//
//  Created by Daniel Almeida on 10/03/17.
//
//

#include <stdio.h>
#include "catch.hpp"
#include "Layer.h"
#include "json.hpp"

using json = nlohmann::json;



void testNewLayer(json layer) {
    REQUIRE(layer["alpha"].get<float>() == 1.0);
    REQUIRE(layer["brightness"].get<float>() == 1.0);
    REQUIRE(layer["contrast"].get<float>() == 1.0);
    REQUIRE(layer["saturation"].get<float>() == 1.0);
    REQUIRE(layer["red"].get<float>() == 0.0);
    REQUIRE(layer["green"].get<float>() == 0.0);
    REQUIRE(layer["blue"].get<float>() == 0.0);
    REQUIRE(layer["blurH"].get<float>() == 0.0);
    REQUIRE(layer["blurV"].get<float>() == 0.0);
    
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
        
        REQUIRE(layer->label().compare(element["expectedResult"].get<std::string>()) == 0);
        
        delete layer;
    }
}

TEST_CASE("State should be properly set", "[getState]") {
    Layer *layer;
    
    layer = new Layer(false);
    
    json state = json::object({
        {"name", "a layer"},
        {"alpha", (float) 0.5f},
        {"blendMode", 1},
        {"red", 0.5f},
        {"green", (double) 0.6f},
        {"blue", 0.7f},
        {"blurH", 1},
        {"blurV", 2},
        {"brightness", 0.4f},
        {"saturation", 0.2f},
        {"contrast", 0.20f},
        {"width", 320},
        {"height", 240},
    });
    
    layer->setState(state);
    REQUIRE(json::diff(layer->getState(), state) == "[]"_json);
}
