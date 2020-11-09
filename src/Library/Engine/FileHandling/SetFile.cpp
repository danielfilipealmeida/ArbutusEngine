//
//  FileLoader.cpp
//  ArbutusEngine
//
//  Created by Daniel Almeida on 02/08/17.
//
//

#include "SetFile.hpp"
#include "JsonSave.hpp"
#include "JsonLoad.hpp"

ofJson SetFile::load(std::string path) {
    return JsonLoad::load(path);
}

void SetFile::save(std::string path, ofJson state) {
    JsonSave::save(path, state);
}
