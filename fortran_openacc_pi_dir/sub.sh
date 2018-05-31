#!/bin/bash -l

#$ -l gpu=1
#$ -l h_rt=2:0:0
#$ -cwd

module purge
module load rcps-core
module load compilers/gnu
module load cuda/8.0.61-patch2/gnu-4.9.2
#module load cuda/7.5.18/gnu-4.9.2
module remove compilers/gnu
module load compilers/pgi/2017.3

hostname

nvidia-smi
pgaccelinfo 

make clean
make pgi

./pi
