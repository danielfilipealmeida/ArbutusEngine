#pragma once

#include "ofMain.h"
#include "ofxGui.h"
#include "IPC.h"
#include "Logs.h"

#define URI "ipc:///tmp/arbutus-state"
#define COUT_LOG_FILE "/tmp/arbutus-client-cout"

class ofApp : public ofBaseApp {
    IPC ipc;
    Logs *logs;

    
    ofJson PING_MESSAGE = {{"action", "ping"}};
    
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
    void gotMessage(ofMessage msg);
    
    
#pragma mark Listeners
    void tcpEnabledChanged(bool & value);
    void ipcEnabledChanged(bool & value);
    void handlePingButton();
    
    
#pragma mark GUI
    ofxPanel gui;
    ofParameter<bool> tcpEnabled;
    ofParameter<bool> ipcEnabled;
    
    ofxButton pingButton;
};
