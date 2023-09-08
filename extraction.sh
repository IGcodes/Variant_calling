#!/usr/bin/bash
#PBS -l nodes=1:ppn=15

# locating the directory with data
cd /data/gunarathnai/AG1000/pfENAIds/BamFiles

# setting background for conda environment activation
eval "$(conda shell.bash hook)"

# activating 'bioinfo' environment with conda
conda activate bioinfo

# Sorting and indexing
for i in `ls *sorted.bam`
do 
samtools view -b $i "NC_004331.3:1878875-1880194" > $i.pfs47.bam
done