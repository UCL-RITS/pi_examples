cmake_minimum_required (VERSION 2.6)
project (pi, Fortran)

# Various versions of the OpenMP.cmake throw errors related to CMP0012
cmake_policy(SET CMP0012 OLD)

find_package(OpenMP)
if (OPENMP_FOUND)
  message("OpenMP detected.")
  set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} ${OpenMP_Fortran_FLAGS}")
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${OpenMP_Fortran_FLAGS}")
else ()
  message("OpenMP not available in this compiler.")

endif ()

add_executable(pi pi.f90)
