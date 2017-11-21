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


TEST_CASE("Ping action respondes Pong message", "[handleJSONRequestForClient]") {
    json message = {
        {"action", "ping"}
    };
    
    json response = handleJSONRequestForClient(message);
    
    REQUIRE(response["message"].get<string>().compare("pong") == 0);
    REQUIRE(response["success"].get<Boolean>() == true);
}

TEST_CASE("getState action returns data with engine state", "[handleJSONRequestForClient]") {
    json message = {
        {"action", "getState"}
    };
    
    Engine *engine = new Engine();
    
    json response = handleJSONRequestForClient(message);
    json engineState = Engine::getInstance()->getState();
    
    REQUIRE(json::diff(response["data"], engineState) == "[]"_json);
    
    delete engine;
}

TEST_CASE("setState requires properly set data", "[handleJSONRequestForClient]") {
    json message = {
        {"action", "setState"}
    };
    
    Engine *engine = new Engine();
    
    REQUIRE_THROWS(handleJSONRequestForClient(message));
    
    
    delete engine;
}


TEST_CASE("setState action makes changes to the engine state", "[handleJSONRequestForClient]") {
    json state = {
        {"layers",json::array()}
    };
    state["layers"][0] = {{"alpha", 0.3f}};
    state["layers"][1] = {{"alpha", 0.5f}};
    
     json message = {
        {"action", "setState"},
        {"data", state}
    };
    
    Engine *engine = new Engine();
    engine->openSet("Fixtures/FileHandling/test002.json");
    
    handleJSONRequestForClient(message);
    json newState = engine->getState();
   
    REQUIRE(newState["layers"][0]["alpha"] == state["layers"][0]["alpha"] );
    REQUIRE(newState["layers"][1]["alpha"] == state["layers"][1]["alpha"] );
    
    delete engine;
}
