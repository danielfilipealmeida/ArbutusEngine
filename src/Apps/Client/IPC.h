//
//  IPC.h
//  Client
//
//  Created by Daniel Almeida on 17/11/2020.
//

#ifndef IPC_h
#define IPC_h

#include "zmq.h"
#include "zhelpers.h"
#include "Logs.h"

class IPC {
    void *context;
    void *requester;
    int rc;
    std::string uri;
    Logs *logs;
    
    uint64_t lastSent;
    uint64_t timeInterval = 100;
    
public:
    
    IPC() {
        logs = Logs::getInstance();
    }
  
    bool isConnected() {
        return (bool) context && requester;
    }
    
    void connect(std::string _uri) {
        if (isConnected()) {
            close(true);
        }
        
        uri = _uri;
        logs->log("Connecting IPC socket at " + uri);
        context = zmq_ctx_new ();
        requester = zmq_socket (context, ZMQ_REQ);
        zmq_connect(requester, (char *) uri.c_str());
        
        logs->log(isConnected() ? "Connected" : "Connection failed");
    }
    
    void close(bool forceClose=false) {
        if (!context && !forceClose) {
            return;
        }
        
        logs->log("Closing connection");
        zmq_close (requester);
        zmq_ctx_destroy (context);
        requester = NULL;
        context = NULL;
    }
    
    void send(std::string message) {
        if (!isConnected()) return;
        
        logs->log("Attempt to send message: " + message);
        int size = s_send (requester, (char *) message.c_str());
        logs->log("Sent " + std::to_string(size) + " bytes");
    }
 
    void update(std::function<ofJson(ofJson)> handler)
       {
           uint64_t now = ofGetElapsedTimeMillis();
           
           if(now - lastSent < timeInterval)
           {
               return;
           }
           
           zmq_msg_t msg;
           int rc = zmq_msg_init (&msg);
           assert (rc == 0);
           rc = zmq_recv(requester, &msg, 0, ZMQ_NOBLOCK);
           if (rc < 0) {
               return;
           }
            
           std::string msgStr((char *)zmq_msg_data(&msg));
           ofLogNotice("IPC server", "message received: " + msgStr );
           
           lastSent = now;
       }
};

#endif /* IPC_h */
