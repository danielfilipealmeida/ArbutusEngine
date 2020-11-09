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
    
    Visual();

    filePath = findAbsolutePath(_filePath);
	loaded   = false;
    
    setCaption(getCaptionFromPath(filePath));
    
    setThumbnail();
    setType (VisualType_Video);
}



string VisualVideo::findAbsolutePath(string path)
{
    if (ofFile::doesFileExist(path, false))
    {
        return path;
    }
    
    string setFolder;
    
    setFolder = ofFilePath::getEnclosingDirectory(Set::getInstance().getFilePath ());
    path = ofFilePath::join(setFolder,path);
    if (ofFile::doesFileExist(path, false)) {
        return path;
    }

    path.clear();
    
    return path;
}

string VisualVideo::getCaptionFromPath(string path)
{
    if (path.empty()) {
        return "---";
    }
 
    return ofFilePath::getBaseName(path);
}

VisualVideo::~VisualVideo()
{
	if (loaded == true) closeVisual();
}


json VisualVideo::getState()
{
    json state;
    
    state = Visual::getState();
    state["filePath"] = filePath;
    
    return state;
}

void VisualVideo::setState(json state)
{
    Visual::setState(state);
}

bool VisualVideo::loadVideo()
{
    return false;
}


bool VisualVideo::closeVisual()
{
    return false;
    
}


bool VisualVideo::fileExists()
{
	// check if file exists
	fstream fin;
	string fileNameInOF = ofToDataPath(filePath);
	fin.open(fileNameInOF.c_str(),ios::in);
	if ( fin.is_open() ) {
        fin.close();
		return true;
	}


	return false;
}

void VisualVideo::saveThumbnail()
{
    Visual::saveThumbnail();
}

void VisualVideo::deleteThumbnail() {
    if (!ofFile::doesFileExist(getThumbnailPath())) {
        return;
    }
    
    ofFile::removeFile(getThumbnailPath());
}

void VisualVideo::setThumbnail()
{
    string newThumbnailPath;
    
    newThumbnailPath = enginePtr->calculateThumbnailPath(filePath);
    setThumbnailPath (newThumbnailPath);
    if (!this->screenshot.loadImage(newThumbnailPath)) {
        createThumbnail();
        Visual::saveThumbnail();
    }
}

unsigned int VisualVideo::getVideoMiddleFrame(ofVideoPlayer video)
{
    if (!video.isLoaded()) {
        return 0;
    }
    
    return (unsigned int) round (video.getTotalNumFrames()  / 2.0);
    
}

void VisualVideo::createThumbnail()
{
    Visual::createThumbnail();
    
    if(fileExists() == false) {
        return;
    }
    
    ofVideoPlayer video;
    
    video.loadMovie(filePath);
    video.setFrame(getVideoMiddleFrame(video));
    video.update();
    screenshot.allocate(video.getWidth(), video.getHeight(), OF_IMAGE_COLOR);
    screenshot.setFromPixels(video.getPixels().getData(), video.getWidth(), video.getHeight(), OF_IMAGE_COLOR, true);
    screenshot.resize(THUMBNAIL_WIDTH, THUMBNAIL_WIDTH * (screenshot.getHeight() / screenshot.getWidth()));
    video.close();
}

void VisualVideo::print()
{
    Visual::print();
    
    cout << "type: Video" <<endl;
	cout << "file path: "<<VisualVideo::filePath<<endl;
	cout << "loaded: ";
	
    if(VisualVideo::loaded == true) cout << "Yes"; else cout << "No";
	
    cout << endl;
}

bool VisualVideo::isLoaded ()
{
    return loaded;
}


void VisualVideo::setLoaded(bool _val)
{
    loaded = _val;
}


string VisualVideo::getFilePath ()
{
    return filePath;
}


void VisualVideo::setFilePath ( string _input )
{
    filePath = _input;
}

