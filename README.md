# De Novo Genome and Transcriptome Assembly
**This repository contains scripts and workflow steps for the course "473637-HS2025-0: Genome and Transcriptome Assembly"**.

The goal is to assemble genomes and transcriptomes from raw second- and third-generation sequencing data and to evaluate assembly quality by comparing different assemblies against reference sequences and one another.

The project includes the following workflow steps:
1. **Quality Control, Preprocessing, and k-mer Counting**
2. **Genome and Transcriptome Assembly**
3. **Assembly Evaluation**
4. **Assembly Comparison**

---
## Data
This project uses one *Arabidopsis thaliana* genome dataset (Anz-0 accession) and paired-end transcriptome datasets (Sha accession, R1/R2).
All data are publicly available from the following publications:
- [Lian Q et al. (2024). Nature Genetics, 56:982–991](https://www.nature.com/articles/s41588-024-01715-9). 
- [Jiao WB, Schneeberger K. (2020). Nature Communications, 11:1–10](http://dx.doi.org/10.1038/s41467-020-14779-y). 

---

## Repository structure
```bash
Genome_Transcriptome_Assembly/
│
├── scripts/
│ ├── 00_get_data.sh # Get sequencing data
│ ├── 01_run_fastqc.sh # Quality check on raw reads
│ ├── 02_run_fastp.sh # Read trimming and filtering
│ ├── 03_run_fastqc_after_fastp.sh # QC on cleaned reads
│ ├── 04_run_jellyfish.sh # K-mer counting
│ ├── 05_run_flye.sh # Genome assembly with Flye
│ ├── 06_run_hifiasm.sh # Genome assembly with Hifiasm
│ ├── 07_run_lja.sh # Genome assembly with LJA
│ ├── 08_run_trinity.sh # Transcriptome assembly with Trinity
│ ├── 09_download_busco_lineage.sh # Download BUSCO lineage datasets
│ ├── 10_run_busco.sh # Genome quality assessment with BUSCO
│ ├── 11_run_quast.sh # Assembly statistics with QUAST
│ ├── 12_get_best_k.sh # Helper script for k-mer selection
│ ├── 13_run_merqury.sh # Assembly evaluation with Merqury
│ └── 14_run_nucmer_mummer.sh # Genome alignment with MUMmer/Nucmer
│
├── LICENSE
└── README.md
```

## Analysis Workflow

| Step | Script Number(s) | Task                                  | Tools                     |
|------------|---------|---------------------------------------|-----------------------------|
| 0 | [0](scripts/00_get_data.sh)      | Get Genome and Transcriptome Data                   |               |
| 1 | [1](scripts/01_run_fastqc.sh), [2](scripts/02_run_fastp.sh), [3](scripts/03_run_fastqc_after_fastp.sh), [4](scripts/04_run_jellyfish.sh) | Quality Control, Preprocessing, and k-mer Counting       | FastQC, Fastp, Jellyfish |
| 2 | [5](scripts/05_run_flye.sh), [6](scripts/06_run_hifiasm.sh), [7](scripts/07_run_lja.sh), [8](scripts/08_run_trinity.sh) | Genome and Transcriptome Assembly (multiple assemblers) | Flye, Hifiasm, LJA, Trinity        |
| 3 | [9](scripts/09_download_busco_lineage.sh), [10](scripts/10_run_busco.sh), [11](scripts/11_run_quast.sh), [12](scripts/12_get_best_k.sh), [13](scripts/13_run_merqury.sh)| Assembly Evaluation          | BUSCO, QUAST, Merqury       |
| 4 | [14](scripts/14_run_nucmer_mummer.sh)      | Assembly Comparison                   | MUMmer/Nucmer               |

This workflow was applied to one genome dataset and two transcriptome datasets.  
- **Transcriptomes** were quality-filtered with Fastp and assembled with Trinity.  
- **Genome** data were assembled using Flye, Hifiasm, and LJA, after k-mer analysis with Jellyfish.  
- **Evaluation**: BUSCO was applied to both genome and transcriptome assemblies, while QUAST, Merqury, and MUMmer/Nucmer were run only on the genome assemblies.

## Dependencies
The following tools and versions were used in this project:
- [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) (v0.12.1)
- [Fastp](https://github.com/OpenGene/fastp) (v0.24.1)
- [Jellyfish](https://github.com/gmarcais/Jellyfish) (v2.2.6)
- [Flye](https://github.com/mikolmogorov/Flye) (v2.9.5)
- [Hifiasm](https://github.com/chhylp123/hifiasm) (v0.25.0)
- [LJA](https://github.com/AntonBankevich/LJA) (v0.2)
- [Trinity](https://github.com/trinityrnaseq/trinityrnaseq/wiki) (v2.15.1)
- [BUSCO](https://busco.ezlab.org) (v5.7.1)
- [QUAST](https://github.com/ablab/quast) (v5.2.0)
- [Merqury](https://github.com/marbl/merqury) (v1.3)
- [MUMmer4](https://github.com/mummer4/mummer) (v4.0.0)

## Usage
All scripts are written for an HPC environment with SLURM job scheduling.  
Paths and resource parameters (CPUs, memory, runtime) **should be adapted to your system** before submission.  

Example:
```bash
sbatch scripts/01_run_fastqc.sh
```
Scripts can be executed independently (not recommended) or sequentially, following the [workflow](#analysis-workflow) order (scripts are numbered).

## Notes
Raw data and results are not included in this repository.

Scripts assume standard FASTQ input and write outputs to user-defined directories.

The repository documents the workflow and scripts only. Actual assemblies and results are produced by running the scripts.

## License
This project is licensed under the MIT License.