#!/usr/bin/env bash
set -euo pipefail

ENV_NAME="orchid_qc"
RAW_DIR="data/trimmed_cutadapt"
OUT_DIR="results/cutadapt/fastqc"

echo "Ativando ambiente Conda: ${ENV_NAME}..."
conda activate "${ENV_NAME}"

echo "Criando diretório de saída do FastQC (Cutadapt): ${OUT_DIR}..."
mkdir -p "${OUT_DIR}"

echo "Rodando FastQC nas reads pós-Cutadapt..."
fastqc "${RAW_DIR}"/*.fastq* -o "${OUT_DIR}"

echo "FastQC pós-Cutadapt concluído. Resultados em: ${OUT_DIR}"
