# Development Notes

## Server

### Testing TCP on the command line

To test the TCP server, use netcat with echo or cat. Just pipe some stringified JSON into netcat like the following:

    echo "{\"action\":\"state\"}" | netcat 127.0.0.1 8080


### Available Server Actions

#### Ping

For checking if the server is up. will return with succhess and the message `pong`, with no additional data:

Message sent:

    {
    "action": "ping"
    }
    
Result:

    {
    "success": true,
    "message": pong,
    "data": {}
    }

    

#### getState
