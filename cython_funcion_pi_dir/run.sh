#!/usr/bin/env bash

./setup.py build_ext --inplace

python3.6 -c 'import cython_pi'
