#!/usr/bin/env bash

num_steps=${1:-10000000}

code=`cat pi.js`
echo "$code; calcpi($num_steps);" | nodejs

