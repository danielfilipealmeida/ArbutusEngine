#pragma once

#include "ofMain.h"
#include "ofxTCPServer.h"
#include "Engine.h"

#define DEFAULT_FRAME_RATE 20
#define DEFAULT_SERVER_PORT 18082

class ofApp : public ofBaseApp {
    ofxTCPServer TCP;
    vector <string> storeText;
    uint64_t lastSent;
    Engine *engine;
    
    unsigned int serverPort = DEFAULT_SERVER_PORT;
    
	public:

    /*!
     */
    void setup();
    
    /*!
     */
    void update();
    
    /*!
     */
    void draw();
    
    /*!
     */
    void close();
		
    /*!
     @param key <#key description#>
     */
    void keyPressed(int key);
    
    /*!
     @param key <#key description#>
     */
    void keyReleased(int key);
    
    /*!
     @param x <#x description#>
     @param y <#y description#>
     */
    void mouseMoved(int x, int y);
    
    /*!
     @param x <#x description#>
     @param y <#y description#>
     @param button <#button description#>
     */
    void mouseDragged(int x, int y, int button);
    
    /*!
     @param x <#x description#>
     @param y <#y description#>
     @param button <#button description#>
     */
    void mousePressed(int x, int y, int button);
    
    /*!
     @param x <#x description#>
     @param y <#y description#>
     @param button <#button description#>
     */
    void mouseReleased(int x, int y, int button);
    
    /*!
     @param w <#w description#>
     @param h <#h description#>
     */
    void windowResized(int w, int h);
    
    /*!
     @param dragInfo <#dragInfo description#>
     */
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
     Starts up the TCP Server
     */
    void initTCPServer();
    
    /*!
     Updates the TCP Server to handle requests
     */
    void updateTCPServer();
    
    /*!
     */
    void initIPC();
    
};
