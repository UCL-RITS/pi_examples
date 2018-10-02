#!/usr/bin/env bash

make clean
make
mpirun ./mpi_pi
