#!/usr/bin/env bash

#SBATCH --job-name=flye               # Job name
#SBATCH --output=flye_%j.out          # Standard output log
#SBATCH --error=flye_%j.err           # Standard input log
#SBATCH --cpus-per-task=16             
#SBATCH --mem=64G                     # 64G memory allocation
#SBATCH --time=1-00:00:00
#SBATCH --partition=pibu_el8

# Define USER variable
USER="ecapan"

# Define Working Directory
WORKDIR="/data/users/${USER}/assembly_annotation_course/Genome_Transcriptome_Assembly"

# Define Anz-0 File Path
ANZ_DIR="${WORKDIR}/Anz-0"
ANZ_FILE=$(ls ${ANZ_DIR}/*.fastq.gz | head -n1) # Accession File

# Define Output and Container Directories
OUTPUT_DIR="${WORKDIR}/flye_assembly"
CONTAINER="/containers/apptainer/flye_2.9.5.sif"

# Create output directory if it does not already exist
mkdir -p ${OUTPUT_DIR}

# Run flye on Anz-0 file
apptainer exec --bind ${WORKDIR} ${CONTAINER} flye \
  --pacbio-hifi ${ANZ_FILE} \
  -o ${OUTPUT_DIR} \
  -t ${SLURM_CPUS_PER_TASK}
