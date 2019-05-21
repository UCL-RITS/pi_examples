cmake_minimum_required (VERSION 2.6)
project (pi, Fortran)
set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -O2")
add_executable(pi pi.f90)
