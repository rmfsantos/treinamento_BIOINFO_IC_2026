#!/usr/bin/env bash
set -euo pipefail

ENV_NAME="orchid_qc"
RAW_DIR="data/raw"
TRIM_DIR="data/trimmed_cutadapt"

echo "Instalando Cutadapt (se necessário)..."
conda install -y cutadapt

echo "Criando diretório de saída: ${TRIM_DIR}..."
mkdir -p "${TRIM_DIR}"

# Adaptador de exemplo (Illumina 3' universal)
ADAPTER_SEQ="AGATCGGAAGAGC"

for fq in "${RAW_DIR}"/*.fastq*; do
    base=$(basename "${fq}")
    out="${TRIM_DIR}/${base%.fastq*}.trimmed.fastq.gz"

    echo "Rodando Cutadapt em: ${fq}"
    cutadapt \
        -a "${ADAPTER_SEQ}" \
        -q 20 \
        -m 36 \
        -o "${out}" \
        "${fq}"
    echo "Saída gerada: ${out}"
done

echo "Trimming com Cutadapt concluído. Arquivos em: ${TRIM_DIR}"
