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
    /*!
     @param path
     */
    static ofJson load(std::string path);
    
    /*!
     @param path
     @param state
     */
    static void save(std::string path, ofJson state);
};

#endif /* FileLoader_hpp */
