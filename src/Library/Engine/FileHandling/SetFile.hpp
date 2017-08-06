//
//  FileLoader.hpp
//  ArbutusEngine
//
//  Created by Daniel Almeida on 02/08/17.
//
//

#ifndef SetFile_hpp
#define SetFile_hpp

#include <stdio.h>
#include <string>
#include "json.hpp"

using json = nlohmann::json;


class SetFile {
public:
    static void load(std::string path);
    static void save(std::string path, json state);
};

#endif /* FileLoader_hpp */
