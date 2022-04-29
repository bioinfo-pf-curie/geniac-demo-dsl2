cmake_minimum_required(VERSION 3.10.2)
project(helloWorld LANGUAGES CXX)
project (helloWorld)

add_executable(helloWorld main.cpp)
install(TARGETS helloWorld DESTINATION ${CMAKE_INSTALL_PREFIX})
