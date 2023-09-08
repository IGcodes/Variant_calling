#!/usr/bin/bash
#PBS -l nodes=1:ppn=15

# In the snipped above describes the number of nodes that will be used to run the program on a batch processing system.
# "nodes" defines the number of nodes, and "ppn" defines the number of threads/processes.

# Here we are locating the directory with data that we are working on and the results will be saved.
# "<absolute/path/to/the/working/directory>" part to the absolute path to your data files
cd <absolute/path/to/the/working/directory>

# Here we are setting the background for conda environment activation. This will retrieve details of the packages installed on Miniconda.
eval "$(conda shell.bash hook)"

# activating a conda environment. The name of the environment could be anything.
conda activate <name/of/the/conda/environment>

# For this shell script to work the fastq files should be named in a format that matches to "
# This "for loop" reads the text file "ERRIDs.txt" line by line and feeds the ERRIDs to the body/set of instruction enclosed within the loop.
# "bowtie2" aligner is aligning the paired-end reads to the reference genome provided under the flag "-x"
# Both forward and reverse pair of read files (usually named as ERR..._1.fastq and ERR..._2.fastq) will be defined using the -1 and -2 flags.
# The variable call "${i}" will be concatenated to the string "}_1.fastq" to access the read files saved in fastq format.
# The reads that failed to align will be suppressed of producing SAM records by --no-unal flag.
# The -p defines the number of threads will be allocated for this process and this should match with the number defined in line 2.
# Output of the "bowtie2" will be in .sam format and it is a cumbersome file. Therefore we convert it to .bam format using "samtools".
# "|" sign pipes the output of the bowtie2 output to the samtools.
for i in `cat ERRIDs.txt`
do
bowtie2 -x <path/to/the/reference_genome> -1 ${i}_1.fastq -2 ${i}_2.fastq --no-unal -p 15 | samtools view -bS -o ${i}_output.bam
done
