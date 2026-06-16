#!/usr/bin/env bash
set -euo pipefail

# Diretórios
RAW_DIR="data/raw"
OUT_DIR="results/fastqc"

echo "Criando diretório de saída: ${OUT_DIR}..."
mkdir -p "${OUT_DIR}"

echo "Rodando FastQC em todos os arquivos FASTQ de ${RAW_DIR}..."
fastqc "${RAW_DIR}"/*.fastq* -o "${OUT_DIR}"

echo "Análise FastQC concluída."
echo "Relatórios HTML e arquivos .zip foram salvos em: ${OUT_DIR}"
