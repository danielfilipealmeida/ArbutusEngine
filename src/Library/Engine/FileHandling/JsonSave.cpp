//
//  JsonSave.cpp
//  ArbutusEngine
//
//  Created by Daniel Almeida on 27/07/17.
//
//

#include "JsonSave.hpp"
#include "ofMain.h"

void
JsonSave::save(std::string path, ofJson state) {
    JsonSave::validateState(state);
    
    // check the basepath to the file exists
    if (!ofDirectory::doesDirectoryExist(ofFilePath::getEnclosingDirectory(path))) {
        throw "Path to file doesn't exist";
    }
    
    // try to save
    ofBuffer *buffer = new ofBuffer();
    buffer->set(state.dump(4));
    if (!ofBufferToFile(path, *buffer)) {
        throw "Error saving to file";
    }
    
    // confirms the file was stored
    if (!ofFile::doesFileExist(path)) throw "File not saved at the specified path";
}


/* this should be moved. create an object to handle state */
void
JsonSave::validateState(ofJson state) {
    if (state.empty()) throw ("State is empty");
    if (!state.is_object()) throw ("State is not an object");
    
}
