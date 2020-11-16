//
//  ComProtocol.h
//  ArbutusEngine
//
//  Created by Daniel Almeida on 13/11/2020.
//

#ifndef ComProtocol_Interface_h
#define ComProtocol_Interface_h

/*!
 @abstract Protocol used to implement Communication Protocols like TCP and IPC
 */
class ComProtocol_Interface
{
public:
    
    /*!
     @abstract Initializes the communication protocal
     @param port the port used to connect to the server
     */
    virtual void init(ofJson config) = 0;
    
    
    /*!
     @abstract Handles currently incoming messages
     */
    virtual void update(std::function<ofJson(ofJson)> handler) = 0;
    
    
    /*!
    @abstract Closes all connections and destroys the server
    */
    virtual void close() = 0;
};

#endif /* ComProtocol_h */
