#!/usr/bin/env bash

# Note we want to strip out compiler messages, sart with %
gdl -arg "$1" < pi.pro | grep -v "^%"

