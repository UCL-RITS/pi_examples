#!/usr/bin/env bash

# Put first arg at the top of the stack and run.
gforth -e "$1" pi.fs
