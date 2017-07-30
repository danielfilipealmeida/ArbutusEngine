//
//  Utils.cpp
//  ArbutusEngine
//
//  Created by Daniel Almeida on 30/07/17.
//
//

#include "Utils.h"
#include <stdio.h>
#include "ofMain.h"


std::string
Utils::md5(std::string message) {
    std::string result;
    std::string shellCommand;
    
    try {
        shellCommand = "md5 -q -s " + message;
        result = ofSystem(shellCommand);
        result.erase(result.size() - 2);
    }
    catch(std::exception& e) {
       // cout << e.what() << "\n";
        result = "";
    }
    return result;
}
