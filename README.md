# Special note
This repository contains the shell script files of the workflow based on bcftools and samtools used for variant calling from fastq files. It is important to note that these shell scripts contain elements that are specifically written to manage the environment of the Baylor Kodiak server. All the main steps are written in separate shell scripts for the ease of interoperability between this workflow and others.

# Variant calling from fastq files using bcftools and samtools
Variant calling is the process of identifying genetic variants from sequencing data. BCFtools is a set of utilities that can be used to perform variant calling and manipulate variant calls in the Variant Call Format (VCF) and its binary counterpart BCF¹. A typical variant calling workflow based on BCFtools consists of the following steps:

 

- Align the sequencing reads to a reference genome using a tool such as BWA or Bowtie. This will produce a SAM or BAM file that contains the mapping information for each read.

- Sort and index the SAM or BAM file using samtools, which is a companion tool to BCFtools. This will facilitate the subsequent analysis and compression of the file.

- Call variants from the sorted and indexed BAM file using bcftools mpileup and bcftools call commands. The mpileup command generates genotype likelihoods for each position in the genome, while the call command applies various filters and heuristics to produce a VCF or BCF file that contains the variant calls and annotations.

- Filter the VCF or BCF file using bcftools filter command. The filter command can apply various criteria to select or exclude variants based on their quality, frequency, effect, or other attributes.

- Perform downstream analysis on the normalized and filtered VCF or BCF file using bcftools view, bcftools stats, bcftools query, bcftools roh, bcftools norm, or other commands. These commands can be used to visualize, summarize, query, phase, normalize, or compare the variants in different ways (This part is not included in this general pipeline).

# Generating Consensus Fasta Sequences with bcftools consensus

bcftools consensus is a command-line tool used to create a consensus FASTA sequence from a reference genome and a VCF (Variant Call Format) file containing genomic variants. The process starts with a reference genome in FASTA format. This is your "base" sequence that will be modified by applying the variants from the VCF file. These variants represent differences between the reference genome and the sequences you are interested in. Generating the Consensus Sequence: Use bcftools consensus to apply the variants from the VCF file to the reference genome, creating a new FASTA sequence that reflects these changes.

# Generating Phylogenetic Trees with RAxML

RAxML (Randomized Axelerated Maximum Likelihood) is a powerful software package for phylogenetic analysis, commonly used to construct phylogenetic trees from sequence data. Here's a brief guide on how to use RAxML for this purpose: 
Prepare a FASTA file containing the sequences you want to analyze. This could be DNA, RNA, or protein sequences. Common models for DNA sequences include GTR (General Time Reversible) with various rate heterogeneity models (like Gamma distribution). You can use RAxML's raxmlHPC with a specific model option.


For more details and examples on how to use BCFtools for variant calling and analysis, please refer to the official documentation⁵.

 

Source: Conversation with Bing, 9/8/2023

(1) GitHub - samtools/bcftools: This is the official development repository .... https://github.com/samtools/bcftools.

(2) undefined. http://samtools.github.io/bcftools/howtos/install.html.

(3) bcftools. http://www.htslib.org/doc/1.1/bcftools.html.

(4) Bcftools :: Anaconda.org. https://anaconda.org/bioconda/bcftools.

(5) SAMtools/BCFtools/HTSlib - Downloads. http://www.htslib.org/download/.

(6) http://samtools.github.io/bcftools/howtos/publications.html.

(7) https://doi.org/10.1093/gigascience/giab008.
