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
#include "ofJson.h"


class SetFile {
public:
    static ofJson load(std::string path);
    static void save(std::string path, ofJson state);
};

#endif /* FileLoader_hpp */
