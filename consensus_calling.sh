#!/usr/bin/bash
#PBS -l nodes=1:ppn=5

# locating the directory with data
cd /data/gunarathnai/AG1000/pfENAIds/Pfs47

# setting background for conda environment activation
eval "$(conda shell.bash hook)"

# activating 'bio2' environment with conda
conda activate bio2

# sorting bam files
#for j in `ls *.bam`
#do

# Sorting and indexing bam files
#samtools sort $j -o $j.sorted.bam -@ 10
#samtools index $j.sorted.bam -@ 10

#done

# looping over sorted bam files for consensus calling
for i in `ls *.sorted.bam`
do

# call variants
bcftools mpileup -Ou -f ../PfRef/PF3D7.fna ${i} | bcftools call -mv --ploidy 1 -Oz -o ${i}.calls.vcf.gz
bcftools index ${i}.calls.vcf.gz

# normalize indels
bcftools norm -f ../PfRef/PF3D7.fna ${i}.calls.vcf.gz -Ob -o ${i}.calls.norm.bcf

# filter adjacent indels within 5bp
bcftools filter --IndelGap 5 -e 'QUAL<30 || DP<10' ${i}.calls.norm.bcf -Ov -o ${i}.calls.norm.flt-indels.vcf

# bgzipping the normalized and filtered calls
bgzip ${i}.calls.norm.flt-indels.vcf

# Indexing filtered calls
bcftools index ${i}.calls.norm.flt-indels.vcf.gz

# Extracting consensus coding sequences
samtools faidx ../PfRef/PF3D7.fna NC_004331.3:1878875-1880194 | bcftools consensus ${i}.calls.norm.flt-indels.vcf.gz > ${i}.calls.norm.flt-indels.vcf.gz.cds.fa

done
