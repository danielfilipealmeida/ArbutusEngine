# Generated by CMake

if("${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}" LESS 2.5)
   message(FATAL_ERROR "CMake >= 2.6.0 required")
endif()
cmake_policy(PUSH)
cmake_policy(VERSION 2.6)
#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Protect against multiple inclusion, which would fail when already imported targets are added once more.
set(_targetsDefined)
set(_targetsNotDefined)
set(_expectedTargets)
foreach(_expectedTarget libzmq libzmq-static)
  list(APPEND _expectedTargets ${_expectedTarget})
  if(NOT TARGET ${_expectedTarget})
    list(APPEND _targetsNotDefined ${_expectedTarget})
  endif()
  if(TARGET ${_expectedTarget})
    list(APPEND _targetsDefined ${_expectedTarget})
  endif()
endforeach()
if("${_targetsDefined}" STREQUAL "${_expectedTargets}")
  unset(_targetsDefined)
  unset(_targetsNotDefined)
  unset(_expectedTargets)
  set(CMAKE_IMPORT_FILE_VERSION)
  cmake_policy(POP)
  return()
endif()
if(NOT "${_targetsDefined}" STREQUAL "")
  message(FATAL_ERROR "Some (but not all) targets in this export set were already defined.\nTargets Defined: ${_targetsDefined}\nTargets not yet defined: ${_targetsNotDefined}\n")
endif()
unset(_targetsDefined)
unset(_targetsNotDefined)
unset(_expectedTargets)


# Create imported target libzmq
add_library(libzmq SHARED IMPORTED)

set_target_properties(libzmq PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES "/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/include;/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/cmake-make"
  INTERFACE_LINK_LIBRARIES "/usr/local/Cellar/libsodium/1.0.18_1/lib/libsodium.dylib"
)

# Create imported target libzmq-static
add_library(libzmq-static STATIC IMPORTED)

set_target_properties(libzmq-static PROPERTIES
  INTERFACE_COMPILE_DEFINITIONS "ZMQ_STATIC"
  INTERFACE_INCLUDE_DIRECTORIES "/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/include;/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/cmake-make"
  INTERFACE_LINK_LIBRARIES "/usr/local/Cellar/libsodium/1.0.18_1/lib/libsodium.dylib"
)

# Import target "libzmq" for configuration "Release"
set_property(TARGET libzmq APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(libzmq PROPERTIES
  IMPORTED_LOCATION_RELEASE "/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/cmake-make/lib/libzmq.5.2.3.dylib"
  IMPORTED_SONAME_RELEASE "@rpath/libzmq.5.dylib"
  )

# Import target "libzmq-static" for configuration "Release"
set_property(TARGET libzmq-static APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(libzmq-static PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C;CXX"
  IMPORTED_LOCATION_RELEASE "/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/cmake-make/lib/libzmq.a"
  )

# This file does not depend on other imported targets which have
# been exported from the same project but in a separate export set.

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
cmake_policy(POP)
