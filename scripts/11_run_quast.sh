#!/usr/bin/env bash

#SBATCH --job-name=quast              # Job name
#SBATCH --output=quast_%j.out         # Standard output log
#SBATCH --error=quast_%j.err          # Standard input log
#SBATCH --cpus-per-task=16             
#SBATCH --mem=60G                     # 60G memory allocation
#SBATCH --time=05:00:00
#SBATCH --partition=pibu_el8

# Define USER variable
USER="ecapan"

# Define Working Directory
WORKDIR="/data/users/${USER}/assembly_annotation_course/Genome_Transcriptome_Assembly"

# Define Output, Container, and Reference Directory
OUTPUT_DIR="${WORKDIR}/QUAST_results"
CONTAINER="/containers/apptainer/quast_5.2.0.sif"
REFERENCE_DIR="/data/courses/assembly-annotation-course/references"

# Create the output directory if it doesn't already exist
mkdir -p ${OUTPUT_DIR}

# Define Assembly File Paths
FLYE_ASSEMBLY="${WORKDIR}/flye_assembly/assembly.fasta"
HIFIASM_ASSEMBLY="${WORKDIR}/hifiasm_assembly/hifi_assembly.bp.p_ctg.fa"
LJA_ASSEMBLY="${WORKDIR}/lja_assembly/assembly.fasta"

# Reference files
REF="${REFERENCE_DIR}/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"
GFF="${REFERENCE_DIR}/Arabidopsis_thaliana.TAIR10.57.gff3"

# Run QUAST with reference
apptainer exec --bind ${WORKDIR} ${CONTAINER} quast.py \
  --threads ${SLURM_CPUS_PER_TASK} --labels flye,hifiasm,lja \
  --large --eukaryote \
  --no-sv \
  -r ${REF} --features ${GFF} \
  ${FLYE_ASSEMBLY} ${HIFIASM_ASSEMBLY} ${LJA_ASSEMBLY} \
  -o ${OUTPUT_DIR}/with_ref

# Run QUAST without reference
apptainer exec --bind ${WORKDIR} ${CONTAINER} quast.py \
  --threads ${SLURM_CPUS_PER_TASK} --labels flye,hifiasm,lja \
  --large --eukaryote \
  --est-ref-size 135000000 \
  ${FLYE_ASSEMBLY} ${HIFIASM_ASSEMBLY} ${LJA_ASSEMBLY} \
  -o ${OUTPUT_DIR}/no_ref
