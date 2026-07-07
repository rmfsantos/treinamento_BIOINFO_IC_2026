#!/usr/bin/env bash
set -euo pipefail

ENV_NAME="orchid_qc"
RAW_DIR="data/raw"
TRIM_DIR="data/trimmed_trimmomatic"

echo "Ativando ambiente Conda: ${ENV_NAME}..."
conda activate "${ENV_NAME}"

echo "Instalando Trimmomatic (se necessário)..."
conda install -y trimmomatic

echo "Criando diretório de saída: ${TRIM_DIR}..."
mkdir -p "${TRIM_DIR}"

# Caminho padrão dos arquivos de adaptador dentro do ambiente conda
ADAPTERS_DIR="${CONDA_PREFIX}/share/trimmomatic-0.39-1/adapters"
ADAPTERS_FILE="${ADAPTERS_DIR}/TruSeq3-SE.fa"

echo "Usando arquivo de adaptadores: ${ADAPTERS_FILE}"

# Loop sobre todos os FASTQ(.gz) em data/raw
for fq in "${RAW_DIR}"/*.fastq*; do
    base=$(basename "${fq}")
    out="${TRIM_DIR}/${base%.fastq*}.trimmed.fastq.gz"

    echo "Rodando Trimmomatic em: ${fq}"
    trimmomatic SE \
        -threads 4 \
        -phred33 \
        "${fq}" \
        "${out}" \
        ILLUMINACLIP:"${ADAPTERS_FILE}":2:30:10 \
        SLIDINGWINDOW:4:15 \
        MINLEN:36

    echo "Saída gerada: ${out}"
done

echo "Trimming com Trimmomatic concluído. Arquivos em: ${TRIM_DIR}"
