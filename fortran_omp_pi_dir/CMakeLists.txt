cmake_minimum_required (VERSION 2.6)
project (pi)
enable_language(Fortran)

find_package(OpenMP)
if (OPENMP_FOUND)
  set(CMAKE_FORTRAN_FLAGS "${CMAKE_FORTRAN_FLAGS} ${OpenMP_Fortran_FLAGS}")
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${OpenMP_Fortran_FLAGS}")
else ()
  message("OpenMP not available in this compiler.")

endif ()


add_executable(pi pi.f90)
