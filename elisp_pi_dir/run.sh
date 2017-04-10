#!/usr/bin/env bash

# Compile to byte code
make -s

# Run
PI_ARG=$1 make run

