#!/usr/bin/env bash

#SBATCH --job-name=best_k             # Job name
#SBATCH --output=best_k_%j.out        # Standard output log
#SBATCH --error=best_k_%j.err         # Standard input log
#SBATCH --cpus-per-task=4
#SBATCH --mem=20G                     # 20G memory allocation
#SBATCH --time=00:10:00
#SBATCH --partition=pibu_el8

# Define Working Directory
USER="ecapan"
WORKDIR="/data/users/${USER}/assembly_annotation_course/Genome_Transcriptome_Assembly"

# Define Container Directory
CONTAINER="/containers/apptainer/merqury_1.3.sif"

# Add MERQURY as a path variable
export MERQURY="/usr/local/share/merqury"

# Genome size for Arabidopsis thaliana ~135 Mbp
GENOME_SIZE=135000000

# Run best_k.sh inside container
apptainer exec --bind ${WORKDIR} ${CONTAINER} \
  sh $MERQURY/best_k.sh ${GENOME_SIZE} 0.001
