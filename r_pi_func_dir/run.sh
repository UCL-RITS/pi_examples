#!/usr/bin/env bash

export R_ENABLE_JIT=3
export R_COMPILE_PACKAGES=TRUE

./pi.r $1
