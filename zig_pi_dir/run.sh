#!/bin/bash

set -e

zig build
zig-out/bin/zig_pi_dir ${1}
