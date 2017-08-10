//
//  engine.cpp
//  ArbutusEngine
//
//  Created by Daniel Almeida on 10/03/17.
//
//

#include <stdio.h>
#include "catch.hpp"
#include "Engine.h"

extern void testNewLayer(json layer);

TEST_CASE("Empty Sets State","[getState]") {
    Engine *engine;
    json state;
    
    engine = new Engine();
    state = engine->getState();
    
    
    REQUIRE(state["layer"].is_null());
    //REQUIRE(state["scenes"].is_null());
    //REQUIRE(state["visuals"].is_null());
};



 // this test needs to be remade
TEST_CASE("State with Layers", "[getState]") {
    Engine *engine;
    json state;
    Layer *layer;
    Scene *scene;
    VisualVideo *visual;
    
    engine = new Engine();
    layer = Layers::getInstance().add(false);
    scene = new Scene("my scene", 1);
    visual = new VisualVideo("loop001.mov");
    Set::getInstance().addVisualToList(visual);
    scene->addVisualToInstanceList(visual, 1, 1);
    
    Set::getInstance().addSceneToList(scene);
    
    state = engine->getState();
    REQUIRE(state["layers"].is_null() == false);
    REQUIRE(state["layers"].size() == 1);
    testNewLayer(state["layers"][0]);

    cout << state.dump() <<endl;
    REQUIRE(state["scenes"].is_null() == false);
    REQUIRE(state["scenes"].is_array() == true);
    REQUIRE(state["visuals"].is_null() == false);
    
    // test the visual
    REQUIRE(state["visuals"].is_array() == true);
    REQUIRE(state["visuals"][0]["caption"] == "loop001.mov");
    REQUIRE(state["visuals"][0]["filePath"] == "../../../data/loop001.mov");
    REQUIRE((int) state["visuals"][0]["type"] == 0);
}

