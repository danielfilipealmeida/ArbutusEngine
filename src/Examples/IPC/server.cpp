//
//  server.cpp
//  ArbutusEngine
//
//  Created by Daniel Almeida on 16/11/2020.
//

#include <stdio.h>

//#include <iostream>
#include "unistd.h"
#include "zmq.h"
#include <cassert>
#include "zhelpers.h"
#include <string>
#include <iostream>

#define URI "ipc:///tmp/arbutus-state"

void *context;
void *responder;
int rc;

int main(void)
{
    context = zmq_ctx_new ();
    responder = zmq_socket (context, ZMQ_REP);
    rc = zmq_bind (responder, URI);
    assert (rc == 0);
    
    std::cout << "IPC server started at '" << URI <<"'.\n\n";
    while (1) {
        std::string str = s_recv (responder);
        std::cout << "Received '" << str << "'\n";
       
        sleep (1);          //  Do some 'work'
        s_send (responder, (char *) (str + " - " + str).c_str());
    }
    return 0;
    
}
