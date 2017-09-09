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
#include "JsonLoad.hpp"


extern void testNewLayer(json layer);

TEST_CASE("Empty Sets State","[getState]") {
    Engine *engine;
    json state;
    
    engine = new Engine();
    state = engine->getState();
    
    
    REQUIRE(state["layer"].is_null());
    //REQUIRE(state["scenes"].is_null());
    //REQUIRE(state["visuals"].is_null());
    
    delete engine;
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
    layer->getProperties()->setName("Layer 1");
    scene = new Scene("my scene");
    visual = new VisualVideo("loop001.mov");
    Visuals::getInstance().add((Visual *)visual);
    scene->visualInstances.add(visual, 1, 1);
    
    Set::getInstance().addScene(scene);
    
    state = engine->getState();
    REQUIRE(state["layers"].is_null() == false);
    REQUIRE(state["layers"].size() == 1);
    testNewLayer(state["layers"][0]);

    REQUIRE(state["scenes"].is_null() == false);
    REQUIRE(state["scenes"].is_array() == true);
    REQUIRE(state["visuals"].is_null() == false);
    
    // test the visual
    REQUIRE(state["visuals"].is_array() == true);
    REQUIRE(state["visuals"][0]["caption"] == "loop001.mov");
    REQUIRE(state["visuals"][0]["filePath"] == "loop001.mov");
    REQUIRE((int) state["visuals"][0]["type"] == 0);
    
    delete engine;
}


Engine *createTestSet() {
    Engine *engine;
    Layer *layer1, *layer2;
    Scene *scene;
    VisualVideo *video1, *video2;
    
    engine = new Engine();
    
    layer1 = Layers::getInstance().add(false);
    layer2 = Layers::getInstance().add(false);
    scene = new Scene("First Scene");
    //Set::getInstance().addScene(scene);
    
    layer1->getProperties()->setName("Layer 1");
    layer2->getProperties()->setName("Layer 2");
    
    video1 = new VisualVideo("Fixtures/FileHandling/001.mov");
    Visuals::getInstance().add((Visual *) video1);
    scene->visualInstances.add(video1, 0, 0);
    
    video2 = new VisualVideo("Fixtures/FileHandling/002.mov");
    Visuals::getInstance().add((Visual *) video2);
    scene->visualInstances.add(video2, 1, 0);
    
    Set::getInstance().addScene(scene);

    Set::getInstance().setCurrentScene(0);
    
    // todo: tenho de definir a current scene
    return engine;
}

/*
 Creates a new set with:
 - one set
 - two layers
 - two visuals, one on each layer
 
 saves and open the saved file. compares the state of the engine and the one loaded from the file
 */

TEST_CASE("Engine can create and save a set properly", "[!hide]") {
    Engine *engine = createTestSet();
    
    json currentState = engine->getState();
    REQUIRE(currentState.is_object());
    REQUIRE(currentState["layers"].is_array());
    REQUIRE(currentState["scenes"].is_array());
    REQUIRE(currentState["visuals"].is_array());
    REQUIRE(currentState["layers"].size() == 2);
    REQUIRE(currentState["scenes"].size() == 1);
    REQUIRE(currentState["visuals"].size() == 2);
    REQUIRE(currentState["scenes"].at(0)["instances"].size() == 2);
    REQUIRE(currentState["layers"].at(0)["name"].get<string>().compare("Layer 1") == 0);
    
    std::string path = ofFilePath::getCurrentExeDir() + "/engine-test.json";
    engine->saveSetAs(path);
    json loadedState = JsonLoad::load(path);
    
    // Test loaded json
    REQUIRE(loadedState.dump(4).compare(engine->getState().dump(4)) == 0);
    
    
    // test opening the the file
    engine->openSet(path);
    
    
    delete engine;
}

TEST_CASE("Engine plays videos set with json data", "[play]") {
    Engine *engine = createTestSet();
    
    
    REQUIRE_THROWS(engine->play({}));
    REQUIRE_THROWS(engine->play({{"column", 0}}));
    REQUIRE_THROWS(engine->play({{"layer", 0}}));
    REQUIRE_THROWS(engine->play({{"column", 1}, {"layer", 1}}));
    REQUIRE_NOTHROW(engine->play({{"column", 0}, {"layer", 0}}));
    
     delete engine;
}
