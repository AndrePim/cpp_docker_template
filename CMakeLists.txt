cmake_minimum_required(VERSION 3.16)
project(CppDockerTemplate LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_library(utils src/utils.cpp include/utils.hpp)
target_include_directories(utils PUBLIC include)

add_executable(app src/main.cpp)
target_link_libraries(app PRIVATE utils)

add_executable(tests tests/test_main.cpp)
target_link_libraries(tests PRIVATE utils)

enable_testing()
add_test(NAME MyTests COMMAND tests)
