#!/usr/bin/env bash

#SBATCH --job-name=fastqc             # Job name
#SBATCH --output=fastqc_%j.out        # Standard output log
#SBATCH --error=fastqc_%j.err         # Standard input log
#SBATCH --cpus-per-task=1             
#SBATCH --mem=40G                     # 40G memory allocation
#SBATCH --time=01:00:00
#SBATCH --partition=pibu_el8

# Define USER variable
USER="ecapan"

# Define Working Directory
WORKDIR="/data/users/${USER}/assembly_annotation_course/Genome_Transcriptome_Assembly"

# Define Anz-0 (Accession), Reference, Container, and Output Directory paths
ANZ_DIR="${WORKDIR}/Anz-0"
REFERENCE_DIR="${WORKDIR}/RNAseq_Sha"
CONTAINER="/containers/apptainer/fastqc-0.12.1.sif"
OUTPUT_DIR="${WORKDIR}/FastQC_Results"

# Create the output directory if it doesn't already exist:
mkdir -p ${OUTPUT_DIR}

# Run FastQC on Anz-0 file(s)
apptainer exec --bind ${ANZ_DIR} ${CONTAINER} fastqc ${ANZ_DIR}/*.fastq.gz -o ${OUTPUT_DIR} -t 1
    # CPU threads per task is 1 (-t 1)

# Run FastQC on Reference file(s)
apptainer exec --bind ${ANZ_DIR} ${CONTAINER} fastqc ${REFERENCE_DIR}/*.fastq.gz -o ${OUTPUT_DIR} -t 1
