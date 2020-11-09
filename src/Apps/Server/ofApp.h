#pragma once

#include "ofMain.h"
#include "ofxTCPServer.h"

using json = nlohmann::json;

class ofApp : public ofBaseApp {
    ofxTCPServer TCP;
    vector <string> storeText;
    uint64_t lastSent;
    
    unsigned int serverPort = 18082;
    
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
    
    
    /*!
     Starts the Arbutus Engine and sets up some playing stuff
     */
    void initEngine();
    
    
    /*!
     Starts up the TCP Server
     */
    void initTCPServer();
    
    /*!
     Updates the TCP Server to handle requests
     */
    void updateTCPServer();
    
};
