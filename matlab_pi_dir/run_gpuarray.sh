#!/usr/bin/env bash

# Work out whether to run matlab (preferred) or octave.
which matlab > /dev/null 2>&1
mlsuccess=$?

# Default to not setting n
n=""

# If we have an argument, set n=$1
if [ $# == 1 ]; then
  n="n=${1};"
fi

if [ "$mlsuccess" == "0" ] ; then
  matlab -singleCompThread -nodisplay -nodesktop -nosplash -nojvm -r "${n}run('calcpi_gpuarray.m');quit;"
else
  echo "No Matlab interpreter found."
fi
