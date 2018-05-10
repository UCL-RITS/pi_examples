#!/usr/bin/env bash

SLICES=${1:-1000000}

# Note we do a single iteration repeat loop to stop picalc n getting mangled.
echo load \"pi.logo repeat 1 [picalc ${SLICES}] | ucblogo
