cmake_minimum_required (VERSION 3.1)
project (ArbutusEngine)

set (CMAKE_CXX_STANDARD 11)
set (CMAKE_OSX_ARCHITECTURES "x86_64;i386")
set(CMAKE_BUILD_TYPE Release)
#set(ENGINE_PATH "src/Library/Engine/")
#include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)


## Catch an add all Project files
file(GLOB_RECURSE ArbutusEngine_SOURCES "src/*.cpp")
file(GLOB_RECURSE ArbutusEngine_HEADERS "src/*.h")

set (ArbutusEngine_INCLUDE_DIRS "")
foreach (_headerFile ${ArbutusEngine_HEADERS})
    get_filename_component(_dir ${_headerFile} PATH)
    list (APPEND ArbutusEngine_INCLUDE_DIRS ${_dir})
endforeach()
list(REMOVE_DUPLICATES ArbutusEngine_INCLUDE_DIRS)

include_directories(${ArbutusEngine_INCLUDE_DIRS})


## Add other libs
include_directories(External/Catch/single_include)
include_directories(External/openFrameworks/libs/openFrameworks)
include_directories(External/openFrameworks/libs/openFrameworks/3d)
include_directories(External/openFrameworks/libs/openFrameworks/app)
include_directories(External/openFrameworks/libs/openFrameworks/communication)
include_directories(External/openFrameworks/libs/openFrameworks/events)
include_directories(External/openFrameworks/libs/openFrameworks/gl)
include_directories(External/openFrameworks/libs/openFrameworks/graphics)
include_directories(External/openFrameworks/libs/openFrameworks/math)
include_directories(External/openFrameworks/libs/openFrameworks/sound)
include_directories(External/openFrameworks/libs/openFrameworks/types)
include_directories(External/openFrameworks/libs/openFrameworks/utils)
include_directories(External/openFrameworks/libs/openFrameworks/video)
include_directories(External/openFrameworks/libs/glew/include)
include_directories(External/openFrameworks/libs/tess2/include)
include_directories(External/openFrameworks/libs/boost/include)
include_directories(External/openFrameworks/libs/cairo/include)
include_directories(External/openFrameworks/libs/fmodex/include)
include_directories(External/openFrameworks/libs/FreeImage/include)
include_directories(External/openFrameworks/libs/freetype/include)
include_directories(External/openFrameworks/libs/glfw/include)
include_directories(External/openFrameworks/libs/glu/include)
include_directories(External/openFrameworks/libs/glut/include)
include_directories(External/openFrameworks/libs/kiss/include)
include_directories(External/openFrameworks/libs/openssl/include)
include_directories(External/openFrameworks/libs/poco/include)
include_directories(External/openFrameworks/libs/quicktime/include)
include_directories(External/openFrameworks/libs/rtAudio/include)
include_directories(External/openFrameworks/libs/videoInput/include)


add_library(ArbutusEngine STATIC ${ArbutusEngine_SOURCES})
