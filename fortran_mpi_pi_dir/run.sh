#!/usr/bin/env bash

make clean && make
mpirun $2 $3 $4 $5 ./pi $1
