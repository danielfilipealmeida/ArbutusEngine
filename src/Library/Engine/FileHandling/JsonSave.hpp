//
//  JsonSave.hpp
//  ArbutusEngine
//
//  Created by Daniel Almeida on 27/07/17.
//
//

#ifndef JsonSave_hpp
#define JsonSave_hpp

#include <stdio.h>
#include "ofJson.h"

class JsonSave {
public:
    /**
     !
     @abstract Saves the state into a file located at the given path
     @param path
     @param state
     */
    static void save(std::string path, ofJson state);
    
    
private:
    
    /* this should be moved somewhere else to be used to validate the state
     */
    
    /*!
     @param state 
     */
    static void validateState(ofJson state);
};

#endif /* JsonSave_hpp */
