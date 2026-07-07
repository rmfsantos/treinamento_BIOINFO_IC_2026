#!/usr/bin/env bash
set -euo pipefail

RAW_DIR="data/raw"
TRIM_DIR="data/trimmed_trimmomatic"

echo "Usando ambiente Conda já ativado."
echo "Criando diretório de saída: ${TRIM_DIR}..."
mkdir -p "${TRIM_DIR}"

ADAPTERS_FILE="${CONDA_PREFIX}/share/trimmomatic/adapters/TruSeq3-SE.fa"

if [[ ! -f "${ADAPTERS_FILE}" ]]; then
    echo "ERRO: Arquivo de adaptadores não encontrado em:"
    echo "  ${ADAPTERS_FILE}"
    echo "Verifique o conteúdo de: ${CONDA_PREFIX}/share/trimmomatic/adapters"
    exit 1
fi

echo "Usando arquivo de adaptadores: ${ADAPTERS_FILE}"

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
