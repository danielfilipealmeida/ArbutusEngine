cmake_minimum_required (VERSION 2.6)
project (ArbutusEngine)

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


## Add CatchCpp


add_library(ArbutusEngine STATIC ${ArbutusEngine_SOURCES})
