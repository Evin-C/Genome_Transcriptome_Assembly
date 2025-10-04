#!/usr/bin/env bash

#SBATCH --job-name=merqury            # Job name
#SBATCH --output=merqury_%j.out       # Standard output log
#SBATCH --error=merqury_%j.err        # Standard input log
#SBATCH --cpus-per-task=16             
#SBATCH --mem=60G                     # 60G memory allocation
#SBATCH --time=08:00:00
#SBATCH --partition=pibu_el8

# Define USER variable
USER="ecapan"

# Define Working Directory
WORKDIR="/data/users/${USER}/assembly_annotation_course/Genome_Transcriptome_Assembly"

# Define Output and Container Directory
OUTPUT_DIR="${WORKDIR}/Merqury_results"
CONTAINER="/containers/apptainer/merqury_1.3.sif"

# Create the output directory if it doesn't already exist
mkdir -p ${OUTPUT_DIR}

# Add MERQURY as a path variable
export MERQURY="/usr/local/share/merqury"

# Define Assembly File Paths
FLYE_ASSEMBLY="${WORKDIR}/flye_assembly/assembly.fasta"
HIFIASM_ASSEMBLY="${WORKDIR}/hifiasm_assembly/hifi_assembly.bp.p_ctg.fa"
LJA_ASSEMBLY="${WORKDIR}/lja_assembly/assembly.fasta"

# Reads (Anz-0 fastq.gz file)
READS="${WORKDIR}/Anz-0/ERR11437354.fastq.gz"

# Build meryl DB from reads (use k=19, from best_k.sh with genome size of 135MBp)
apptainer exec --bind ${WORKDIR} ${CONTAINER} meryl k=19 count \
  ${READS} output ${OUTPUT_DIR}/reads.meryl     # Results in "reads.meryl", which is the meryl DB

#--------------------------
# Flye
mkdir -p ${OUTPUT_DIR}/flye_eval/logs
cd ${OUTPUT_DIR}/flye_eval

apptainer exec --bind ${WORKDIR} ${CONTAINER} ${MERQURY}/merqury.sh \
  ${OUTPUT_DIR}/reads.meryl ${FLYE_ASSEMBLY} flye_eval \
  > flye_merqury.log 2>&1

#--------------------------
# Hifiasm
mkdir -p ${OUTPUT_DIR}/hifiasm_eval/logs
cd ${OUTPUT_DIR}/hifiasm_eval

apptainer exec --bind ${WORKDIR} ${CONTAINER} ${MERQURY}/merqury.sh \
  ${OUTPUT_DIR}/reads.meryl ${HIFIASM_ASSEMBLY} hifiasm_eval \
  > hifiasm_merqury.log 2>&1

#--------------------------
# LJA
mkdir -p ${OUTPUT_DIR}/lja_eval/logs
cd ${OUTPUT_DIR}/lja_eval

apptainer exec --bind ${WORKDIR} ${CONTAINER} ${MERQURY}/merqury.sh \
  ${OUTPUT_DIR}/reads.meryl ${LJA_ASSEMBLY} lja_eval \
  > lja_merqury.log 2>&1
