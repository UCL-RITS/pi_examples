#!/usr/bin/env bash

THREADS=${OMP_NUM_THREADS:-1}

julia -p $THREADS pi.jl $*
