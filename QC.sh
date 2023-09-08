#!/usr/bin/bash
#PBS -l nodes=1:ppn=5

# locating the directory with data
cd /data/gunarathnai/AG1000/gambiaeENAIds

# setting background for conda environment activation
eval "$(conda shell.bash hook)"

# activating 'bioinfo' environment with conda
conda activate bioinfo

# quality check
fastqc -t 5 *.fastq