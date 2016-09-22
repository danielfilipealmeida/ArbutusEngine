//
//  AppProtocol.h
//  emptyExample
//
//  Created by Daniel Almeida on 25/07/16.
//
//

#ifndef AppProtocol_h
#define AppProtocol_h



class AppProtocol {
    
public:
    virtual void beat();
    virtual void newMidiMessage(string msg);
    virtual void newOscMessage(string msg);
    virtual string getThumbnailPath(string filePath);
};

#endif /* AppProtocol_h */
