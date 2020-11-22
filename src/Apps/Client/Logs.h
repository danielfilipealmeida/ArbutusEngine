//
//  log.h
//  Client
//
//  Created by Daniel Almeida on 21/11/2020.
//

#ifndef log_h
#define log_h

#include "ofMain.h"


#define DEFAULT_NUMBER_OF_MESSAGES 10

class Logs {
    static Logs *instance_;
    static std::mutex mutex_;
    std::deque<string> logs;
    unsigned int numberOfMessages = DEFAULT_NUMBER_OF_MESSAGES;
    
protected:
    Logs(){}
    ~Logs(){}
    
public:
    Logs(Logs &other) = delete;
    void operator=(const Logs &) = delete;
    
    static Logs* getInstance();
    void log(std::string message, ofLogLevel level=OF_LOG_NOTICE);
    
    void forEach(std::function<void(std::string)> callback);
};


#endif /* log_h */
