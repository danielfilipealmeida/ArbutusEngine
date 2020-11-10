//
//  messages.cpp
//  Catch Tests
//
//  Created by Daniel Almeida on 19/11/2017.
//

#include <stdio.h>
#include "catch.hpp"
#include "Engine.h"
#include "JsonLoad.hpp"
#include "Messages.hpp"
#include "ofJson.h"


TEST_CASE("Ping action respondes Pong message", "[handleJSONRequestForClient]") {
    ofJson message = {
        {"action", "ping"}
    };
    
    ofJson response = handleJSONRequestForClient(message);
    
    REQUIRE(response["message"].get<string>().compare("pong") == 0);
    REQUIRE(response["success"].get<Boolean>() == true);
}

TEST_CASE("getState action returns data with engine state", "[handleJSONRequestForClient]") {
    ofJson message = {
        {"action", "getState"}
    };
    
    Engine *engine = new Engine();
    
    ofJson response = handleJSONRequestForClient(message);
    ofJson engineState = Engine::getInstance()->getState();
    
    REQUIRE(ofJson::diff(response["data"], engineState) == "[]"_json);
    
    delete engine;
}

TEST_CASE("setState requires properly set data", "[handleJSONRequestForClient]") {
    ofJson message = {
        {"action", "setState"}
    };
    
    Engine *engine = new Engine();
    
    REQUIRE_THROWS(handleJSONRequestForClient(message));
    
    
    delete engine;
}


TEST_CASE("setState action makes changes to the engine state", "[handleJSONRequestForClient]") {
    ofJson state = {
        {"layers",ofJson::array()}
    };
    state["layers"][0] = {{"alpha", 0.3f}};
    state["layers"][1] = {{"alpha", 0.5f}};
    
     ofJson message = {
        {"action", "setState"},
        {"data", state}
    };
    
    Engine *engine = new Engine();
    engine->openSet("Fixtures/FileHandling/test002.ofJson");
    
    handleJSONRequestForClient(message);
    ofJson newState = engine->getState();
   
    REQUIRE(newState["layers"][0]["alpha"] == state["layers"][0]["alpha"] );
    REQUIRE(newState["layers"][1]["alpha"] == state["layers"][1]["alpha"] );
    
    delete engine;
}
