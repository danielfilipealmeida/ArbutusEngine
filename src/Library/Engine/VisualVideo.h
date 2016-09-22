//
//  VisualVideo.h
//  FigTree
//
//  Created by Daniel Almeida on 02/05/14.
//
//

#ifndef FigTree_VisualVideo_h
#define FigTree_VisualVideo_h

#include "Visual.h"




class VisualVideo : public Visual {

    string filePath;
    Boolean loaded;
    
public:

    
    VisualVideo(string _filePath);
    ~VisualVideo();
    
    Boolean loadVideo();
	Boolean closeVisual();
	Boolean fileExists();
    
    
        // thumbnails
    string getThumbnailPath();
    void setThumbnail();
    void saveThumbnail();
    void createThumbnail();

    
    void print();
    
    /** setters and getters **/
    
    Boolean isLoaded () { return loaded; }
    void setLoaded(Boolean _val) { loaded = _val; }
    
    string getFilePath () { return filePath; }
    void setFilePath ( string _input ) { filePath = _input; }
};

#endif
