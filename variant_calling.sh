#!/usr/bin/bash
#PBS -l nodes=1:ppn=10

# locating the directory with data
cd /data/gunarathnai/AG1000/pfENAIds/Pfs47

# setting background for conda environment activation
eval "$(conda shell.bash hook)"

# activating 'bio2' environment with conda
conda activate bio2

# sorting and indexing Ethiopian bam files
# sorting bam files
for j in `ls *Ethiopia*.pfs47.bam`
do

# Sorting and indexing bam files
samtools sort $j -o $j.sorted.bam -@ 10
samtools index $j.sorted.bam -@ 10

done

# call variants
bcftools mpileup -Ou -f ../PfRef/PF3D7.fna *.sorted.bam | bcftools call -mv -Oz -o all_Pfs47.calls.vcf.gz
bcftools index all_Pfs47.calls.vcf.gz

# normalize indels
bcftools norm -f ../PfRef/PF3D7.fna all_Pfs47.calls.vcf.gz -Ob -o all_Pfs47.calls.norm.bcf

# filter adjacent indels within 5bp
bcftools filter --IndelGap 5 -e 'QUAL<30 || DP<10' all_Pfs47.calls.norm.bcf -Ov -o all_Pfs47.calls.norm.flt-indels.vcf

# bgzipping the normalized and filtered calls
bgzip all_Pfs47.calls.norm.flt-indels.vcf

# Indexing filtered calls
bcftools index all_Pfs47.calls.norm.flt-indels.vcf.gz
