#!/usr/bin/env bash

# Detect which if any Common LISP implementation we have:
which sbcl > /dev/null 2>&1
sbclsuccess=$?

which ecl > /dev/null 2>&1
eclsuccess=$?

which gcl > /dev/null 2>&1
gclsuccess=$?

which clisp > /dev/null 2>&1
clispsuccess=$?

if [ "$sbclsuccess" == "0" ]; then
  sbcl --script pi.cl $1
elif [ "$eclsuccess" == "0" ]; then 
  make clean && PI_ARG=$1 make ecl
elif [ "$gclsuccess" == "0" ]; then 
  gcl -f pi.cl $1
elif [ "$clispsuccess" == "0" ]; then 
  make clean && PI_ARG=$1 make clisp
else
  echo "No Common LISP implementation found."
  exit 1
fi
