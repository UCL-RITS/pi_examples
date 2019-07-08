#!/usr/bin/env bash

make
java pi $1 $2 ${OMP_NUM_THREADS}
