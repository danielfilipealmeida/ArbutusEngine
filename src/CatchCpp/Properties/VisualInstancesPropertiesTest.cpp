//
//  VisualInstancesPropertiesTest.cpp
//  ArbutusEngine
//
//  Created by Daniel Almeida on 07/08/17.
//
//

#include <stdio.h>
#include "catch.hpp"
#include "VisualInstancesProperties.h"
#include "ofMain.h"

TEST_CASE("Checking initalized object state","[init]") {
    VisualInstancesProperties properties;
    
    json state = properties.getState();
    json expectedState = {
        {"width", 640},
        {"height", 480},
        {"zoomX", 1},
        {"zoomY", 1},
        {"centerX", 0.0},
        {"centerY", 0.0},
        {"x", 0},
        {"y", 0},
        {"layer", 0},
        {"column", 0},
 
        {"retrigger", 1},
        {"isPlaying", 0},
        {"percentagePlayed", 0.0},
        {"startPercentage", 0.0},
        {"endPercentage", 1.0},
        {"effects_drywet", 0.5},
        {"loopMode", 1},
        {"direction", 1},
        {"beatSnap", 0},
        {"isTriggered", 0},
        {"triggerMode", TriggerMode_MouseDown},

        {"red", 1},
        {"green", 1},
        {"blue", 1},
        {"alpha", 1}
    };
    
    // TODO: change this and traverse the expected json and test each single
    for (json::iterator it = expectedState.begin();
        it != expectedState.end();
        ++it)
    {
        //std::cout << it.key() << " - " << it.value() << std::endl;
        //std::cout << ofToString(state[it.key()]) << std::endl;
        string currentStateValue = ofToString(state[it.key()]);
        string currentExpectedValue = ofToString(it.value());
        //std::cout << it.key() << " - " << currentStateValue << " - "  << currentExpectedValue << std::endl;
        REQUIRE(currentExpectedValue.compare(currentStateValue) == 0);
    }
    //REQUIRE(result.dump().compare(expectedState.dump()) == 0);
    //std::cout << state.dump(4) <<std::endl;
}
