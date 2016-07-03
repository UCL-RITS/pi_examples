#!/usr/bin/env bash

make clean
make
./pi +RTS -K1600000000 -RTS
