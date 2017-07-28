#!/usr/bin/env bash

# Detect which if any Common LISP implementation we have:
which sbcl > /dev/null 2>&1
sbclsuccess=$?

which clisp > /dev/null 2>&1
clispsuccess=$?

if [ "$sbclsuccess" == "0" ]; then
  sbcl --script pi.cl $1
elif [ "$clispsuccess" == "0" ]; then 
  PI_ARG=$1 make run
else
  echo "No Common LISP implementation found."
  exit 1
fi
