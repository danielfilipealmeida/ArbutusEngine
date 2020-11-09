# Arbutus Engine

The Arbutus Engine is a C++ library that uses openFrameworks for creating Real-time Video mixing applications.
Along with the Library, a TCP Server is also implemented for rendering video output.




## Compiling

This project uses submodules. When cloning this from Github please do the following:

    git clone --recursive https://github.com/danielfilipealmeida/ArbutusEngine.git
    
There are several targets on XCode:

* the Library
* an Hello world app
* a TCP server that can be used as an example and a real app.

All dependencies will be retrieve from github and present inside the `External`  folder. Everything is ready for compiling.

## Updating

git submodule update --init --recursive


## Notes

### Xcode command line

#### Project information

xcodebuild -list -project ArbutusEngine.xcodeproj/


#### Compiling

xcodebuild -scheme ArbutusLib build



## Work todo


- Compile all again
- add documentation placemarks on all functions
- implement IPC 

- fix generated json of the state
- break the current shader into parts. have one shader per effect
- create a shader for helping on the transitions: a shader that applies a grayscale fbo to the alpha channel of another fbo
- create a transition object, that receives: channel A fbo, channel B fbo, transition visual, visual position. it can also receive a transition duration. (maybe another method)
- save output to disk
- continue working on the cmake configuration but for cross compiling to Linux and raspberry pi
- prepare a vagrant box to compile this project inside

