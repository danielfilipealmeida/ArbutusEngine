# Arbutus Engine

The Arbutus Engine is a C++ library that uses openFrameworks for creating Real-time Video mixing applications.
Along with the Library, a TCP Server is also implemented for rendering video output.


## Work todo

- Implement a TCP server that will be used for network-based VJing apps.
- continue working on the cmake configuration but for cross compiling to Linux and raspberry pi
- prepare a vagrant box to compile this project inside


## Installing

This project uses submodules. When cloning this from Github please do the following:

    git clone --recursive https://github.com/danielfilipealmeida/ArbutusEngine.git
    
A XCode projec exist inside the folder called ``

## Updating

git submodule update --init --recursive


## Notes

### Xcode command line

#### Project information

xcodebuild -list -project ArbutusEngine.xcodeproj/


#### Compiling

xcodebuild -scheme ArbutusLib build


