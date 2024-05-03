#!/usr/bin/bash
#PBS -l nodes=1:ppn=10

# locating the directory with data
cd /data/gunarathnai/AG1000/gambiaeENAIds/P47Rec/P47Rec_phylogenetics

# setting background for conda environment activation
eval "$(conda shell.bash hook)"

# activating 'newbio' environment with conda
conda activate newbio

# running raxmlHPC to generate the tree files
raxmlHPC-PTHREADS -T 10 -f a -x 95538 -p 95538 -N 1000 -m GTRGAMMA -k -O -n P47Rec.tre -s "P47Rec_bothHaplotypes_CDS_WRefSeq_CCaligned.fasta"