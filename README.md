# Genome and Transcriptome Assembly
**This repository contains scripts and workflow steps for the course "473637-HS2025-0: Genome and Transcriptome Assembly"**.

The goal is to assemble genomes and transcriptomes from raw sequencing data (2nd and 3rd generation sequencing) and evaluate their quality.

The project follows the complete workflow:
- **Quality Control** and **Preprocessing** (Read trimming and filtering)
- **k-mer Counting**
- **Genome Assembly** using multiple assemblers
- **Transcriptome Assembly**.
- **Completeness Assessment**
- **Quality and Statistics Evaluation**
- **Comparative Genome Analysis**

---

## Repository structure
```bash
Genome_Transcriptome_Assembly/
│
├── scripts/
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

| Step(s) | Task                                  | Tool(s)                     |
|---------|---------------------------------------|-----------------------------|
| 1, 2, 3 | Quality Control & Preprocessing       | FastQC, Fastp               |
| 4       | Genome Size Estimation (k-mer counts) | Jellyfish                   |
| 5, 6, 7 | Genome Assembly (multiple approaches) | Flye, Hifiasm, LJA          |
| 8       | Transcriptome Assembly                | Trinity                     |
| 9, 10, 11, 12, 13| Assembly Evaluation          | BUSCO, QUAST, Merqury       |
| 14      | Assembly Comparison                   | MUMmer/Nucmer               |

This workflow was applied to one genome dataset and two transcriptome datasets.  
- **Transcriptomes** were quality-filtered with Fastp and assembled with Trinity.  
- **Genome** data was assembled using Flye, Hifiasm, and LJA, after k-mer analysis with Jellyfish.  
- **Evaluation**: BUSCO was used on both genome and transcriptome assemblies, while QUAST, Merqury, and MUMmer/Nucmer were run only on the genome assemblies.

## Dependencies
The following tools (+ versions) were used in this project:
- FastQC (v0.12.1)
- Fastp (v0.24.1)
- Jellyfish (v2.2.6)
- Flye (v2.9.5)
- Hifiasm (v0.25.0)
- LJA (v0.2)
- Trinity (v2.15.1)
- BUSCO (v5.7.1)
- QUAST (v5.2.0)
- Merqury (v1.3)
- MUMmer4 (v4.0.0)

## Usage
All scripts are written for an HPC environment with **SLURM job scheduling**.  
Paths and resource parameters (CPUs, memory, runtime) should be adapted to your system before submission.  

Example:
```bash
sbatch 01_run_fastqc.sh
```
Scripts can be executed independently or sequentially, following the workflow order (scripts are numbered).

## Notes
Raw data and large results are not included in this repository.

Scripts assume standard FASTQ input and write outputs to user-defined directories.

The repository documents the workflow and scripts only. Actual assemblies and results are produced externally (by running the scripts).

## License
This project is licensed under the MIT License.