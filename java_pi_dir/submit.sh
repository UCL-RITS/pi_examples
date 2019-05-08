#!/bin/bash -l

#$ -N JDKbench
#$ -l h_rt 00:20:00
#$ -l mem=4G

#$ -cwd

echo > timing.csv

for a in `module avail java -t 2>&1 | grep java`
do
  make clean
  module load $a
  make
  for b in `seq -w 10`
  do
    t=`java pi | grep Time | awk '{print $3}'`
    echo "${a}|${b}|${t}" >> timing.csv
  done
  module remove $a
done
