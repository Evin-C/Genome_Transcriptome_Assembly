#!/usr/bin/env bash

#SBATCH --job-name=jellyfish          # Job name
#SBATCH --output=jellyfish_%j.out     # Standard output log
#SBATCH --error=jellyfish_%j.err      # Standard input log
#SBATCH --cpus-per-task=4             
#SBATCH --mem=40G                     # 40G memory allocation
#SBATCH --time=02:00:00
#SBATCH --partition=pibu_el8

# Define USER variable
USER="ecapan"

# Define Working Directory
WORKDIR="/data/users/${USER}/assembly_annotation_course/Genome_Transcriptome_Assembly"

# Define input and output paths
ANZ_DIR="${WORKDIR}/Anz-0"
OUTPUT_DIR="${WORKDIR}/jellyfish_Results"

# Define Container Directory
CONTAINER="/containers/apptainer/jellyfish-2.2.6--0.sif"

# Create output directory if it does not already exist
mkdir -p ${OUTPUT_DIR}

# Pick Anz-0 file
ANZ_FILE=$(ls ${ANZ_DIR}/*.fastq.gz | head -n1)

# Count k-mers (k=21) using Jellyfish
apptainer exec --bind ${WORKDIR} ${CONTAINER} \
jellyfish count -C -m 21 -s 5G -t 4 -o ${OUTPUT_DIR}/anz_counts.jf <(zcat ${ANZ_FILE})
# -C: canonical kmers (both strands)

# Export the k-mer count histogram
apptainer exec --bind ${WORKDIR} ${CONTAINER} \
jellyfish histo -t 4 ${OUTPUT_DIR}/anz_counts.jf > ${OUTPUT_DIR}/anz_counts.histo
