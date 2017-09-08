//
//  Set.cpp
//  ArbutusEngine
//
//  Created by Daniel Almeida on 29/08/17.
//
//

#include <stdio.h>
#include "catch.hpp"
#include "Scene.h"
#include "Visuals.h"


TEST_CASE("Setting invalid state of scene should throw", "[Scene::setState]") {
    json state;
    
    Scene *scene = new Scene("test scene");
    
    REQUIRE_THROWS_WITH(scene->setState({}), "State isn't an object");
    REQUIRE_THROWS_WITH(scene->setState({1}), "State isn't an object");
    REQUIRE_THROWS_WITH(scene->setState({"a"}), "State isn't an object");
    REQUIRE_THROWS_WITH(scene->setState(json::array({{1},{2}})), "State isn't an object");

    state = {
        {"name", "a new scene name"}
    };
    scene->setState(state);
    json currentState = scene->getState();
    REQUIRE(currentState["name"].get<string>().compare(state["name"]) == 0);


    state = {
        {"name", "a new scene name"},
        {"instances", json::array({
            {
                
                {"index", 0},
                {"properties", {
                    {"x", 10},
                    {"y", 10},
                    {"width", 320},
                    {"height", 240},
                    {"centerX", 0.1},
                    {"centerY", -0.1},
                    {"zoomX", 2},
                    {"zoomY", 3},
                    {"red", 0.4},
                    {"green", 0.4},
                    {"blue", 0.4},
                    {"brightness", 0.4},
                    {"contrast", 0.4},
                    {"saturation", 0.4},
                    {"alpha", 0.4},
                    {"column", 0},
                    {"layer", 0},
                    {"isPlaying", 1},
                    {"isTriggered", 1},
                    {"beatSnap", 1},
                    {"direction", 1},
                    {"effects_drywet", 0.2},
                    {"startPercentage", 0.2},
                    {"endPercentage", 0.8},
                    {"percentagePlayed", 0.4},
                    {"retrigger", 0},
                    {"triggerMode", 0}
               }
                }
            }
            })
        }
    };
    Visuals::getInstance().empty();
    Visuals::getInstance().addVideo("loop001.mov");
    scene->setState(state);
    currentState = scene->getState();
    REQUIRE(currentState["instances"].size() == 1);
    REQUIRE(currentState["instances"].at(0)["visual"].is_object());
    //REQUIRE(currentState["instances"].at(0)["visual"]["caption"].get<string>().compare("loop001.mov"));
    
}


TEST_CASE("Scene should have it's state set", "") {
    json state;
    
}

TEST_CASE("Scenes should have their state set", "") {
    json state;
    
}
