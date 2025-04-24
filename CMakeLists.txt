cmake_minimum_required(VERSION 3.30)
project(P2_Optim C)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O0")

add_executable(P2_Optim main.c)
target_link_libraries(P2_Optim m)

