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
    /*!
     \brief Gets the instance of this singleton class
     */
    static Visuals& getInstance();
    
    
    Visuals(Visuals const&) = delete;
    void operator=(Visuals const&) = delete;
    
    /*!
     \brief Returns the state of all the visuals on the running Engine
     */
    json getState();
    
    /*!
     \brief Sets the state of the visuals
     */
    void setState(json state);
    
    /*!
     \brief Adds a visual
     */
    void add(Visual *visual);
    
    /*!
     \brief Checks if a file in in the list of visuals
     */
    Boolean isFileInList(string filePath);
    
    /*!
     \brief returns the count of visuals. is this really needed? TODO: check if needed
     */
    unsigned int count();
    
    /*!
     \brief traverse the Visuals list and return the visual
     */
    Visual* get(int pos);
    
    /*!
     \brief Empties the visuals
     */
    void empty();
    
    /*!
     \brief Print debug information regarding visuals into the console
     */
    void print();
    
    
    /*!
     \brief Adds a video directly to visuals list
     Only add if the file isn't yet on the list. Always returns the desired video as a visual.
     */
    Visual* addVideo(std::string path);
};





#endif /* Visuals_hpp */
