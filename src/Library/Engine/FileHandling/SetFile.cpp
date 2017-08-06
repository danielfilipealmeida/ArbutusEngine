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

void SetFile::load(std::string path) {
    JsonLoad::load(path);
}

void SetFile::save(std::string path, json state) {
    JsonSave::save(path, state);
}
