#!/usr/bin/env bash

# See if d8 is in our path:
which d8 > /dev/null 2>&1
d8success=$?

# See if node.js is in our path:
which nodejs > /dev/null 2>&1
nodesuccess=$?


if [ "$d8success" == "0" ]; then
  d8 rund8.js $1
elif [ "$nodesuccess" == "0" ]; then
  nodejs runnode.js $1
else
  echo "No JavaScript Interpreter found."
  exit 1
fi