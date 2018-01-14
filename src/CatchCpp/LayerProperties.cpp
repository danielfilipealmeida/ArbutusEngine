//
//  layerProperties.cpp
//  ArbutusEngine
//
//  Created by Daniel Almeida on 10/03/17.
//
//

#include <stdio.h>
#include "catch.hpp"
#include "Engine.h"
#include "LayerProperties.h"
#include "Utils.h"



TEST_CASE("Blend mode strings are correctly generated", "[blendModeToString]") {
    std::map<BlendMode, string> testData;
    
    testData[BLEND_ALPHA] = "ALPHA";
    testData[BLEND_ADD] = "ADD";
    testData[BLEND_MULTIPLY] = "MULT";
    testData[BLEND_SUBTRACT] = "SUBT";
    testData[BLEND_SCREEN] = "SCRN";
    
    for(
        auto it = testData.begin();
        it != testData.end();
        it++
    ) {
        string blendMode;
        
        blendMode = LayerProperties::blendModeToString((BlendMode) it->first);
        REQUIRE(blendMode.compare(it->second) == 0);
    }
    
}

TEST_CASE("Full state is correct", "[getFullState]") {
    LayerProperties properties;
    
    json fullState = properties.getFullState();
    
    std::cout << fullState.dump(4) << std::endl;
    
    // BLURH
    REQUIRE(fullState["blurH"]["value"] == 0.0);
    REQUIRE(fullState["blurH"]["min"] == 0.0);
    REQUIRE(fullState["blurH"]["max"] == 10.0);
    REQUIRE(fullState["blurH"]["defaultValue"] == 0.0);
    REQUIRE(fullState["blurH"]["type"] == StateType_Float);
    REQUIRE(fullState["blurH"]["title"].get<std::string>().compare("Horizontal Blur") == 0);

    // BLURV
    REQUIRE(fullState["blurV"]["value"] == 0.0);
    REQUIRE(fullState["blurV"]["min"] == 0.0);
    REQUIRE(fullState["blurV"]["max"] == 10.0);
    REQUIRE(fullState["blurV"]["defaultValue"] == 0.0);
    REQUIRE(fullState["blurV"]["type"] == StateType_Float);
    REQUIRE(fullState["blurV"]["title"].get<std::string>().compare("Vertical Blur") == 0);
    
    // BLEND MODE
    REQUIRE(fullState["blendMode"]["value"] == 2);
    REQUIRE(fullState["blendMode"]["min"] == 1);
    REQUIRE(fullState["blendMode"]["max"] == 5);
    REQUIRE(fullState["blendMode"]["defaultValue"] == 1);
    REQUIRE(fullState["blendMode"]["type"] == StateType_Integer);
    REQUIRE(fullState["blendMode"]["title"].get<std::string>().compare("Blend Mode") == 0);
}
