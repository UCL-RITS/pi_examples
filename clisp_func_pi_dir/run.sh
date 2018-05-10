#!/usr/bin/env bash

# Detect which if any Common LISP implementation we have:
which sbcl > /dev/null 2>&1
sbclsuccess=$?

if [ "$sbclsuccess" == "0" ]; then
  PI_ARG=$1 make -f Makefile.sbcl
else
  echo "No Common LISP implementation found."
  exit 1
fi
