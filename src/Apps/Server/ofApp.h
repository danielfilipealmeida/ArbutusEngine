#pragma once

#include "ofMain.h"
#include "Engine.h"
#include "Protocols/TCP.h"
#include "Protocols/IPC.h"

#define DEFAULT_FRAME_RATE 20
#define DEFAULT_TCP_PORT 18082
#define DEFAULT_IPC_URI "ipc:///tmp/arbutus-state"

class ofApp : public ofBaseApp {
    vector <string> storeText;
    uint64_t lastSent;
    Engine *engine;
    TCPProtocol tcp;
    IPCProtocol ipc;
    
    public:
    void setup();
    void update();
    void draw();
    void close();
    void keyPressed(int key);
    void keyReleased(int key);
    void mouseMoved(int x, int y);
    void mouseDragged(int x, int y, int button);
    void mousePressed(int x, int y, int button);
    void mouseReleased(int x, int y, int button);
    void windowResized(int w, int h);
    void dragEvent(ofDragInfo dragInfo);
    
    /*!
     @param msg <#msg description#>
     */
    void gotMessage(ofMessage msg);
    
    /*!
     Starts the Arbutus Engine and sets up some playing stuff
     */
    void initEngine();
    
    /*!
     */
    void setupTestSet();
    
    
    // todo: move comunications to classes.

    
    /*!
     */
    void initIPC();
    
};
