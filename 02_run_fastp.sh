#!/usr/bin/env bash

#SBATCH --job-name=fastp              # Job name
#SBATCH --output=fastp_%j.out         # Standard output log
#SBATCH --error=fastp_%j.err          # Standard input log
#SBATCH --cpus-per-task=4             
#SBATCH --mem=40G                     # 40G memory allocation
#SBATCH --time=01:00:00
#SBATCH --partition=pibu_el8

# Define USER variable
USER="ecapan"

# Define Working Directory
WORKDIR="/data/users/${USER}/assembly_annotation_course/Genome_Transcriptome_Assembly"

# Define Anz-0 (Accession, single-end), Reference (paired-end), Container, and Output Directory paths
ANZ_DIR="${WORKDIR}/Anz-0"
ANZ_FILE=$(ls ${ANZ_DIR}/*.fastq.gz | head -n1) # Accession File
REFERENCE_DIR="${WORKDIR}/RNAseq_Sha"
REF_R1=$(ls ${REFERENCE_DIR}/*_1.fastq.gz | head -n1)
REF_R2=$(ls ${REFERENCE_DIR}/*_2.fastq.gz | head -n1)
CONTAINER="/containers/apptainer/fastp_0.24.1.sif"
OUTPUT_DIR="${WORKDIR}/fastp_Results"

# Create the output directory if it does not already exist
mkdir -p ${OUTPUT_DIR}

# Run fastp on Anz-0 single-end file (no filtering)
apptainer exec --bind ${WORKDIR} ${CONTAINER} fastp -i ${ANZ_FILE} -o ${OUTPUT_DIR}/$(basename ${ANZ_FILE} .fastq.gz).unfiltered.fastq.gz \
-h ${OUTPUT_DIR}/$(basename ${ANZ_FILE} .fastq.gz)_report.html -t ${SLURM_CPUS_PER_TASK} -A -Q -L

# Run fastp on Reference paired-end files
apptainer exec --bind ${WORKDIR} ${CONTAINER} fastp -i ${REF_R1} -I ${REF_R2} \
-o ${OUTPUT_DIR}/$(basename ${REF_R1} .fastq.gz).trimmed.fastq.gz -O ${OUTPUT_DIR}/$(basename ${REF_R2} .fastq.gz).trimmed.fastq.gz \
-h ${OUTPUT_DIR}/$(basename ${REF_R1} .fastq.gz)_report.html -t ${SLURM_CPUS_PER_TASK}
