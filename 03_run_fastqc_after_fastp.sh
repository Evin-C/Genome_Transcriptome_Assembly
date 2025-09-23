#!/usr/bin/env bash

#SBATCH --job-name=fastqc_after_fastp # Job name
#SBATCH --output=fastqc_%j.out        # Standard output log
#SBATCH --error=fastqc_%j.err         # Standard input log
#SBATCH --cpus-per-task=4             
#SBATCH --mem=40G                     # 40G memory allocation
#SBATCH --time=01:00:00
#SBATCH --partition=pibu_el8

# Define USER variable
USER="ecapan"

# Define Working Directory
WORKDIR="/data/users/${USER}/assembly_annotation_course/Genome_Transcriptome_Assembly"

# Define Anz-0 (Accession) and Reference Files' Directory paths
FASTP_DIR="${WORKDIR}/fastp_Results"
CONTAINER="/containers/apptainer/fastqc-0.12.1.sif"
OUTPUT_DIR="${WORKDIR}/FastQC_after_fastp_Results"

# Create the output directory if it doesn't already exist:
mkdir -p ${OUTPUT_DIR}

# Run FastQC on Anz-0 file and Reference files
apptainer exec --bind ${WORKDIR} ${CONTAINER} fastqc ${FASTP_DIR}/*.fastq.gz -o ${OUTPUT_DIR} -t ${SLURM_CPUS_PER_TASK}
    # CPU threads per task is 4 (-t ${SLURM_CPUS_PER_TASK})
    