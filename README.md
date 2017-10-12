# Arbutus Engine

The Arbutus Engine is a C++ library on topic of Open Frameworks for creating Real-time Video mixing applications.


## Work todo

- continue working on the cmake configuration but for cross compiling to Linux and raspberry pi
- prepare a vagrant box to compile this project inside


## Installing

This project uses submodules

## Updating

git submodule update --init --recursive


## Notes

### Xcode command line

#### Project information

xcodebuild -list -project ArbutusEngine.xcodeproj/


#### Compiling

xcodebuild -scheme ArbutusLib build


