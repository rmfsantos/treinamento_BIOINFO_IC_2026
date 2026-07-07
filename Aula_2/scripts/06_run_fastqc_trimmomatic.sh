#!/usr/bin/env bash
set -euo pipefail

ENV_NAME="orchid_qc"
RAW_DIR="data/trimmed_trimmomatic"
OUT_DIR="results/trimmomatic/fastqc"

echo "Ativando ambiente Conda: ${ENV_NAME}..."
conda activate "${ENV_NAME}"

echo "Criando diretório de saída: ${OUT_DIR}..."
mkdir -p "${OUT_DIR}"

echo "Rodando FastQC nas reads pós Trimmomatic..."
fastqc "${RAW_DIR}"/*.fastq* -o "${OUT_DIR}"

echo "FastQC concluído. Resultados em: ${OUT_DIR}"
