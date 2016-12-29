#!/usr/bin/env bash

make pi.exe
make pi.class

mono pi.exe $1

java pi $1
