#!/usr/bin/bash
#PBS -l nodes=1:ppn=15

# locating the directory with data
cd /data/gunarathnai/AG1000/gambiaeENAIds

# setting background for conda environment activation
eval "$(conda shell.bash hook)"

# activating 'bioinfo' environment with conda
conda activate bioinfo

for i in `cat Burkina_Faso_2004.txt`
do 
samtools sort $i.bam -o $i.Burkina_Faso_2004.bam -@ 15
samtools index $i.Burkina_Faso_2004.bam -@ 15
done