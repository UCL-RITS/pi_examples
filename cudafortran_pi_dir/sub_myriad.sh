#!/bin/bash -l

#$ -l gpu=1
#$ -l h_rt=2:0:0
#$ -cwd
#$ -l mem=12G

module purge
module load rcps-core
module load personal-modules
module load compilers/nvhpc

hostname

nvidia-smi
pgaccelinfo 

make clean
make

./pi
