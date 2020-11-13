# Server

>> A Video mixing app based on Arbutus Engine with a `TCP` and `IPC` server to be executed remotely.

Copyright 2020 Daniel Almeida

---





## How to test

### TCP

Use `telnet` to test `TCP`. With the server running run the following in a console:

```bash
telnet localhost 18082
```

If all is fine you should see something like:

```
telnet localhost 18082
Trying ::1...
telnet: connect to address ::1: Connection refused
Trying 127.0.0.1...
Connected to localhost.
Escape character is '^]'.
```

Now try to ping, by sending the `json` message with the `ping` action:

```
{"action":"ping"}
```

You should be answered with:

{"data":{},"message":"pong","success":true}


### IPC

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
    


