//
//  jsonLoad.hpp
//  ArbutusEngine
//
//  Created by Daniel Almeida on 27/07/17.
//
//

#ifndef JsonLoad_hpp
#define JsonLoad_hpp

#include <stdio.h>
#include "ofJson.h"

class JsonLoad {
public:
    /**!
     @abstract Loads the state from a file located at the given path
     */
    static ofJson
    load(std::string path);

};

#endif /* JsonLoad_hpp */
