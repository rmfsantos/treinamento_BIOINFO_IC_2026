#!/usr/bin/env bash
set -euo pipefail

ENV_NAME="orchid_qc"
RAW_DIR="data/trimmed_fastp"
OUT_DIR="results/fastp/fastqc"

echo "Criando diretório de saída do FastQC (fastp): ${OUT_DIR}..."
mkdir -p "${OUT_DIR}"

echo "Rodando FastQC nas reads pós-fastp..."
fastqc "${RAW_DIR}"/*.fastq* -o "${OUT_DIR}"

echo "FastQC pós-fastp concluído. Resultados em: ${OUT_DIR}"
