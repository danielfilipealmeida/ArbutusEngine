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
#include "Engine.h"

TEST_CASE("Checking initalized object state","[init]") {
    Engine *engine = new Engine();
    engine->setMixerResolution(640, 480);

    VisualInstancesProperties properties;
    

    json state = properties.getState();
    json expectedState = {
        {"width", 640},
        {"height", 480},
        {"zoomX", 1.0},
        {"zoomY", 1.0},
        {"centerX", 0.0},
        {"centerY", 0.0},
        {"x", 0.0},
        {"y", 0.0},
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

        {"red", 0.0},
        {"green", 0.0},
        {"blue", 0.0},
        {"alpha", 1.0}
    };
    
    for (json::iterator it = expectedState.begin(); it != expectedState.end(); ++it) {
        REQUIRE(state[it.key()] == it.value());
    }
    
    delete engine;
}
