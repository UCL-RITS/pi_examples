#!/usr/bin/env bash

make clean
make
mpirun ./hybrid-pi
