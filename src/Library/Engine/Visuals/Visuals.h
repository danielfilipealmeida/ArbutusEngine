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
    
    /*!
     Returns the state of all the visuals on the running Engine
     */
    json getState();
    
    /*!
     Sets the state of the visuals
     */
    void setState(json state);
    
    /*!
     Adds a visual
     */
    void add(Visual *visual);
    
    /*!
    Checks if a file in in the list of visuals
     */
    Boolean isFileInList(string filePath);
    
    /*!
     returns the count of visuals. is this really needed? TODO: check if needed
     */
    unsigned int count();
    
    /*!
     traverse the Visuals list and return the visual
     */
    Visual* get(int pos);
    
    /*!
     Empties the visuals
     */
    void empty();
    
    /*!
     Print debug information regarding visuals into the console
     */
    void print();
    
    
    /*!
     Adds a video directly to visuals list
     Only add if the file isn't yet on the list. Always returns the desired video as a visual.
     */
    Visual* addVideo(std::string path);
};





#endif /* Visuals_hpp */
