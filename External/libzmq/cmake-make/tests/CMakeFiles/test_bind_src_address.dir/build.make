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
include tests/CMakeFiles/test_bind_src_address.dir/depend.make

# Include the progress variables for this target.
include tests/CMakeFiles/test_bind_src_address.dir/progress.make

# Include the compile flags for this target's objects.
include tests/CMakeFiles/test_bind_src_address.dir/flags.make

tests/CMakeFiles/test_bind_src_address.dir/test_bind_src_address.cpp.o: tests/CMakeFiles/test_bind_src_address.dir/flags.make
tests/CMakeFiles/test_bind_src_address.dir/test_bind_src_address.cpp.o: ../tests/test_bind_src_address.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/cmake-make/CMakeFiles" --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object tests/CMakeFiles/test_bind_src_address.dir/test_bind_src_address.cpp.o"
	cd "/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/cmake-make/tests" && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/test_bind_src_address.dir/test_bind_src_address.cpp.o -c "/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/tests/test_bind_src_address.cpp"

tests/CMakeFiles/test_bind_src_address.dir/test_bind_src_address.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/test_bind_src_address.dir/test_bind_src_address.cpp.i"
	cd "/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/cmake-make/tests" && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E "/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/tests/test_bind_src_address.cpp" > CMakeFiles/test_bind_src_address.dir/test_bind_src_address.cpp.i

tests/CMakeFiles/test_bind_src_address.dir/test_bind_src_address.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/test_bind_src_address.dir/test_bind_src_address.cpp.s"
	cd "/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/cmake-make/tests" && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S "/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/tests/test_bind_src_address.cpp" -o CMakeFiles/test_bind_src_address.dir/test_bind_src_address.cpp.s

# Object files for target test_bind_src_address
test_bind_src_address_OBJECTS = \
"CMakeFiles/test_bind_src_address.dir/test_bind_src_address.cpp.o"

# External object files for target test_bind_src_address
test_bind_src_address_EXTERNAL_OBJECTS =

bin/test_bind_src_address: tests/CMakeFiles/test_bind_src_address.dir/test_bind_src_address.cpp.o
bin/test_bind_src_address: tests/CMakeFiles/test_bind_src_address.dir/build.make
bin/test_bind_src_address: lib/libtestutil.a
bin/test_bind_src_address: lib/libzmq.5.2.3.dylib
bin/test_bind_src_address: /usr/local/Cellar/libsodium/1.0.18_1/lib/libsodium.dylib
bin/test_bind_src_address: lib/libunity.a
bin/test_bind_src_address: tests/CMakeFiles/test_bind_src_address.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir="/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/cmake-make/CMakeFiles" --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable ../bin/test_bind_src_address"
	cd "/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/cmake-make/tests" && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/test_bind_src_address.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
tests/CMakeFiles/test_bind_src_address.dir/build: bin/test_bind_src_address

.PHONY : tests/CMakeFiles/test_bind_src_address.dir/build

tests/CMakeFiles/test_bind_src_address.dir/clean:
	cd "/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/cmake-make/tests" && $(CMAKE_COMMAND) -P CMakeFiles/test_bind_src_address.dir/cmake_clean.cmake
.PHONY : tests/CMakeFiles/test_bind_src_address.dir/clean

tests/CMakeFiles/test_bind_src_address.dir/depend:
	cd "/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/cmake-make" && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" "/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq" "/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/tests" "/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/cmake-make" "/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/cmake-make/tests" "/Users/daniel/Work/XCode/VJ apps/ArbutusEngine/External/libzmq/cmake-make/tests/CMakeFiles/test_bind_src_address.dir/DependInfo.cmake" --color=$(COLOR)
.PHONY : tests/CMakeFiles/test_bind_src_address.dir/depend

