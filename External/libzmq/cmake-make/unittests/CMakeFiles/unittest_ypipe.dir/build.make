# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.15

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/Cellar/cmake/3.15.1/bin/cmake

# The command to remove a file.
RM = /usr/local/Cellar/cmake/3.15.1/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = "/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq"

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = "/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/cmake-make"

# Include any dependencies generated for this target.
include unittests/CMakeFiles/unittest_ypipe.dir/depend.make

# Include the progress variables for this target.
include unittests/CMakeFiles/unittest_ypipe.dir/progress.make

# Include the compile flags for this target's objects.
include unittests/CMakeFiles/unittest_ypipe.dir/flags.make

unittests/CMakeFiles/unittest_ypipe.dir/unittest_ypipe.cpp.o: unittests/CMakeFiles/unittest_ypipe.dir/flags.make
unittests/CMakeFiles/unittest_ypipe.dir/unittest_ypipe.cpp.o: ../unittests/unittest_ypipe.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/cmake-make/CMakeFiles" --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object unittests/CMakeFiles/unittest_ypipe.dir/unittest_ypipe.cpp.o"
	cd "/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/cmake-make/unittests" && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/unittest_ypipe.dir/unittest_ypipe.cpp.o -c "/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/unittests/unittest_ypipe.cpp"

unittests/CMakeFiles/unittest_ypipe.dir/unittest_ypipe.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/unittest_ypipe.dir/unittest_ypipe.cpp.i"
	cd "/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/cmake-make/unittests" && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E "/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/unittests/unittest_ypipe.cpp" > CMakeFiles/unittest_ypipe.dir/unittest_ypipe.cpp.i

unittests/CMakeFiles/unittest_ypipe.dir/unittest_ypipe.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/unittest_ypipe.dir/unittest_ypipe.cpp.s"
	cd "/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/cmake-make/unittests" && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S "/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/unittests/unittest_ypipe.cpp" -o CMakeFiles/unittest_ypipe.dir/unittest_ypipe.cpp.s

# Object files for target unittest_ypipe
unittest_ypipe_OBJECTS = \
"CMakeFiles/unittest_ypipe.dir/unittest_ypipe.cpp.o"

# External object files for target unittest_ypipe
unittest_ypipe_EXTERNAL_OBJECTS =

bin/unittest_ypipe: unittests/CMakeFiles/unittest_ypipe.dir/unittest_ypipe.cpp.o
bin/unittest_ypipe: unittests/CMakeFiles/unittest_ypipe.dir/build.make
bin/unittest_ypipe: lib/libtestutil-static.a
bin/unittest_ypipe: lib/libzmq.a
bin/unittest_ypipe: /usr/local/Cellar/libsodium/1.0.18_1/lib/libsodium.dylib
bin/unittest_ypipe: lib/libunity.a
bin/unittest_ypipe: unittests/CMakeFiles/unittest_ypipe.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir="/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/cmake-make/CMakeFiles" --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable ../bin/unittest_ypipe"
	cd "/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/cmake-make/unittests" && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/unittest_ypipe.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
unittests/CMakeFiles/unittest_ypipe.dir/build: bin/unittest_ypipe

.PHONY : unittests/CMakeFiles/unittest_ypipe.dir/build

unittests/CMakeFiles/unittest_ypipe.dir/clean:
	cd "/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/cmake-make/unittests" && $(CMAKE_COMMAND) -P CMakeFiles/unittest_ypipe.dir/cmake_clean.cmake
.PHONY : unittests/CMakeFiles/unittest_ypipe.dir/clean

unittests/CMakeFiles/unittest_ypipe.dir/depend:
	cd "/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/cmake-make" && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" "/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq" "/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/unittests" "/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/cmake-make" "/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/cmake-make/unittests" "/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/cmake-make/unittests/CMakeFiles/unittest_ypipe.dir/DependInfo.cmake" --color=$(COLOR)
.PHONY : unittests/CMakeFiles/unittest_ypipe.dir/depend

