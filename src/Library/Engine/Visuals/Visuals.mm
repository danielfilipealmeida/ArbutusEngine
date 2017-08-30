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

void Visuals::setState(json state)
{
    if (!state.is_array()) return;
    
    empty();
    
    for(auto visualState:state) {
        if (!visualState["type"].is_number()) continue;
        
        switch ((VisualType) visualState["type"].get<int>()) {
            case VisualType_Video: {
                if (!visualState["filePath"].is_string()) break;
                
                VisualVideo *newVisual = new VisualVideo(visualState["filePath"].get<string>());
                
                newVisual->setState(visualState);
                
                add((Visual *)newVisual);
                break;
            }

                
            case VisualType_Camera: {
                break;
            }
               
                
            case VisualType_Syphon:{
                break;
            }
                
            case VisualType_Generator:{
                break;
            }
        }
        
        
    }
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
    for (auto it = visualsList.begin();
         it!= visualsList.end();
         it++ )
    {
        Visual *visual = *it;
        delete visual;
        
        visualsList.erase(it);
    }
    
    print();
}



void Visuals::print() {
    int count = 1;
    for (auto visual:visualsList){
        cout << "VISUAL " << count << ":" << endl;
        visual->print();
        count++;
    }
}

// todo, traverse the list and search for the video. return it if it is there. if not continue the process

Visual* Visuals::addVideo(std::string path) {
    VisualVideo *video;
    
    
    video = new VisualVideo(path);
    add((Visual *) video);

    return (Visual *) video;
}
