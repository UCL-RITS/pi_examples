#!/usr/bin/env bash

SLICES=${1:-1000000}

echo load \"pi.logo repeat 1 [picalc ${SLICES}] | ucblogo
