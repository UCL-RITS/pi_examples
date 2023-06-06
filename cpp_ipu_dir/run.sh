#!/usr/bin/env bash

make clean
make
export POPLAR_RUNTIME_OPTIONS='{"target.hostSyncTimeout":"20"}'
./pi
