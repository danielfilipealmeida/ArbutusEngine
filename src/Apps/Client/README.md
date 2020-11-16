# Server

A TCP server.

## TODO

- add message timestamp and message hash to be able to calculate comunication time. (communication time is the time a message from the client takes to be replied and recieved by the client. it measures two trips.)


## Messages

### ping

#### Request message

```
{
    "action": "ping"
}
```

#### Response message 

```
{
    "success", true,
    "message", "pong",
    "data", {}
};
```

### getState



### setState

### getFullState

### setLayerControl

### updateState
    
