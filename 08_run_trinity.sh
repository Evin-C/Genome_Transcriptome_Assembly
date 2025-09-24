#!/usr/bin/env bash

#SBATCH --job-name=trinity            # Job name
#SBATCH --output=trinity_%j.out       # Standard output log
#SBATCH --error=trinity_%j.err        # Standard input log
#SBATCH --cpus-per-task=16             
#SBATCH --mem=64G                     # 64G memory allocation
#SBATCH --time=1-00:00:00
#SBATCH --partition=pibu_el8

# Load Trinity module
module load Trinity/2.15.1-foss-2021a

# Define USER variable
USER="ecapan"

# Define Working Directory
WORKDIR="/data/users/${USER}/assembly_annotation_course/Genome_Transcriptome_Assembly"

# Define Reference File Paths
REFERENCE_DIR="${WORKDIR}/fastp_Results"
REF_R1="$(ls ${REFERENCE_DIR}/*_1.trimmed.fastq.gz | head -n1)"
REF_R2="$(ls ${REFERENCE_DIR}/*_2.trimmed.fastq.gz | head -n1)"

# Define Output Directory
OUTPUT_DIR="${WORKDIR}/trinity_assembly_trimmed"

# Create output directory if it does not already exist
mkdir -p ${OUTPUT_DIR}

Trinity \
  --seqType fq \
  --max_memory 64G \
  --left ${REF_R1} \
  --right ${REF_R2} \
  --CPU ${SLURM_CPUS_PER_TASK} \
  --output ${OUTPUT_DIR}
# --seqType fq: input files are FASTQ
