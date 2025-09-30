# Genome and Transcriptome Assembly
#### This repository contains scripts and workflow steps for the course "**473637-HS2025-0: Genome and Transcriptome Assembly**".
The goal is to assemble genomes and transcriptomes from raw sequencing data (2nd and 3rd generation sequencing) and evaluate their quality.

The project follows the complete workflow:
- **Quality Control** and **Read Trimming**
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

## Analysis Workflow             need to change this, not nice looking
1. **Quality Control & Preprocessing**  
   - Run FastQC on raw reads  
   - Filter and trim reads with Fastp  
   - Re-check quality on cleaned reads  

2. **Genome Size Estimation**  
   - Count k-mers with Jellyfish

3. **Genome Assembly**  
   - Perform de novo assembly with Flye, Hifiasm, and LJA  

4. **Transcriptome Assembly**  
   - Assemble transcripts with Trinity  

5. **Assembly Evaluation & Comparison**  
   - Assess completeness with BUSCO  
   - Evaluate assembly statistics with QUAST  
   - Use helper script `get_best_k.sh` for optimal k-mer size  
   - Perform reference-free quality evaluation with Merqury  
   - Compare genome assemblies with Nucmer and MUMmer

## Dependencies
The following tools (+ versions) were used in this project:
- FastQC ()
- Fastp ()
- Jellyfish ()
- Flye ()
- Hifiasm ()
- LJA ()
- Trinity ()
- BUSCO ()
- QUAST ()
- Merqury ()
- MUMmer4 ()

## Usage
All scripts are written for an HPC environment with **SLURM job scheduling**.  
Paths and resource parameters (CPUs, memory, runtime) should be adapted to your system before submission.  

Example:
```bash
sbatch scripts/01_run_fastqc.sh
```
Scripts can be executed independently or sequentially, following the workflow order (scripts are numbered).

## Notes
Raw data and large results are not included in this repository.

Scripts assume standard FASTQ input and write outputs to user-defined directories.

The repository documents the workflow and scripts only. Actual assemblies and results are produced externally (by running the scripts).

## License
This project is licensed under the MIT License.