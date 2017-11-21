# Development Notes

## Server

### Testing TCP on the command line

To test the TCP server, use netcat with echo or cat. Just pipe some stringified JSON into netcat like the following:

    echo "{\"action\":\"getState\"}" | netcat 127.0.0.1 8080


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



#### getFullState

To retrieve information used to produce controls over the Engine. Will return controlable parameters with limits, type and value.

Message sent:

    {
    "action": "ping"
    }
    
Message recieved:
    
    "data":{
    "activeVisualInstance":{
    "alpha":{
    "defaultValue":1.0,
    "max":1.0,
    "min":0.0,
    "title":"Alpha",
    "type":"f",
    "value":1.0
    },
    "blue":{
    "defaultValue":1.0,
    "max":1.0,
    "min":-1.0,
    "title":"Blue",
    "type":"f",
    "value":0.0
    },
    "brightness":{
    "max":2.0,
    "min":0.0,
    "title":"Brightness",
    "type":"f",
    "value":1.0
    },
    "centerX":{
    "max":2.0,
    "min":-2.0,
    "title":"Center X",
    "type":"f",
    "value":0.0
    },
    "centerY":{
    "max":2.0,
    "min":-2.0,
    "title":"Center Y",
    "type":"f",
    "value":0.0
    },
    "contrast":{
    "max":2.0,
    "min":0.0,
    "title":"Contrast",
    "type":"f",
    "value":1.0
    },
    "direction":{
    "options":[
    {
    "title":"Left",
    "value":1
    },
    {
    "title":"Right",
    "value":2
    }
    ],
    "title":"Direction",
    "type":"toggle_button_group",
    "value":1
    },
    "effects_drywet":{
    "max":1.0,
    "min":0.0,
    "title":"Dry/Wet",
    "type":"f",
    "value":0.5
    },
    "endPercentage":{
    "max":1.0,
    "min":0.0,
    "title":"End",
    "type":"f",
    "value":1.0
    },
    "green":{
    "defaultValue":1.0,
    "max":1.0,
    "min":-1.0,
    "title":"Green",
    "type":"f",
    "value":0.0
    },
    "height":{
    "max":1080,
    "min":0,
    "type":"j",
    "value":480
    },
    "loopMode":{
    "options":[
    {
    "title":"Normal",
    "value":1
    },
    {
    "title":"Ping Ping",
    "value":2
    },
    {
    "title":"Inverse",
    "value":3
    }
    ],
    "title":"Loop Mode",
    "type":"toggle_button_group",
    "value":1
    },
    "name":{
    "title":"Name",
    "type":"NSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEE",
    "value":""
    },
    "percentagePlayed":{
    "max":1.0,
    "min":0.0,
    "title":"Percentage Played",
    "type":"f",
    "value":0.0
    },
    "red":{
    "defaultValue":1.0,
    "max":1.0,
    "min":-1.0,
    "title":"Red",
    "type":"f",
    "value":0.0
    },
    "saturation":{
    "max":2.0,
    "min":0.0,
    "title":"Saturation",
    "type":"f",
    "value":1.0
    },
    "startPercentage":{
    "max":1.0,
    "min":0.0,
    "title":"Start",
    "type":"f",
    "value":0.0
    },
    "triggerMode":{
    "options":[
    {
    "title":"Mouse Down",
    "value":1
    },
    {
    "title":"Mouse Up",
    "value":2
    },
    {
    "title":"Piano",
    "value":3
    }
    ],
    "title":"Trigger Mode",
    "type":"toggle_button_group",
    "value":1
    },
    "width":{
    "max":1920,
    "min":0,
    "type":"j",
    "value":640
    },
    "zoomX":{
    "max":8.0,
    "min":0.0,
    "title":"Zoom X",
    "type":"f",
    "value":1.0
    },
    "zoomY":{
    "max":8.0,
    "min":0.0,
    "title":"Zoom Y",
    "type":"f",
    "value":1.0
    }
    },
    "layers":[
    {
    "alpha":{
    "defaultValue":1.0,
    "max":1.0,
    "min":0.0,
    "title":"Alpha",
    "type":"f",
    "value":1.0
    },
    "blendMode":{
    "defaultValue":1,
    "max":5,
    "min":1,
    "title":"Blend Mode",
    "type":"9BlendMode",
    "value":2
    },
    "blue":{
    "defaultValue":1.0,
    "max":1.0,
    "min":-1.0,
    "title":"Blue",
    "type":"f",
    "value":1.0
    },
    "blurH":{
    "defaultValue":0,
    "max":10.0,
    "min":0.0,
    "title":"Horizontal Blur",
    "type":"f",
    "value":0
    },
    "blurV":{
    "defaultValue":0,
    "max":10.0,
    "min":0.0,
    "title":"Vertical Blur",
    "type":"f",
    "value":0
    },
    "brightness":{
    "max":2.0,
    "min":0.0,
    "title":"Brightness",
    "type":"f",
    "value":1.0
    },
    "contrast":{
    "max":2.0,
    "min":0.0,
    "title":"Contrast",
    "type":"f",
    "value":1.0
    },
    "green":{
    "defaultValue":1.0,
    "max":1.0,
    "min":-1.0,
    "title":"Green",
    "type":"f",
    "value":1.0
    },
    "height":{
    "max":1080,
    "min":0,
    "type":"j",
    "value":480
    },
    "name":{
    "title":"Name",
    "type":"NSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEE",
    "value":"Layer 1"
    },
    "red":{
    "defaultValue":1.0,
    "max":1.0,
    "min":-1.0,
    "title":"Red",
    "type":"f",
    "value":1.0
    },
    "saturation":{
    "max":2.0,
    "min":0.0,
    "title":"Saturation",
    "type":"f",
    "value":1.0
    },
    "width":{
    "max":1920,
    "min":0,
    "type":"j",
    "value":640
    }
    },
    {
    "alpha":{
    "defaultValue":1.0,
    "max":1.0,
    "min":0.0,
    "title":"Alpha",
    "type":"f",
    "value":1.0
    },
    "blendMode":{
    "defaultValue":1,
    "max":5,
    "min":1,
    "title":"Blend Mode",
    "type":"9BlendMode",
    "value":2
    },
    "blue":{
    "defaultValue":1.0,
    "max":1.0,
    "min":-1.0,
    "title":"Blue",
    "type":"f",
    "value":1.0
    },
    "blurH":{
    "defaultValue":0,
    "max":10.0,
    "min":0.0,
    "title":"Horizontal Blur",
    "type":"f",
    "value":0
    },
    "blurV":{
    "defaultValue":0,
    "max":10.0,
    "min":0.0,
    "title":"Vertical Blur",
    "type":"f",
    "value":0
    },
    "brightness":{
    "max":2.0,
    "min":0.0,
    "title":"Brightness",
    "type":"f",
    "value":1.0
    },
    "contrast":{
    "max":2.0,
    "min":0.0,
    "title":"Contrast",
    "type":"f",
    "value":1.0
    },
    "green":{
    "defaultValue":1.0,
    "max":1.0,
    "min":-1.0,
    "title":"Green",
    "type":"f",
    "value":1.0
    },
    "height":{
    "max":1080,
    "min":0,
    "type":"j",
    "value":480
    },
    "name":{
    "title":"Name",
    "type":"NSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEE",
    "value":"Layer 2"
    },
    "red":{
    "defaultValue":1.0,
    "max":1.0,
    "min":-1.0,
    "title":"Red",
    "type":"f",
    "value":1.0
    },
    "saturation":{
    "max":2.0,
    "min":0.0,
    "title":"Saturation",
    "type":"f",
    "value":1.0
    },
    "width":{
    "max":1920,
    "min":0,
    "type":"j",
    "value":640
    }
    }
    ]
    },
    "message":"",
    "success":true
    }
