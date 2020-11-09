//
//  jsonLoad.cpp
//  ArbutusEngine
//
//  Created by Daniel Almeida on 27/07/17.
//
//

#include "JsonLoad.hpp"
#include "ofMain.h"

ofJson JsonLoad::load(std::string path) {
    if (!ofFile::doesFileExist(path)) {
        throw "File does not exist";
    }
    
    ofBuffer buffer = ofBufferFromFile(path);

    ofJson state = ofJson::parse(buffer.getText());
    
    // should validate the state
    return state;
    
}
