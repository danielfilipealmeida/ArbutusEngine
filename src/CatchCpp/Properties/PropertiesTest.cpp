//
//  PropertiesTest.cpp
//  Catch Tests
//
//  Created by Daniel Almeida on 21/10/2017.
//

#include <stdio.h>
#include "catch.hpp"
#include "Properties.h"
#include "Utils.h"


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
    
    // NAME
    REQUIRE(fullState["name"]["type"] == StateType_String);
    REQUIRE(fullState["name"]["title"].get<string>().compare("Name") == 0);

    // ALPHA
    REQUIRE(fullState["alpha"]["max"] == 1.0);
    REQUIRE(fullState["alpha"]["min"] == 0.0);
    REQUIRE(fullState["alpha"]["value"] == 1.0);
    REQUIRE(fullState["alpha"]["type"] == StateType_Float);
    REQUIRE(fullState["alpha"]["title"].get<string>().compare("Alpha") == 0);

    // RED
    REQUIRE(fullState["red"]["max"] == 1.0);
    REQUIRE(fullState["red"]["min"] == -1.0);
    REQUIRE(fullState["red"]["value"] == 0.0);
    REQUIRE(fullState["red"]["type"] == StateType_Float);
    REQUIRE(fullState["red"]["title"].get<string>().compare("Red") == 0);

    // GREEN
    REQUIRE(fullState["green"]["max"] == 1.0);
    REQUIRE(fullState["green"]["min"] == -1.0);
    REQUIRE(fullState["green"]["value"] == 0.0);
    REQUIRE(fullState["green"]["type"] == StateType_Float);
    REQUIRE(fullState["green"]["title"].get<string>().compare("Green") == 0);

    // BLUE
    REQUIRE(fullState["blue"]["max"] == 1.0);
    REQUIRE(fullState["blue"]["min"] == -1.0);
    REQUIRE(fullState["blue"]["value"] == 0.0);
    REQUIRE(fullState["blue"]["type"] == StateType_Float);
    REQUIRE(fullState["blue"]["title"].get<string>().compare("Blue") == 0);

    // BRIGHTNESS
    REQUIRE(fullState["brightness"]["max"] == 2.0);
    REQUIRE(fullState["brightness"]["min"] == 0.0);
    REQUIRE(fullState["brightness"]["value"] == 1.0);
    REQUIRE(fullState["brightness"]["type"] == StateType_Float);
    REQUIRE(fullState["brightness"]["title"].get<string>().compare("Brightness") == 0);

    
    // SATURATION
    REQUIRE(fullState["saturation"]["max"] == 2.0);
    REQUIRE(fullState["saturation"]["min"] == 0.0);
    REQUIRE(fullState["saturation"]["value"] == 1.0);
    REQUIRE(fullState["saturation"]["type"] == StateType_Float);
    REQUIRE(fullState["saturation"]["title"].get<string>().compare("Saturation") == 0);

    // CONTRAST
    REQUIRE(fullState["contrast"]["max"] == 2.0);
    REQUIRE(fullState["contrast"]["min"] == 0.0);
    REQUIRE(fullState["contrast"]["value"] == 1.0);
    REQUIRE(fullState["contrast"]["type"] == StateType_Float);
    REQUIRE(fullState["contrast"]["title"].get<string>().compare("Contrast") == 0);

}
