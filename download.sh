#!/usr/bin/bash
#PBS -l nodes=1:ppn=3

# locating the directory with data
cd /data/gunarathnai/AG1000/pfENAIds

# setting background for conda environment activation
eval "$(conda shell.bash hook)"

# activating 'bioinfo' environment with conda
conda activate bioinfo
for pfc in `ls *.txt`; do
for i in `cat ${pfc}`
do fastq-dump --split-3 $i
done
done