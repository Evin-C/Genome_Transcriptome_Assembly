#!/usr/bin/env bash

#SBATCH --job-name=get_data           # Job name
#SBATCH --output=get_data_%j.out      # Standard output log
#SBATCH --error=get_data_%j.err       # Standard input log
#SBATCH --cpus-per-task=1             
#SBATCH --mem=1G                      # 1G memory allocation
#SBATCH --time=00:05:00
#SBATCH --partition=pibu_el8

# Define USER variable
USER="ecapan"

# Define Working Directory
WORKDIR="/data/users/${USER}/assembly_annotation_course/Genome_Transcriptome_Assembly"

# Go to the working directory where links should be created
cd ${WORKDIR}

# Create symbolic links to the datasets
ln -s /data/courses/assembly-annotation-course/raw_data/Anz-0 .
ln -s /data/courses/assembly-annotation-course/raw_data/RNAseq_Sha .