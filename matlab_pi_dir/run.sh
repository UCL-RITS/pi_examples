#!/usr/bin/env bash

# Default to not setting n
n=""

# If we have an argument, set n=$1
if [ $# == 1 ]; then
  n="n=${1};"
fi

# Run Matlab.
matlab -nodisplay -nodesktop -nosplash -nojvm -r "${n}run('calcpi.m');quit;"
