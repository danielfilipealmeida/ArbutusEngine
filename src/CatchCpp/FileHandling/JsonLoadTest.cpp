//
//  JsonOpenTest.cpp
//  ArbutusEngine
//
//  Created by Daniel Almeida on 29/07/17.
//
//

#include <stdio.h>
#include "catch.hpp"
#include "JsonLoad.hpp"
#include "ofMain.h"

TEST_CASE("Invalid file path throws","[open]") {
    std::string path = ofFilePath::getCurrentExeDir() + "/some_bad_folder/myset.json";
    
    REQUIRE_THROWS_WITH(JsonLoad::load(path), "File does not exist");
}

TEST_CASE("File path does not throws","[open]") {
    std::string path = ofFilePath::getCurrentExeDir() + "/test001.json";
    json result;
    
    REQUIRE_NOTHROW(result = JsonLoad::load(path));
    
    json expectedState = {
        {"layers", {}},
        {"scenes", {}},
        {"visuals", {}}
    };
    REQUIRE(result.dump().compare(expectedState.dump()) == 0);
    
    
}
                        
                        

