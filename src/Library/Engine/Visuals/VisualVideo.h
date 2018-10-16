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





/*!
 @class VisualVideo
 @abstract ...
 @discussion ...
 */
class VisualVideo : public Visual {

    string filePath;
    bool loaded;
    
    
    /*!
     \brief Calculate the absolute path of a video.
     \param path a path
     \return the absolute path or null if not found
     */
    string findAbsolutePath(string path);
    
    
    /*!
     \brief Extract a caption from a Filepath
     \param path the file path
     \returns the caption that is the file basename or `---` if no path
     */
    string getCaptionFromPath(string path);
    
    /*!
     \brief Returns the frame number of the middle of the currently loaded video
     \param ofVideoPlayer a video
     \return the frame number of the middle of the video
     */
    unsigned int getVideoMiddleFrame(ofVideoPlayer video);
    
    /*!
     \brief TODO. This should only be set internally
     */
    void setLoaded(bool _val);
    
public:

    /*!
     \brief Contructor. Needs a path to a video
     */
    VisualVideo(string _filePath);
    
    /*!
     \brief Destructor
     */
    ~VisualVideo();
    
    /*!
     \brief Gets the state of the VisualVideo in json format
     */
    json getState();
    
    /*!
     \brief Specifies the state of the VisualVideo using a json as input parameter
     \param state a json that has the data that will update the state
     */
    void setState(json state);
    
    /*!
     \brief loads a video
     */
    bool loadVideo();
	
    /*!
     \brief closes the currently opened video
     */
    bool closeVisual();
	
    /*!
     \brief checks if file exists
     */
    bool fileExists();
    
    
    /*!
     \brief Deletes the thumbnail
     */
    void deleteThumbnail();
    
    
    /*!
     \brief Sets the tumbnail from the video file
     */
    void setThumbnail();
    
    /*!
     \brief Creates a thumbnail
     */
    void createThumbnail();
    
    
    
    /*!
     \brief Saves the thumbnail
     */
    void saveThumbnail();
    


    
    /*!
     \brief Prints debug message to the console
     */
    void print();
    
    
    /*!
     \brief ...
     */
    bool isLoaded ();
    

    
    /*!
     \brief ...
     */
    string getFilePath ();
    
    /*!
     \brief ...
     */
    void setFilePath ( string _input );
};

#endif
