#!/usr/bin/env bash

#SBATCH --job-name=nucmer_mummer      # Job name
#SBATCH --output=nucmer_mummer_%j.out # Standard output log
#SBATCH --error=nucmer_mummer_%j.err  # Standard input log
#SBATCH --cpus-per-task=16
#SBATCH --mem=60G                     # 60G memory allocation
#SBATCH --time=04:00:00
#SBATCH --partition=pibu_el8

# Define USER variable
USER="ecapan"

# Define Working Directory
WORKDIR="/data/users/${USER}/assembly_annotation_course/Genome_Transcriptome_Assembly"

# Define Output, Container, and Reference Directory
OUTPUT_DIR="${WORKDIR}/MUMmer_results"
CONTAINER="/containers/apptainer/mummer4_gnuplot.sif"
REFERENCE_DIR="/data/courses/assembly-annotation-course/references"

# Create the output directory if it doesn't already exist
mkdir -p ${OUTPUT_DIR}
cd ${OUTPUT_DIR}

# Define Assembly and Reference File Paths
FLYE_ASSEMBLY="${WORKDIR}/flye_assembly/assembly.fasta"
HIFIASM_ASSEMBLY="${WORKDIR}/hifiasm_assembly/hifi_assembly.bp.p_ctg.fa"
LJA_ASSEMBLY="${WORKDIR}/lja_assembly/assembly.fasta"
REF="${REFERENCE_DIR}/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"

# Function: run nucmer + filter + mummerplot
run_comparison () {
    REF_FILE=$1
    QUERY_FILE=$2
    PREFIX=$3

    # Align
    apptainer exec --bind ${WORKDIR} ${CONTAINER} nucmer \
      --prefix=${PREFIX} --breaklen 1000 --mincluster 1000 \
      ${REF_FILE} ${QUERY_FILE}

    # Filter: One-to-one mapping (-1); each query contig is mapped only once to the reference
    # Removes secondary alignments caused by repeats, resulting in a cleaner Dotplot
    apptainer exec --bind ${WORKDIR} ${CONTAINER} delta-filter -1 ${PREFIX}.delta > ${PREFIX}.filtered.delta

    # Plot dotplot
    apptainer exec --bind ${WORKDIR} ${CONTAINER} mummerplot \
      -R ${REF_FILE} -Q ${QUERY_FILE} \
      --prefix=${PREFIX} --filter --fat --layout --large -t png \
      ${PREFIX}.filtered.delta
    
    # Display the coordinates, and other useful information about alignments
    apptainer exec --bind ${WORKDIR} ${CONTAINER} show-coords \
      -rcl ${PREFIX}.filtered.delta > ${PREFIX}.coords.txt
}

# Assemblies vs Reference
run_comparison ${REF} ${FLYE_ASSEMBLY} flye_vs_ref
run_comparison ${REF} ${HIFIASM_ASSEMBLY} hifiasm_vs_ref
run_comparison ${REF} ${LJA_ASSEMBLY} lja_vs_ref

# Pairwise Assemblies
run_comparison ${FLYE_ASSEMBLY} ${HIFIASM_ASSEMBLY} flye_vs_hifiasm
run_comparison ${FLYE_ASSEMBLY} ${LJA_ASSEMBLY} flye_vs_lja
run_comparison ${HIFIASM_ASSEMBLY} ${LJA_ASSEMBLY} hifiasm_vs_lja
