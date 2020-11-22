//
//  Logs.cpp
//  Client
//
//  Created by Daniel Almeida on 21/11/2020.
//

#include "Logs.h"



Logs* Logs::instance_{nullptr};
std::mutex Logs::mutex_;

Logs* Logs::getInstance() {
    std::lock_guard<std::mutex> lock(mutex_);
    if (instance_ == nullptr) {
        instance_ = new Logs();
    }
    return instance_;
}
    
void Logs::log(std::string message, ofLogLevel level) {
    ofLog(level, message);
    
    logs.push_back(message);
    
    if (this->logs.size() > numberOfMessages) {
        logs.pop_front();
    }
}

void Logs::forEach(std::function<void(string)> callback)
{
    for(auto log:logs) {
        callback(log);
    }
}
