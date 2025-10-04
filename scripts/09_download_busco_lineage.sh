#!/usr/bin/env bash

#SBATCH --job-name=dl_busco_lineage      # Job name
#SBATCH --output=dl_busco_lineage_%j.out # Standard output log
#SBATCH --error=dl_busco_lineage_%j.err  # Standard input log
#SBATCH --cpus-per-task=4             
#SBATCH --mem=6G                         # 6G memory allocation
#SBATCH --time=00:30:00
#SBATCH --partition=pibu_el8

# This script downloads and extracts the BUSCO lineage dataset (brassicales_odb10)
# required for genome completeness assessment. The lineage is pre-downloaded
# locally to ensure reproducibility and avoid network issues during BUSCO runs.

# Define USER variable
USER="ecapan"

# Define Working Directory
WORKDIR="/data/users/${USER}/assembly_annotation_course/Genome_Transcriptome_Assembly"

# Create the Output Directory and cd into Directory (end folder needs to be named "lineages")
mkdir -p ${WORKDIR}/busco_downloads/lineages
cd ${WORKDIR}/busco_downloads/lineages

# Locally pre-download the brassicales_odb10 lineage from BUSCO
#   (in case the download from the web does not work)
wget https://busco-data.ezlab.org/v5/data/lineages/brassicales_odb10.2024-01-08.tar.gz

# Extract into Working Directory
tar -xvzf brassicales_odb10.2024-01-08.tar.gz -C ${WORKDIR}/busco_downloads
