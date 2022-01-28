#!/usr/bin/env bash

if [[ -z "${JULIA_NUM_THREADS}" ]]; then
    export JULIA_NUM_THREADS="${OMP_NUM_THREADS:-1}"
fi

# This makes sure you load the right packages to run the example
julia -e "using Pkg; Pkg.update(); Pkg.activate(\"${PWD}\"); Pkg.instantiate()"

julia --project="${PWD}" pi_floops.jl "${@}"
