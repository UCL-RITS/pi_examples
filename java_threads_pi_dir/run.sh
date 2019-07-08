#!/usr/bin/env bash

steps=${1:-500000000}
threads=${2:-${OMP_NUM_THREADS}}
make
java pi $steps $threads
