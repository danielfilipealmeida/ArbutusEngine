//
//  SizeProperties.cpp
//  Catch Tests
//
//  Created by Daniel Almeida on 13/01/2018.
//

#include <stdio.h>
#include "catch.hpp"
#include "SizeProperties.h"
#include "Utils.h"
#include "ofJson.h"


TEST_CASE("Can get well defined size properties state","[getFullState]") {
    SizeProperties sizeProperties;
    ofJson fullState = sizeProperties.getFullState({});
    
    // WIDTH
    REQUIRE(fullState["width"]["max"] == 1920);
    REQUIRE(fullState["width"]["min"] == 0);
    REQUIRE(fullState["width"]["value"] == 1920);
    REQUIRE(fullState["width"]["type"] == StateType_Integer);
    REQUIRE(fullState["width"]["title"].get<std::string>().compare("Width") == 0);
    
    // HEIGHT
    REQUIRE(fullState["height"]["max"] == 1080);
    REQUIRE(fullState["height"]["min"] == 0);
    REQUIRE(fullState["height"]["value"] == 1080);
    REQUIRE(fullState["height"]["type"] == StateType_Integer);
    REQUIRE(fullState["height"]["title"].get<std::string>().compare("Height") == 0);
}
