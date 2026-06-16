#!/usr/bin/env bash
set -euo pipefail

# Diretórios
IN_DIR="results/fastqc"
OUT_DIR="results/multiqc"

echo "Criando diretório de saída do MultiQC: ${OUT_DIR}..."
mkdir -p "${OUT_DIR}"

echo "Rodando MultiQC em ${IN_DIR}..."
multiqc "${IN_DIR}" -o "${OUT_DIR}"

echo "Análise MultiQC concluída."
echo "Relatório principal: ${OUT_DIR}/multiqc_report.html"
