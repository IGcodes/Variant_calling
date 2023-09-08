#!/usr/bin/bash
#PBS -l nodes=1:ppn=3

# In the snipped above describes the number of nodes that will be used to run the program on a batch processing system.
# "nodes" defines the number of nodes, and "ppn" defines the number of threads/processes.

# Here we are locating the directory with data that we are working on and the results will be saved.
# "<absolute/path/to/the/working/directory>" part to the absoulute path to your data files
cd <absolute/path/to/the/working/directory>

# Here we are setting the background for conda environment activation. This will retrieve details of the packages installed on Miniconda.
eval "$(conda shell.bash hook)"

# activating a conda environment. The name of the environment could be anything.
conda activate <name/of/the/conda/environment>

# This shell script is specifically written to download fastq files from NCBI repository (data bases like SRA and ENA).
# The function "fastq-dump" will automatically connect with the NCBI data repository and will download the fastq files with the corresponding ERR or SRR identifiers
# The flag "--split-3" allows the function "fastq-dump" to download both read files of the corresponding sample if it was sequenced using the paired-end reads method.
# In the for loop, the variable "i" will hold the SRR or ERR identifiers one at a time saved in text file named "ERRIDs.txt" for each iteration
# The "ERRIDs.txt" text file should contain the ERR or SRR identifiers line by line. * No headings
for i in `cat ERRIDs.txt`
do fastq-dump --split-3 $i
done
