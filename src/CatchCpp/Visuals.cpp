//
//  Visuals.cpp
//  ArbutusEngine
//
//  Created by Daniel Almeida on 27/08/17.
//
//

#include <stdio.h>
#include "catch.hpp"

#include "Visuals.h"

TEST_CASE("State should be properly stored", "[setState]") {
    json state;
    
    Visuals::getInstance().empty();
 
    state = json::array({
        {
             {"type", VisualType_Video},
             {"filePath", "../../../data/loop001.mov"},
             {"caption", "video1"}
        },
        {
             {"type", VisualType_Video},
             {"filePath", "../../../data/loop002.mov"},
             {"caption", "video2"}
        }
    });
    
    Visuals::getInstance().setState(state);
    json currentVisualsState = Visuals::getInstance().getState();
    unsigned int counter = 0;
    for(auto it = state.begin();  it!=state.end(); it++) {
        json visualState = *it;
        REQUIRE(visualState["type"] == currentVisualsState.at(counter)["type"]);
        REQUIRE(visualState["filePath"].get<string>().compare(currentVisualsState.at(counter)["filePath"].get<string>()) == 0);
        REQUIRE(visualState["caption"].get<string>().compare(currentVisualsState.at(counter)["caption"].get<string>()) == 0);
        counter ++;
    }
}
