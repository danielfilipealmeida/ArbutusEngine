//
//  VisualVideoTests.cpp
//  ArbutusEngine
//
//  Created by Daniel Almeida on 04/08/18.
//
//

#include <stdio.h>
#include "catch.hpp"
#include "VisualVideo.h"

using json = nlohmann::json;

#define STR_EXPAND(tok) #tok
#define STR(tok) STR_EXPAND(tok)
#define PATH_TO_VIDEO(v) std::string(STR(TEST_FILES_PATH)) + v


TEST_CASE("New VisualVideo Should be created with a Video path", "[constructor]") {
    VisualVideo *v;
    
    string path = PATH_TO_VIDEO("Loop001.mp4");
    
    v = new VisualVideo(path);
    
    REQUIRE(v != NULL);
    REQUIRE(v->isLoaded() == false);
    
    //v->loadVideo();
    //REQUIRE(v->isLoaded() == true);
    
    //REQUIRE(v->getCaption().compare("Loop001") == 0);
}


TEST_CASE("Creates screenshot if needed", "") {
    VisualVideo *v;
    
    string path = PATH_TO_VIDEO("Loop001.mp4");
    
    v = new VisualVideo(path);
    
}
