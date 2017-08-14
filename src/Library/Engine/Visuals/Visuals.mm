//
//  Visuals.cpp
//  ArbutusEngine
//
//  Created by Daniel Almeida on 14/08/17.
//
//

#include "Visuals.h"
#include "VisualCamera.h"
#include "VisualSyphon.h"
#include "VisualVideo.h"



Visuals& Visuals::getInstance()
{
    static Visuals instance;
    
    return instance;
}


json Visuals::getState()
{
    json state;
    
    for(auto visual:visualsList)
    {
        state.push_back(visual->getState());
    }
    
    return state;
}


void Visuals::add(Visual *visual)
{
    if (visual==NULL) return;
    visualsList.push_back(visual);
}



Boolean Visuals::isFileInList(string filePath)
{
    Boolean found = false;
    
    if (visualsList.empty() != true) {
        
        for (auto visual:visualsList)
        {
            switch (visual->getType()) {
                case VisualType_Video:
                    if (filePath.compare(((VisualVideo*)visual)->getFilePath () ) == 0 ) return true;
                    break;
                    
                case VisualType_Camera:
                    break;
                    
                case VisualType_Generator:
                    break;
                    
                case VisualType_Syphon:
                    break;
            }
        }
    }
    
    return found;
}

unsigned int Visuals::count()
{
    return (unsigned int) visualsList.size();
}


// traverse the Visuals list and return the visual
Visual* Visuals::get(int pos) {
    int counter = 0;
    
    // traverse
    for (auto visual:visualsList){
        if (counter == pos) {
            return visual;
            break;
        }
        counter++;
    }
    return NULL;
}




void Visuals::empty()
{
    while (!visualsList.empty()){
        visualsList.pop_front();
    }
}



void Visuals::print() {
    int count = 1;
    for (auto visual:visualsList){
        cout << endl;
      
        cout << "VISUAL " << count << ":" << endl;
        visual->print();
        count++;
    }
}
