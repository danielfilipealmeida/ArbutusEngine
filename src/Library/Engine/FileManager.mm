/*
 *  fileManager.cpp
 *  ARBUTUS
 *
 *  Created by Daniel Almeida on 1/2/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#include "FileManager.h"
#include "ofApp.h"
#include "Engine.h"



#define FILEMANAGER_TIME_INTERVAL 1

extern Engine *enginePtr;



FileManager::FileManager(){
}


void FileManager::start() {
    startThread();
}


void FileManager::stop(){
    stopThread();
}


void FileManager::threadedFunction(){
    while (isThreadRunning() != 0){
        if(lock()){
            
            //cout << "FileManager cleanup started" <<endl;
            if(enginePtr!=NULL) enginePtr->cleanup();
            
            unlock();
            ofSleepMillis(FILEMANAGER_TIME_INTERVAL * 60000);
        }
    }
}