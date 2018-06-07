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

extern Engine       *enginePtr;
extern AppProtocol  *app;

VisualVideo::VisualVideo(string _filePath)
{
    string setFolder;
    ofFile *visualFile2;
    
    Visual::Visual();
    
    // ATENCAO AQUI QUE ESTÁ A DAR ERRO
    //try {
        ofFile *visualFile = new ofFile(_filePath);
        if (!visualFile->exists()) {
            delete visualFile;
            
            // todo: fix this!
            setFolder = ofFilePath::getEnclosingDirectory(Set::getInstance().getFilePath () );
            _filePath = ofFilePath::join(setFolder,_filePath);
            visualFile2 = new ofFile(_filePath);
            setCaption (visualFile2->getFileName());
            delete visualFile2;
        }
        else {
            setCaption (visualFile->getFileName());
            delete visualFile;
        }
        

    filePath = _filePath;
	loaded   = false;
    setThumbnail();
    setType (VisualType_Video);
}



VisualVideo::~VisualVideo() {
	if (loaded == true) closeVisual();
}


json
VisualVideo::getState()
{
    json state;
    
    state = Visual::getState();
    
    state["filePath"] = filePath;
    
    return state;
}

void VisualVideo::setState(json state) {
    Visual::setState(state);
}

Boolean
VisualVideo::loadVideo(){
    return false;
}


Boolean
VisualVideo::closeVisual(){
    return false;
    
}


Boolean
VisualVideo::fileExists() {
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





void
VisualVideo::setThumbnail() {
    string newThumbnailPath;
    
   // thumbnailPath = Visual::getThumbnailPath ();
    newThumbnailPath = enginePtr->calculateThumbnailPath(filePath);
    
    setThumbnailPath (newThumbnailPath);
    if (!this->screenshot.loadImage(newThumbnailPath)) {
        createThumbnail();
        Visual::saveThumbnail();
    }

}

void
VisualVideo::saveThumbnail() {
    Visual::saveThumbnail();
}




void
VisualVideo::createThumbnail(){
    Visual::createThumbnail();
	if(fileExists() == false) return;
    
    unsigned int middleFrame;
    
    ofVideoPlayer video;
    video.loadMovie(filePath);
    middleFrame = (unsigned int) round(video.getTotalNumFrames() / 2.0);
    video.setFrame(middleFrame);
    video.update();
    screenshot.allocate(video.getWidth(), video.getHeight(), OF_IMAGE_COLOR);
    screenshot.setFromPixels(video.getPixels().getData(), video.getWidth(), video.getHeight(), OF_IMAGE_COLOR, true);
    screenshot.resize(THUMBNAIL_WIDTH, THUMBNAIL_WIDTH * (screenshot.getHeight() / screenshot.getWidth()));
}

void
VisualVideo::print(){
    Visual::print();
    cout << "type: Video" <<endl;
	cout << "file path: "<<VisualVideo::filePath<<endl;
	cout << "loaded: ";
	if(VisualVideo::loaded == true) cout << "Yes"; else cout << "No";
	cout << endl;
}


