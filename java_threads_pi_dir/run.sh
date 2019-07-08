#!/usr/bin/env bash

make
java pi $1 ${OMP_NUM_THREADS} $2
