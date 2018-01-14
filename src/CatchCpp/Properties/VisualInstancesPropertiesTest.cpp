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
#include "Utils.h"


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

TEST_CASE("VisualInstancesProperties full state should be correct","[init]") {
    VisualInstancesProperties properties;
    json fullState = properties.getFullState();
    
    cout << fullState.dump(4) ;
    
    // Zoom X
    REQUIRE(fullState["zoomX"]["max"] == 8.0);
    REQUIRE(fullState["zoomX"]["min"] == 0.0);
    REQUIRE(fullState["zoomX"]["value"] == 1.0);
    REQUIRE(fullState["zoomX"]["type"] == StateType_Float);
    REQUIRE(fullState["zoomX"]["title"].get<std::string>().compare("Zoom X") == 0);

    // Zoom Y
    REQUIRE(fullState["zoomY"]["max"] == 8.0);
    REQUIRE(fullState["zoomY"]["min"] == 0.0);
    REQUIRE(fullState["zoomY"]["value"] == 1.0);
    REQUIRE(fullState["zoomY"]["type"] == StateType_Float);
    REQUIRE(fullState["zoomY"]["title"].get<std::string>().compare("Zoom Y") == 0);

    
    // CENTER X
    REQUIRE(fullState["centerX"]["max"] == 2.0);
    REQUIRE(fullState["centerX"]["min"] == -2.0);
    REQUIRE(fullState["centerX"]["value"] == 0.0);
    REQUIRE(fullState["centerX"]["type"] == StateType_Float);
    REQUIRE(fullState["centerX"]["title"].get<std::string>().compare("Center X") == 0);

    // CENTER Y
    REQUIRE(fullState["centerY"]["max"] == 2.0);
    REQUIRE(fullState["centerY"]["min"] == -2.0);
    REQUIRE(fullState["centerY"]["value"] == 0.0);
    REQUIRE(fullState["centerY"]["type"] == StateType_Float);
    REQUIRE(fullState["centerY"]["title"].get<std::string>().compare("Center Y") == 0);

    // START %
    REQUIRE(fullState["startPercentage"]["max"] == 1.0);
    REQUIRE(fullState["startPercentage"]["min"] == 0.0);
    REQUIRE(fullState["startPercentage"]["value"] == 0.0);
    REQUIRE(fullState["startPercentage"]["type"] == StateType_Float);
    REQUIRE(fullState["startPercentage"]["title"].get<std::string>().compare("Start") == 0);

    // END %
    REQUIRE(fullState["endPercentage"]["max"] == 1.0);
    REQUIRE(fullState["endPercentage"]["min"] == 0.0);
    REQUIRE(fullState["endPercentage"]["value"] == 1.0);
    REQUIRE(fullState["endPercentage"]["type"] == StateType_Float);
    REQUIRE(fullState["endPercentage"]["title"].get<std::string>().compare("End") == 0);

    // % PLAYED
    REQUIRE(fullState["percentagePlayed"]["max"] == 1.0);
    REQUIRE(fullState["percentagePlayed"]["min"] == 0.0);
    REQUIRE(fullState["percentagePlayed"]["value"] == 0.0);
    REQUIRE(fullState["percentagePlayed"]["type"] == StateType_Float);
    REQUIRE(fullState["percentagePlayed"]["title"].get<std::string>().compare("Percentage Played") == 0);

    // EFFECTS DRY WET
    REQUIRE(fullState["effects_drywet"]["max"] == 1.0);
    REQUIRE(fullState["effects_drywet"]["min"] == 0.0);
    REQUIRE(fullState["effects_drywet"]["value"] == 0.5);
    REQUIRE(fullState["effects_drywet"]["type"] == StateType_Float);
    REQUIRE(fullState["effects_drywet"]["title"].get<std::string>().compare("Dry/Wet") == 0);

    // LOOP MODE
    REQUIRE(fullState["loopMode"]["value"] == 1);
    REQUIRE(fullState["loopMode"]["type"] == StateType_ToggleButtonGroup);
    REQUIRE(fullState["loopMode"]["title"].get<std::string>().compare("Loop Mode") == 0);
    REQUIRE(fullState["loopMode"]["options"][0]["value"] == 1);
    REQUIRE(fullState["loopMode"]["options"][0]["title"].get<std::string>().compare("Normal") == 0);
    REQUIRE(fullState["loopMode"]["options"][1]["value"] == 2);
    REQUIRE(fullState["loopMode"]["options"][1]["title"].get<std::string>().compare("Ping Pong") == 0);
    REQUIRE(fullState["loopMode"]["options"][2]["value"] == 3);
    REQUIRE(fullState["loopMode"]["options"][2]["title"].get<std::string>().compare("Inverse") == 0);

    // DIRECTION
    REQUIRE(fullState["direction"]["value"] == 1);
    REQUIRE(fullState["direction"]["type"] == StateType_ToggleButtonGroup);
    REQUIRE(fullState["direction"]["title"].get<std::string>().compare("Direction") == 0);
    REQUIRE(fullState["direction"]["options"][0]["value"] == 1);
    REQUIRE(fullState["direction"]["options"][0]["title"].get<std::string>().compare("Left") == 0);
    REQUIRE(fullState["direction"]["options"][1]["value"] == 2);
    REQUIRE(fullState["direction"]["options"][1]["title"].get<std::string>().compare("Right") == 0);

    // TRIGGER MODE
    REQUIRE(fullState["triggerMode"]["value"] == 1);
    REQUIRE(fullState["triggerMode"]["type"] == StateType_ToggleButtonGroup);
    REQUIRE(fullState["triggerMode"]["title"].get<std::string>().compare("Trigger Mode") == 0);
    REQUIRE(fullState["triggerMode"]["options"][0]["value"] == 1);
    REQUIRE(fullState["triggerMode"]["options"][0]["title"].get<std::string>().compare("Mouse Down") == 0);
    REQUIRE(fullState["triggerMode"]["options"][1]["value"] == 2);
    REQUIRE(fullState["triggerMode"]["options"][1]["title"].get<std::string>().compare("Mouse Up") == 0);
    REQUIRE(fullState["triggerMode"]["options"][2]["value"] == 3);
    REQUIRE(fullState["triggerMode"]["options"][2]["title"].get<std::string>().compare("Piano") == 0);
}
