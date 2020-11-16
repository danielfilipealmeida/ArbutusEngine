//
//  main.cpp
//  ipc_client
//
//  Created by Daniel Almeida on 16/11/2020.
//

#include "zmq.h"
#include "zhelpers.h"
#include <array>
#include <string>
#include <iostream>

#define URI "ipc:///tmp/arbutus-state"

void *context;
void *requester;
int rc;

std::array<std::string, 8>  words = {"Lorem", "Ipsum", "dolor", "sit", "amet", "consectetur", "adipiscing", "elit"};

int main(int argc, const char * argv[]) {

    context = zmq_ctx_new ();
    requester = zmq_socket (context, ZMQ_REQ);
    zmq_connect(requester, URI);
    int request_nbr;
    
    request_nbr = 1;
    for(auto str:words) {
        s_send (requester, (char *) str.c_str());
        std::string receivedStr = s_recv (requester);
        std::cout << "Received reply # " << std::to_string(request_nbr) << " '" << receivedStr << "'\n";
        
        request_nbr++;
    }
    zmq_close (requester);
    zmq_ctx_destroy (context);
    
    return 0;
}
