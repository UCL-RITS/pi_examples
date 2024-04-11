#!/usr/bin/env bash

# This version of run.sh uses Ubuntu's wrappers rather than the clojure-tools ones.

CLASSPATH=src clojure run.clj $1
