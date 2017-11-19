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
