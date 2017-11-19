//
//  PropertiesTest.cpp
//  Catch Tests
//
//  Created by Daniel Almeida on 21/10/2017.
//

#include <stdio.h>
#include "catch.hpp"
#include "Properties.h"


TEST_CASE("Getters return correct values after creation","[getters]") {
    Properties properties;
    
    REQUIRE(properties.getAlpha() == 1.0);
    REQUIRE(properties.getRed() == 0.0);
    REQUIRE(properties.getGreen() == 0.0);
    REQUIRE(properties.getBlue() == 0.0);
    REQUIRE(properties.getBrightness() == 1.0);
    REQUIRE(properties.getSaturation() == 1.0);
    REQUIRE(properties.getContrast() == 1.0);
}


TEST_CASE("Full state must be correct after properties object created","[getFullState]") {
    Properties properties;
    
    json fullState = properties.getFullState();
    
    // ALPHA
    REQUIRE(fullState["alpha"]["max"] == 1.0);
    REQUIRE(fullState["alpha"]["min"] == 0.0);
    REQUIRE(fullState["alpha"]["value"] == 1.0);
    
    // RED
    REQUIRE(fullState["red"]["max"] == 1.0);
    REQUIRE(fullState["red"]["min"] == -1.0);
    REQUIRE(fullState["red"]["value"] == 0.0);

    // GREEN
    REQUIRE(fullState["green"]["max"] == 1.0);
    REQUIRE(fullState["green"]["min"] == -1.0);
    REQUIRE(fullState["green"]["value"] == 0.0);
    
    // BLUE
    REQUIRE(fullState["blue"]["max"] == 1.0);
    REQUIRE(fullState["blue"]["min"] == -1.0);
    REQUIRE(fullState["blue"]["value"] == 0.0);

    // BRIGHTNESS
    REQUIRE(fullState["brightness"]["max"] == 2.0);
    REQUIRE(fullState["brightness"]["min"] == 0.0);
    REQUIRE(fullState["brightness"]["value"] == 1.0);

    // SATURATION
    REQUIRE(fullState["saturation"]["max"] == 2.0);
    REQUIRE(fullState["saturation"]["min"] == 0.0);
    REQUIRE(fullState["saturation"]["value"] == 1.0);

    // CONTRAST
    REQUIRE(fullState["contrast"]["max"] == 2.0);
    REQUIRE(fullState["contrast"]["min"] == 0.0);
    REQUIRE(fullState["contrast"]["value"] == 1.0);
}
