//
//  layerProperties.cpp
//  ArbutusEngine
//
//  Created by Daniel Almeida on 10/03/17.
//
//

#include <stdio.h>
#include "catch.hpp"
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
