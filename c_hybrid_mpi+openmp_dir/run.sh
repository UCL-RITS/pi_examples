#!/usr/bin/env bash

make clean
make
mpirun ./hybrid_pi "${@}"
