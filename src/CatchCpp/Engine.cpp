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
    
    //cout << state.dump();
    
    REQUIRE(state["layer"].is_null());
    //REQUIRE(state["scenes"].is_null());
    //REQUIRE(state["visuals"].is_null());
};

TEST_CASE("State with Layers", "[getState]") {
    Engine *engine;
    json state;
    Layer *layer;
    Scene *scene;
    VisualVideo *visual;
    
    engine = new Engine();
    layer = engine->addLayer(false);
    //scene = engine->addScene();
    scene = new Scene("my scene", 1);
    visual = new VisualVideo("loop001.mov");
    cout << visual->getState().dump();
    engine->getCurrentSet()->addVisualToList(visual);
    scene->addVisualToInstanceList(visual, 1, 1);
    engine->getCurrentSet()->addSceneToList(scene);
    
    
    
    state = engine->getState();
    REQUIRE(state["layers"].is_null() == false);
    REQUIRE(state["layers"].size() == 1);
    testNewLayer(state["layers"][0]);

    cout << state.dump() <<endl;
    REQUIRE(state["scenes"].is_null() == false);
    REQUIRE(state["scenes"].is_array() == true);
    
    //REQUIRE(state["visuals"].is_null() == false);
    

}
