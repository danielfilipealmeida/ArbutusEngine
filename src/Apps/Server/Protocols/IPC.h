//
//  IPC.h
//  ArbutusEngine
//
//  Created by Daniel Almeida on 13/11/2020.
//

#ifndef IPC_h
#define IPC_h

#import "zmq.h"


class IPCProtocol : ComProtocol_Interface
{
    std::string uri;
    void *context;
    void *responder;
    int rc;
    
    uint64_t lastSent;
    uint64_t timeInterval = 100;
    
public:
    void init(ofJson config)
    {
        config.at("uri").get_to(this->uri);
        
        context = zmq_ctx_new ();
        responder = zmq_socket (context, ZMQ_REP);
        rc = zmq_bind (responder, uri.c_str());
        assert (rc == 0);
        
        /*
        while (1) {
            char buffer [10];
            zmq_recv (responder, buffer, 10, 0);
            printf ("Received Hello\n");
            sleep (1);          //  Do some 'work'
            zmq_send (responder, "World", 5, 0);
        }
        return 0;
         */
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
        rc = zmq_recv(responder, &msg, 0, ZMQ_NOBLOCK);
        if (rc < 0) {
            return;
        }
         
        std::string msgStr((char *)zmq_msg_data(&msg));
        ofLogNotice("IPC server", "message received: " + msgStr );

        
        lastSent = now;
    }
    
    
    void close()
    {
        
    }
};

#endif /* IPC_h */
