cmake_minimum_required(VERSION 3.20)
project(satellite_sim VERSION 0.4.0 LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
add_library(satellite_core
  src/core/cpu.cpp src/core/assembler.cpp src/core/radio_link.cpp
  src/core/spacecraft.cpp src/core/ground_station.cpp
  src/core/fleet.cpp src/core/mission_bus.cpp
  src/core/memory.cpp src/core/patch.cpp src/core/update.cpp)
target_include_directories(satellite_core PUBLIC include)
add_executable(satellite_sim src/main.cpp)
target_link_libraries(satellite_sim PRIVATE satellite_core)
enable_testing()
add_executable(satellite_tests tests/test_main.cpp)
target_link_libraries(satellite_tests PRIVATE satellite_core)
add_test(NAME satellite_tests COMMAND satellite_tests)
add_executable(memory_tests tests/test_memory.cpp)
target_link_libraries(memory_tests PRIVATE satellite_core)
add_test(NAME memory_tests COMMAND memory_tests)
add_executable(update_tests tests/test_update.cpp)
target_link_libraries(update_tests PRIVATE satellite_core)
add_test(NAME update_tests COMMAND update_tests)
