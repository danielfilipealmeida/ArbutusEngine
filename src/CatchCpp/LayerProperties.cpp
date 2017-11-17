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
    Engine *engine = new Engine();
    LayerProperties properties;
    
    json fullState = properties.getFullState();
    
    REQUIRE(fullState["alpha"]["value"] == 1.0);
    REQUIRE(fullState["alpha"]["min"] == 0.0);
    REQUIRE(fullState["alpha"]["max"] == 1.0);

    REQUIRE(fullState["width"]["value"] == 640.0);
    REQUIRE(fullState["width"]["min"] == 0.0);
    REQUIRE(fullState["width"]["max"] == 1920.0);

    REQUIRE(fullState["height"]["value"] == 480.0);
    REQUIRE(fullState["height"]["min"] == 0.0);
    REQUIRE(fullState["height"]["max"] == 1080.0);

    delete engine;
    cout << fullState.dump(4) << endl;
}
