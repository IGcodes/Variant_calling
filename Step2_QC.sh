#!/usr/bin/bash
#PBS -l nodes=1:ppn=5

# In the snipped above describes the number of nodes that will be used to run the program on a batch processing system.
# "nodes" defines the number of nodes, and "ppn" defines the number of threads/processes.

# Here we are locating the directory with data that we are working on and the results will be saved.
# "<absolute/path/to/the/working/directory>" part to the absoulute path to your data files
cd <absolute/path/to/the/working/directory>

# Here we are setting the background for conda environment activation. This will retrieve details of the packages installed on Miniconda.
eval "$(conda shell.bash hook)"

# activating a conda environment. The name of the environment could be anything.
conda activate <name/of/the/conda/environment>

# This instruction will generate ther QC reports for all the "fastq" files in the directory specified in line 8
# For more details on "fastqc" function visit - https://www.bioinformatics.babraham.ac.uk/projects/fastqc/
# "-t" flag defines the number of threads that will be used in the quality checking process
# "*.fastq" retrieves all the fastq files in the directory specified in line 8
# The resulting QC reports will be saved in HTML format and can be opened using any supporting browser
fastqc -t 5 *.fastq
