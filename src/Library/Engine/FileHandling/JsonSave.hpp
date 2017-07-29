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
#include "json.hpp"

using json = nlohmann::json;

class JsonSave {
public:
    /**!
    @abstract Saves the state into a file located at the given path
     */
    static void
    save(std::string path, json state);
    
    
private:
    
    /* this should be moved somewhere else to be used to validate the state
     */
    static void
    validateState(json state);
};

#endif /* JsonSave_hpp */
