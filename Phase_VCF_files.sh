#!/usr/bin/bash
#PBS -l nodes=1:ppn=4

# locating the directory with data
cd /data/gunarathnai/AG1000/gambiaeENAIds/trimmed_bams/P47Rec

# setting background for conda environment activation
eval "$(conda shell.bash hook)"

# activating 'newbio' environment with conda
conda activate newbio

# Setting input
VCF=all_P47Rec.biallelic.vcf.gz 

# Querying and indexing
bcftools query -l $VCF | wc -l
bcftools index -n $VCF

# Setting output
OUTPUT=${VCF}_phased

# Phasing vcf file
shapeit --input-vcf $VCF -O $OUTPUT --window 0.1 -T 4 --force

# converting to vcf
shapeit -convert \
--input-haps ${OUTPUT} \
--output-vcf ${OUTPUT}.vcf

# indexing and bgzipping
bgzip ${OUTPUT}.vcf
bcftools index ${OUTPUT}.vcf.gz