#!/usr/bin/bash
#PBS -l nodes=1:ppn=15

# locating the directory with data
cd /data/gunarathnai/AG1000/pfENAIds/fqfiles/

# setting background for conda environment activation
eval "$(conda shell.bash hook)"

# activating 'bioinfo' environment with conda
conda activate bioinfo

for i in `cat Ethiopia_2013.txt`
do
bowtie2 -x ../PfRef/PFIX -1 ${i}_1.fastq -2 ${i}_2.fastq --no-unal -p 15 | samtools view -bS -o ${i}_Ethiopia_2013.bam
done