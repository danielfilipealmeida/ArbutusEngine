//
//  JsonSaveTest.cpp
//  ArbutusEngine
//
//  Created by Daniel Almeida on 27/07/17.
//
//

#include <stdio.h>
#include "catch.hpp"
#include "JsonSave.hpp"
#include "ofMain.h"
#include "Engine.h"

TEST_CASE("Empty state throws","[save]") {
    std::string path = "myset.json";
    json state = {};
    
    REQUIRE_THROWS_WITH(JsonSave::save(path, state), "State is empty");
}

TEST_CASE("Invalid path to file throws","[save]") {
     std::string path = ofFilePath::getCurrentExeDir() + "/some_bad_folder/myset.json";
    
    json state = {
        {"layers", {}},
        {"scenes", {}},
        {"visuals", {}}
    };
    
    std::cout << path << std::endl;
    REQUIRE_THROWS_WITH(JsonSave::save(path, state), "Path to file doesn't exist");
}

TEST_CASE("throws if state isn't an object","[save]") {
    std::string path = ofFilePath::getCurrentExeDir() + "/myset.json";
    
    json state = {1};
    REQUIRE_THROWS_WITH(JsonSave::save(path, state), "State is not an object");
   
    state = {1,2,3,4};
    REQUIRE_THROWS_WITH(JsonSave::save(path, state), "State is not an object");
    
    state = {"some string"};
    REQUIRE_THROWS_WITH(JsonSave::save(path, state), "State is not an object");
    
    state = {false};
    REQUIRE_THROWS_WITH(JsonSave::save(path, state), "State is not an object");
}


TEST_CASE("valid state and path should save","[save]") {
    std::string path = ofFilePath::getCurrentExeDir() + "/mytestset.json";
    json state = {
        {"layers", {}},
        {"scenes", {}},
        {"visuals", {}}
    };
    
    REQUIRE_NOTHROW(JsonSave::save(path, state));
    
    ofBuffer buffer = ofBufferFromFile(path);
    
    REQUIRE(buffer.getText().compare(state.dump()) == 0);
}


TEST_CASE("Set should save", "[save]") {
    std::string path = ofFilePath::getCurrentExeDir() + "/test_save_001.json";
    
    Engine *engine;
    Layer *layer1, *layer2;
    Scene *scene1, *scene2;
   
    engine = new Engine();
    
    layer1 = Layers::getInstance().add(false);
    layer2 = Layers::getInstance().add(false);
    Scenes::getInstance().newScene("Scene 1");
    Scenes::getInstance().newScene("scene 2");
    
    JsonSave::save(path, Engine::getInstance()->getState());
    
    delete engine;
    
    
}
