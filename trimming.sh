#!/usr/bin/bash
#PBS -l nodes=1:ppn=20

# locating the directory with data
cd /data/gunarathnai/Babatunde

# setting background for conda environment activation
eval "$(conda shell.bash hook)"

# activating 'bioinfo' environment with conda
conda activate bioinfo

# trimming step

for i in `cat paired_ERRIDs.txt`
do
trimmomatic PE -threads 20 ${i}_1.fastq ${i}_2.fastq ${i}_forward_paired.fq.gz ${i}_forward_unpaired.fq.gz ${i}_reverse_paired.fq.gz ${i}_reverse_unpaired.fq.gz ILLUMINACLIP:TruSeq3-PE-2.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
done


#Remove Illumina adapters provided in the TruSeq3-PE.fa file (provided).  Initially 
#Trimmomatic will look for seed matches (16 bases) allowing maximally 2 
#mismatches. These seeds will be extended and clipped if in the case of paired end 
#reads a score of 30 is reached (about 50 bases), or in the case of single ended reads a 
#score of 10, (about 17 bases). 
#Remove leading low quality or N bases (below quality 3) 
#Remove trailing low quality or N bases (below quality 3) 
#Scan the read with a 4-base wide sliding window, cutting when the average quality per 
#base drops below 15 
#Drop reads which are less than 36 bases long after these steps