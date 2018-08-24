#!/usr/bin/env bash

# Work out whether to run matlab (preferred) or octave.
which matlab > /dev/null 2>&1
mlsuccess=$?
which octave > /dev/null 2>&1
ocsuccess=$?

# Default to not setting n
n=""

# If we have an argument, set n=$1
if [ $# == 1 ]; then
  n="n=${1};"
fi

if [ "$mlsuccess" == "0" ] ; then
#  matlab -nodisplay -nodesktop -nosplash -nojvm -r "${n}run('calcpi.m');quit;"
  matlab -singleCompThread -nodisplay -nodesktop -nosplash -nojvm -r "${n}run('calcpi.m');quit;"
elif [ "$ocsuccess" == "0" ] ; then
  octave --no-gui --silent --eval "maxNumCompThreads=1;${n}run('calcpi.m');"
else
  echo "No Matlab interpreter found."
fi
