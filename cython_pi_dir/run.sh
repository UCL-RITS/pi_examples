#!/usr/bin/env bash

./setup.py build_ext --inplace

python -c 'import cython_pi'
