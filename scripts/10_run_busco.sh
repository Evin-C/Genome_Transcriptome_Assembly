#!/usr/bin/env bash

#SBATCH --job-name=busco              # Job name
#SBATCH --output=busco_%j.out         # Standard output log
#SBATCH --error=busco_%j.err          # Standard input log
#SBATCH --cpus-per-task=16             
#SBATCH --mem=60G                     # 60G memory allocation
#SBATCH --time=05:00:00
#SBATCH --partition=pibu_el8

# Define USER variable
USER="ecapan"

# Define Working Directory
WORKDIR="/data/users/${USER}/assembly_annotation_course/Genome_Transcriptome_Assembly"

# Define Assembly File Paths
FLYE_ASSEMBLY="${WORKDIR}/flye_assembly/assembly.fasta"
HIFIASM_ASSEMBLY="${WORKDIR}/hifiasm_assembly/hifi_assembly.bp.p_ctg.fa"
LJA_ASSEMBLY="${WORKDIR}/lja_assembly/assembly.fasta"
TRINITY_ASSEMBLY="${WORKDIR}/trinity_assembly/trinity_assembly.Trinity.fasta"

# Define Output, Container, and Local BUSCO Lineage Directory (offline mode)
OUTPUT_DIR="${WORKDIR}/BUSCO_results"
CONTAINER="/containers/apptainer/busco_5.7.1.sif"
LINEAGE_DIR="${WORKDIR}/busco_downloads" # Not necessary if not running it offline

# Create the output directory if it doesn't already exist
mkdir -p ${OUTPUT_DIR}

# Run BUSCO on the flye Assembly
apptainer exec --bind ${WORKDIR} ${CONTAINER} busco \
  -i ${FLYE_ASSEMBLY} \
  -m genome \
  --lineage brassicales_odb10 \
  --cpu ${SLURM_CPUS_PER_TASK} \
  -o flye \
  --out_path ${OUTPUT_DIR} \
  --download_path ${LINEAGE_DIR} \
  --offline     # offline mode

# Run BUSCO on the hifiasm Assembly
apptainer exec --bind ${WORKDIR} ${CONTAINER} busco \
  -i ${HIFIASM_ASSEMBLY} \
  -m genome \
  --lineage brassicales_odb10 \
  --cpu ${SLURM_CPUS_PER_TASK} \
  -o hifiasm \
  --out_path ${OUTPUT_DIR} \
  --download_path ${LINEAGE_DIR} \
  --offline     # offline mode

# Run BUSCO on the LJA Assembly
apptainer exec --bind ${WORKDIR} ${CONTAINER} busco \
  -i ${LJA_ASSEMBLY} \
  -m genome \
  --lineage brassicales_odb10 \
  --cpu ${SLURM_CPUS_PER_TASK} \
  -o lja \
  --out_path ${OUTPUT_DIR} \
  --download_path ${LINEAGE_DIR} \
  --offline     # offline mode

# Run BUSCO on the Trinity Assembly
apptainer exec --bind ${WORKDIR} ${CONTAINER} busco \
  -i ${TRINITY_ASSEMBLY} \
  -m transcriptome \
  --lineage brassicales_odb10 \
  --cpu ${SLURM_CPUS_PER_TASK} \
  -o trinity \
  --out_path ${OUTPUT_DIR} \
  --download_path ${LINEAGE_DIR} \
  --offline     # offline mode

# BUSCO command options:
# -i: input files
# -m: mode of analysis (genome/transcriptome)
# --lineage: specifies lineage dataset (ortholog database) to use for assessing completeness
# -o: output directory name prefix
# --out_path: output directory
# --download_path: path to local lineage dataset directory (avoid re-downloading the same BUSCO dataset)
# --ofline: run BUSCO in offline mode, avoids internet access (no possible servers errors)