#!/usr/bin/env bash
set -euo pipefail

ENV_NAME="orchid_qc"
IN_DIR="results/fastp/fastqc"
OUT_DIR="results/fastp/multiqc"

echo "Ativando ambiente Conda: ${ENV_NAME}..."
conda activate "${ENV_NAME}"

echo "Criando diretório de saída do MultiQC (fastp): ${OUT_DIR}..."
mkdir -p "${OUT_DIR}"

echo "Rodando MultiQC em ${IN_DIR}..."
multiqc "${IN_DIR}" -o "${OUT_DIR}"

echo "MultiQC pós-fastp concluído."
echo "Relatório: ${OUT_DIR}/multiqc_report.html"
