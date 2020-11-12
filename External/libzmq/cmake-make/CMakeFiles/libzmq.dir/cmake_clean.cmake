file(REMOVE_RECURSE
  "lib/libzmq.5.2.3.dylib"
  "lib/libzmq.5.dylib"
  "lib/libzmq.dylib"
  "lib/libzmq.pdb"
)

# Per-language clean rules from dependency scanning.
foreach(lang C CXX)
  include(CMakeFiles/libzmq.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
