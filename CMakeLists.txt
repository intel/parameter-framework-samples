# has been tested on 2.8 only - might work on older versions
cmake_minimum_required(VERSION 2.8.3)

#TODO force -DCMAKE_PREFIX_PATH=
#TODO: make install target instead of when running cmake

# linking policy (see cmake --help-policy CMP0003)
if(COMMAND cmake_policy)
  cmake_policy(SET CMP0003 NEW)
endif(COMMAND cmake_policy)

project(parameter-framework-samples)

add_subdirectory(example-music)
