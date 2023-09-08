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

# The for loop will iterate through all the sorted bam files in the directory specified in line 9
# For each file the instruction in for loop body will generate an output file which contains only the regions specified within the " marks.
# In line 22 "NC_004331.3:1878875-1880194" denotes the region to extract which follows the format - "<chromosomenumber/id>:<begining>-<end>"
for i in `ls *sorted.bam`
do 
samtools view -b $i "NC_004331.3:1878875-1880194" > $i.output.bam
done
