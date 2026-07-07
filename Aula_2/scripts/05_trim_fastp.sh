#!/usr/bin/env bash
set -euo pipefail

ENV_NAME="orchid_qc"
RAW_DIR="data/raw"
TRIM_DIR="data/trimmed_fastp"

echo "Ativando ambiente Conda: ${ENV_NAME}..."
conda activate "${ENV_NAME}"

echo "Instalando fastp (se necessário)..."
conda install -y fastp

echo "Criando diretório de saída: ${TRIM_DIR}..."
mkdir -p "${TRIM_DIR}"

for fq in "${RAW_DIR}"/*.fastq*; do
    base=$(basename "${fq}")
    sample="${base%.fastq*}"

    out="${TRIM_DIR}/${sample}.trimmed.fastq.gz"
    html_report="${TRIM_DIR}/${sample}.fastp.html"
    json_report="${TRIM_DIR}/${sample}.fastp.json"

    echo "Rodando fastp em: ${fq}"
    fastp \
        -i "${fq}" \
        -o "${out}" \
        -q 20 \
        -l 36 \
        -h "${html_report}" \
        -j "${json_report}"

    echo "Saída gerada: ${out}"
    echo "Relatórios fastp: ${html_report}, ${json_report}"
done

echo "Trimming com fastp concluído. Arquivos em: ${TRIM_DIR}"
