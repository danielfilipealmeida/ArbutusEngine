//
//  Visuals.hpp
//  ArbutusEngine
//
//  Created by Daniel Almeida on 14/08/17.
//
//

#ifndef Visuals_h
#define Visuals_h


#include <stdio.h>
#include "Visual.h"


class Visuals {
    VisualsList visualsList;
    
    Visuals() {};
    
public:
    
    static Visuals& getInstance();
    Visuals(Visuals const&) = delete;
    void operator=(Visuals const&) = delete;
    
    json getState();
    void add(Visual *visual);
    Boolean isFileInList(string filePath);
    unsigned int count();
    
    /*!
     traverse the Visuals list and return the visual
     */
    Visual* get(int pos);
    
    void empty();
    
    void print();
};





#endif /* Visuals_hpp */
