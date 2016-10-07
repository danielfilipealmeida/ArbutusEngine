//
//  VisualVideo.cpp
//  FigTree
//
//  Created by Daniel Almeida on 02/05/14.
//
//

#include "VisualVideo.h"
#include "Engine.h"
#include "AppProtocol.h"

extern Engine       *_engine;
extern AppProtocol  *app;

VisualVideo::VisualVideo(string _filePath) {
    Visual::Visual();
    
        // ATENCAO AQUI QUE ESTÁ A DAR ERRO
    try {
        ofFile *visualFile = new ofFile(_filePath);
        if (!visualFile->exists()) {
            delete visualFile;
            
            /*
             ofFile *setFile = new ofFile(_engine->currentSet.filePath);
             string setFolder = setFile->getEnclosingDirectory();
             */
            string setFolder = ofFilePath::getEnclosingDirectory(_engine->getCurrentSet()->getFilePath () );
            
            _filePath = ofFilePath::join(setFolder,_filePath);
                //NSLog(@"%s", _filePath.c_str());
            ofFile *visualFile2 = new ofFile(_filePath);
            setCaption (visualFile2->getFileName());
            delete visualFile2;
        }
        else {
            setCaption (visualFile->getFileName());
            delete visualFile;
        }
        
      
    }
    catch (int e) {
        cout << "Exception " << e <<"\n";
     }
        // check if file exists
    
    
    filePath = _filePath;
	loaded = false;
        //createThumbnail();
        setThumbnail();
    setType (VisualType_Video);
}

VisualVideo::~VisualVideo() {
	if (loaded == true) closeVisual();
    Visual::~Visual();
}


Boolean VisualVideo::loadVideo(){
    return false;
}

Boolean VisualVideo::closeVisual(){
    return false;
    
}

Boolean VisualVideo::fileExists() {
	// check if file exists
	fstream fin;
	string fileNameInOF = ofToDataPath(filePath);
	fin.open(fileNameInOF.c_str(),ios::in);
	if ( fin.is_open() ) {
        fin.close();
		return true;
	}

        //string curentSetPath = ofFilePath::getPathForDirectory(_engine->currentSet.filePath);    ;
    
	return false;
}





void VisualVideo::setThumbnail() {
    string newThumbnailPath;
    
   // thumbnailPath = Visual::getThumbnailPath ();
    newThumbnailPath = _engine->calculateThumbnailPath(filePath);
    
    setThumbnailPath (newThumbnailPath);
    if (!this->screenshot.loadImage(newThumbnailPath)) {
        createThumbnail();
        Visual::saveThumbnail();
    }

}

void VisualVideo::saveThumbnail() {
    Visual::saveThumbnail();
}




void VisualVideo::createThumbnail(){
    Visual::createThumbnail();
	if(fileExists() == false) return;
    
    
    ofVideoPlayer video;
    video.loadMovie(filePath);
    video.setFrame(2);
    video.update();
    screenshot.allocate(video.width, video.height, OF_IMAGE_COLOR);
    screenshot.setFromPixels(video.getPixels(), video.getWidth(), video.getHeight(), OF_IMAGE_COLOR, true);
    screenshot.resize(THUMBNAIL_WIDTH, THUMBNAIL_WIDTH * (screenshot.getHeight() / screenshot.getWidth()));
  
    
}

void VisualVideo::print(){
    Visual::print();
    cout << "type: Video" <<endl;
	cout << "file path: "<<VisualVideo::filePath<<endl;
	cout << "loaded: ";
	if(VisualVideo::loaded == true) cout << "Yes"; else cout << "No";
	cout << endl;
	
}


