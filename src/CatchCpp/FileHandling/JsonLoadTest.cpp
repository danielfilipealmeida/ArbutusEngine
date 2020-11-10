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
#include "ofJson.h"

TEST_CASE("Invalid file path throws","[open]") {
    std::string path = ofFilePath::getCurrentExeDir() + "/some_bad_folder/myset.ofJson";
    
    REQUIRE_THROWS_WITH(JsonLoad::load(path), "File does not exist");
}

TEST_CASE("File path does not throws","[open]") {
    std::string path = ofFilePath::getCurrentExeDir() + "/Fixtures/FileHandling/test001.ofJson";
    ofJson result;
    
    REQUIRE_NOTHROW(result = JsonLoad::load(path));
    
    ofJson expectedState = {
        {"layers", ofJson::array()},
        {"scenes", ofJson::array()},
        {"visuals", ofJson::array()}
    };
     
    REQUIRE(result.dump().compare(expectedState.dump()) == 0);
    
    
}
                        
                        
TEST_CASE("Open a file and check the imported state is correct","[open]") {
    std::string path = ofFilePath::getCurrentExeDir() + "/Fixtures/FileHandling/test002.ofJson";
    ofJson result;
    
    REQUIRE_NOTHROW(result = JsonLoad::load(path));
    
    ofJson expectedLayers = {
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
    ofJson expectedVisuals = {
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
    ofJson expectedScenes = {
        {
            {"name", "scene 1"},
            {"instances", ofJson::array()}
        },
        {
            {"name", "scene 2"},
            {"instances", ofJson::array()}
        }
    };
    ofJson expectedState = {
        {"layers", expectedLayers},
        {"scenes", expectedScenes},
        {"visuals", expectedVisuals}
    };

    // check expected Layers
    REQUIRE(result["layers"].dump().compare(expectedLayers.dump()) == 0);
    
    // check expected visuals
    REQUIRE(result["visuals"].dump().compare(expectedVisuals.dump()) == 0);
    
    // check expected scenes
    unsigned int counter = 0;
    for (auto  &element:expectedScenes)
    {
        REQUIRE(element["name"].get<string>().compare(result["scenes"][counter]["name"].get<string>()) == 0);
        std::string expectedName = element["name"].get<string>();
        std::string name = result["scenes"][counter]["name"];
        REQUIRE(expectedName.compare(name) == 0);
     
        counter++;
    }

}
