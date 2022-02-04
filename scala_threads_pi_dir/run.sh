#!/usr/bin/env bash
set -e
make
scala calcpi.pi $1 $2
