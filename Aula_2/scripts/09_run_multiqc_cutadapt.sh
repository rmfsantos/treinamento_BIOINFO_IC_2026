#!/usr/bin/env bash
set -euo pipefail

ENV_NAME="orchid_qc"
IN_DIR="results/cutadapt/fastqc"
OUT_DIR="results/cutadapt/multiqc"

echo "Criando diretório de saída do MultiQC (Cutadapt): ${OUT_DIR}..."
mkdir -p "${OUT_DIR}"

echo "Rodando MultiQC em ${IN_DIR}..."
multiqc "${IN_DIR}" -o "${OUT_DIR}"

echo "MultiQC pós-Cutadapt concluído."
echo "Relatório: ${OUT_DIR}/multiqc_report.html"
