cmake_minimum_required(VERSION 3.10)
project(P2_Optim C)

set(CMAKE_C_STANDARD 11)

# Desactiva cualquier optimización del sistema de build
set(CMAKE_C_FLAGS "")
set(CMAKE_C_FLAGS_DEBUG "")
set(CMAKE_C_FLAGS_RELEASE "")
set(CMAKE_C_FLAGS_RELWITHDEBINFO "")
set(CMAKE_C_FLAGS_MINSIZEREL "")

# Fuerza -O0 para este ejecutable
add_executable(P2_Optim test_sin_opt.c)
target_compile_options(P2_Optim PRIVATE -O0)

# Enlaza con la librería matemática
target_link_libraries(P2_Optim m)
