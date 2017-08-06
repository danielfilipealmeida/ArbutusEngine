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
    std::string path = ofFilePath::getCurrentExeDir() + "/Fixtures/FileHandling/test001.json";
    json result;
    
    REQUIRE_NOTHROW(result = JsonLoad::load(path));
    
    json expectedState = {
        {"layers", json::array()},
        {"scenes", json::array()},
        {"visuals", json::array()}
    };
     
    REQUIRE(result.dump().compare(expectedState.dump()) == 0);
    
    
}
                        
                        
TEST_CASE("Open a file and check the imported state is correct","[open]") {
    std::string path = ofFilePath::getCurrentExeDir() + "/Fixtures/FileHandling/test002.json";
    json result;
    
    REQUIRE_NOTHROW(result = JsonLoad::load(path));
    
    json expectedLayers = {
        {
            {"layer", "layer 1"},
            {"alpha", 1.0},
            {"brightness", 0.0},
            {"contrast", 0.0},
            {"saturation", 0.0},
            {"red", 1.0},
            {"green", 1.0},
            {"blue", 1.0},
            {"blurH", 1.0},
            {"blurV", 1.0}
        },
        {
            {"layer", "layer 2"},
            {"alpha", 1.0},
            {"brightness", 0.0},
            {"contrast", 0.0},
            {"saturation", 0.0},
            {"red", 1.0},
            {"green", 1.0},
            {"blue", 1.0},
            {"blurH", 1.0},
            {"blurV", 1.0}
        }
    };
    json expectedVisuals = {
        {
            {"type", 0},
            {"caption", "Visual 1"},
            {"filePath", "001.mov"}
        },
        {
            {"type", 0},
            {"caption", "Visual 2"},
            {"filePath", "002.mov"}
        },
        {
            {"type", 0},
            {"caption", "Visual 3"},
            {"filePath", "003.mov"}
        }
    };
    json expectedScenes = {
        {
        },
        {
        }
    };
    json expectedState = {
        {"layers", expectedLayers},
        {"scenes", expectedScenes},
        {"visuals", expectedVisuals}
    };

    std::cout << expectedState.dump()<< endl;
    std::cout << result.dump()<< endl;
    REQUIRE(result.dump().compare(expectedState.dump()) == 0);


}
