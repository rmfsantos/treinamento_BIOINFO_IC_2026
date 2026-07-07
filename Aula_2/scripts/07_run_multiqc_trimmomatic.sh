#!/usr/bin/env bash
set -euo pipefail

ENV_NAME="orchid_qc"
IN_DIR="results/trimmomatic/fastqc"
OUT_DIR="results/trimmomatic/multiqc"

echo "Criando diretório de saída do MultiQC: ${OUT_DIR}..."
mkdir -p "${OUT_DIR}"

echo "Rodando MultiQC em ${IN_DIR}..."
multiqc "${IN_DIR}" -o "${OUT_DIR}"

echo "MultiQC pós-Trimmomatic concluído."
echo "Relatório: ${OUT_DIR}/multiqc_report.html"
