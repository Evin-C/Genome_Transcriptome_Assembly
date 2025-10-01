#!/usr/bin/env bash

#SBATCH --job-name=hifiasm            # Job name
#SBATCH --output=hifiasm_%j.out       # Standard output log
#SBATCH --error=hifiasm_%j.err        # Standard input log
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
OUTPUT_DIR="${WORKDIR}/hifiasm_assembly"
CONTAINER="/containers/apptainer/hifiasm_0.25.0.sif"

# Create output directory if it does not already exist
mkdir -p ${OUTPUT_DIR}
# Go to output directory to make sure output files end up in here
cd ${OUTPUT_DIR}

# Run hifiasm on Anz-0 file
apptainer exec --bind ${WORKDIR} ${CONTAINER} hifiasm \
  -o hifi_assembly \
  -t ${SLURM_CPUS_PER_TASK} \
  ${ANZ_FILE}
# -o sets the prefix for output files

# Convert GFA to FASTA
awk '/^S/{print ">"$2;print $3}' hifi_assembly.bp.p_ctg.gfa > hifi_assembly.bp.p_ctg.fa
