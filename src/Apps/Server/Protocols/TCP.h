//
//  TCP.h
//  ArbutusEngine
//
//  Created by Daniel Almeida on 13/11/2020.
//

#ifndef TCP_h
#define TCP_h

#include "ComProtocol.h"
#import "ofxTCPServer.h"

class TCPProtocol : ComProtocol_Interface
{
    int port;
    ofxTCPServer TCP;
    std::string delimiter = "\n";
    uint64_t lastSent;
    uint64_t timeInterval = 100;
    
public:
    
    void init(ofJson config)
    {
        config.at("port").get_to(this->port);
        TCP.setup(port);
        TCP.setMessageDelimiter(delimiter);
        lastSent = 0;
    }
    
    
    void update(std::function<ofJson(ofJson)> handler)
    {
        uint64_t now = ofGetElapsedTimeMillis();
        
        if(now - lastSent < timeInterval)
        {
            return;
        }
        
        for(int i = 0; i < TCP.getLastID(); i++){
            if( !TCP.isClientConnected(i) ) continue;
            
            std::string str = TCP.receive(i);
           
            if( str.length() > 0 ) {
                ofLogNotice("TCP server", "message received: " + str);
                
                json jsonResponse;
        
                try {
                    json jsonRequest = json::parse(str);
                    if (!jsonRequest.is_object()) {
                        continue;
                    }
                    
                    jsonResponse = handler(jsonRequest);
                }
                catch (std::exception &e) {
                    jsonResponse = {
                        {"success", false},
                        {"message", e.what()},
                        {"data", {}}
                    };
                }
                ofLogNotice("TCP server", "message sent: " + jsonResponse.dump(4));
                    
                TCP.send(i, jsonResponse.dump());
            }
        }
     
        lastSent = now;
    }
    
    
    void close()
    {
        TCP.close();
    }
};




#endif /* TCP_h */
