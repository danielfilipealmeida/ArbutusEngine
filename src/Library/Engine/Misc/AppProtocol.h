//
//  AppProtocol.h
//  emptyExample
//
//  Created by Daniel Almeida on 25/07/16.
//
//

#ifndef AppProtocol_h
#define AppProtocol_h


/*!
 @class AppProtocol
 @abstract
 @discussion
 */
class AppProtocol {
    
public:
    virtual void beat();
    virtual void newMidiMessage(std::string msg);
    virtual void newOscMessage(std::string msg);
    virtual std::string getThumbnailPath(std::string filePath);
    
};

#endif /* AppProtocol_h */
