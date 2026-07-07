# Treinamento_IC_Aula3_QC + Trimming (FastQC, MultiQC e 3 ferramentas de corte)

## Objetivo

- Revisar e interpretar relatórios do FastQC e MultiQC.
- Aplicar 3 ferramentas de trimming no mesmo conjunto de FASTQ.
- Comparar os efeitos de cada ferramenta em qualidade, tamanho e número de reads.

## Estrutura adicional

data/trimmed_trimmomatic/  # FASTQ pós Trimmomatic
data/trimmed_cutadapt/     # FASTQ pós Cutadapt
data/trimmed_fastp/        # FASTQ pós fastp

results/before_trim/...    # QC antes do trimming
results/trimmomatic/...    # QC pós Trimmomatic
results/cutadapt/...       # QC pós Cutadapt
results/fastp/...          # QC pós fastp

## Roteiro simplificado

1. Rodar FastQC + MultiQC nos dados brutos.
2. Rodar:
   - 03_trim_trimmomatic.sh
   - 04_trim_cutadapt.sh
   - 05_trim_fastp.sh
3. Rodar FastQC + MultiQC para cada conjunto trimmed.
4. Abrir os 4 relatórios MultiQC e preencher a tabela de comparação em `docs/tabela_comparacao.md`.
