#!/usr/bin/env bash

num_threads=${1:-1000000}
com="ns:${num_threads}$ batchload(\"pi.mac\")$"
maxima --very-quiet -r="$com"
