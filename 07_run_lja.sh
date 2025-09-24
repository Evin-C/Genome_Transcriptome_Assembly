#!/usr/bin/env bash

#SBATCH --job-name=lja                # Job name
#SBATCH --output=lja_%j.out           # Standard output log
#SBATCH --error=lja_%j.err            # Standard input log
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
OUTPUT_DIR="${WORKDIR}/lja_assembly"
CONTAINER="/containers/apptainer/lja-0.2.sif"

# Create output directory if it does not already exist
mkdir -p ${OUTPUT_DIR}
# Go to output directory to make sure output files end up in here
cd ${OUTPUT_DIR}

apptainer exec --bind ${WORKDIR} ${CONTAINER} lja \
  --reads ${ANZ_FILE} \
  -t ${SLURM_CPUS_PER_TASK} \
  -o ${OUTPUT_DIR}
