# Treinamento_IC_Aula1_QC com FastQC e MultiQC

Este projeto foi criado para analisar a qualidade de arquivos FASTQ usando as ferramentas **FastQC** e **MultiQC**.

## Objetivo

Neste projeto, o aluno vai:

- Organizar um projeto de bioinformática em pastas.
- Rodar o FastQC para avaliar a qualidade dos arquivos FASTQ.
- Rodar o MultiQC para juntar todos os relatórios em um único arquivo.
- Aprender a documentar o projeto com um README.

## Estrutura do projeto 
nome do projeto: treinamento_orchid_qc
```text
docs/              # documentos e bibliografia
data/raw/          # arquivos FASTQ de entrada
data/metadata/     # informações das amostras
scripts/           # scripts para rodar as análises
results/fastqc/    # resultados do FastQC
results/multiqc/   # resultado do MultiQC
README.md          # documentação do projeto
```

## Programas necessários

Antes de começar, é preciso ter instalado: (se virar, usar a IA para ajudar)

- VS Code
- Conda

## Como criar o ambiente

Se quiser criar o ambiente manualmente, use:

```bash
conda create --name orchid_qc 
conda activate orquideas-qc # ativa o ambiente conda
conda install fastqc multiqc -y # instala as ferramentas necessarias
fastqc --version # checa a versão instalada
muiltiqc --version # checa a versão instalada
```

## Dados de entrada

Os arquivos de entrada devem ser colocados em:

```text
data/raw/
```
Baixar em: amostra1 = https://trace.ncbi.nlm.nih.gov/Traces/?run=SRR8175630 
           amostra2 = https://trace.ncbi.nlm.nih.gov/Traces/?run=SRR8175637
           amostra3 = https://trace.ncbi.nlm.nih.gov/Traces/?run=SRR8175650

Exemplo de arquivos:

```text
data/raw/SSRXXXXXX.fastq.gz
data/raw/SSRXXXXXX.fastq.gz
data/raw/SSRXXXXXX.fastq.gz
```

## Metadados
Fazer uma planilha de metadados das amostras

```tabela
Run_ID,Spots,Bases,Size,GC_Content,Data_Status,Published
data/metadata/metadata.csv
```
Rodar um dos transcriptmas com o fastQC
``bash
fastqc {SRRXXXX.fastq.gz}

### Scripts - craiçao e exucução de scripts em bash .sh

## Script do FastQC

Arquivo: `scripts/run_fastqc.sh`

```bash
#!/usr/bin/env bash
# Define o interpretador do script usando o Bash localizado no ambiente do sistema

set -euo pipefail
# -e: interrompe o script se qualquer comando falhar
# -u: gera erro se uma variável não definida for usada
# -o pipefail: falha se qualquer comando em um pipeline falhar

RAW_DIR="data/raw"
# Diretório onde estão os arquivos FASTQ de entrada

OUT_DIR="results/fastqc"
# Diretório onde os resultados do FastQC serão armazenados

echo "Criando diretório de saída: ${OUT_DIR}..."
# Mensagem informando a criação do diretório de saída

mkdir -p "${OUT_DIR}"
# Cria o diretório de saída; -p evita erro se já existir

echo "Rodando FastQC em todos os arquivos FASTQ de ${RAW_DIR}..."
# Mensagem indicando início da análise

fastqc "${RAW_DIR}"/*.fastq* -o "${OUT_DIR}"
# Executa o FastQC em todos os arquivos .fastq, .fq, .fastq.gz etc.
# dentro do diretório RAW_DIR, salvando os resultados em OUT_DIR

echo "Análise FastQC concluída."
# Mensagem indicando término da execução

echo "Relatórios salvos em: ${OUT_DIR}"
# Informa onde os relatórios foram salvos
```

Esse padrão de script segue o uso típico do FastQC em lote sobre múltiplos arquivos FASTQ.

## Script do MultiQC

Arquivo: `scripts/run_multiqc.sh`

```bash
#!/usr/bin/env bash
# Esta linha indica que o script deve ser executado usando o programa "bash".
# É o "shebang": quase todo script em shell começa assim.

set -euo pipefail
# 'set -e'  : se algum comando der erro, o script para imediatamente.
# 'set -u'  : se usar uma variável que não foi definida, o script também para.
# 'set -o pipefail' : se um comando dentro de um pipeline (com "|") falhar, o erro é propagado.
# Essas três opções ajudam a evitar que o script continue rodando em estado "quebrado".

ENV_NAME="orquideas-qc"
# Aqui definimos o nome do ambiente Conda que será usado.
# Você pode trocar "orquideas-qc" pelo nome do ambiente do seu projeto.

IN_DIR="results/fastqc"
# IN_DIR é o diretório onde estão os resultados do FastQC.
# O MultiQC vai ler esses arquivos para gerar o relatório resumido.

OUT_DIR="results/multiqc"
# OUT_DIR é o diretório onde o MultiQC vai salvar o relatório final.

echo "Criando diretório de saída do MultiQC: ${OUT_DIR}..."
# 'echo' apenas imprime uma mensagem na tela, para o usuário saber o que está acontecendo.

mkdir -p "${OUT_DIR}"
# 'mkdir -p' cria a pasta indicada em OUT_DIR.
# A opção '-p' garante que, se a pasta já existir, não dá erro.

echo "Rodando MultiQC em ${IN_DIR}..."
# Mais uma mensagem informativa para o usuário.

multiqc "${IN_DIR}" -o "${OUT_DIR}"
# Este é o comando principal:
# - 'multiqc "${IN_DIR}"' diz para o MultiQC procurar arquivos de saída de várias ferramentas
#   (como FastQC) dentro da pasta IN_DIR.
# - '-o "${OUT_DIR}"' diz em qual pasta o relatório do MultiQC deve ser salvo.
# No final, o programa gera um arquivo HTML com o resumo de todas as amostras.

echo "Análise MultiQC concluída."
# Mensagem indicando que o comando terminou sem erros.

echo "Relatório principal: ${OUT_DIR}/multiqc_report.html"
# Informa o caminho completo do arquivo HTML gerado pelo MultiQC.
# É esse arquivo que você deve abrir no navegador para ver os gráficos e tabelas.
```

O MultiQC é usado justamente para agregar vários relatórios de ferramentas como FastQC em um único HTML.

## Como rodar o projeto

### 1. Ativar o ambiente

```bash
conda activate orquideas-qc
```

### 2. Dar permissão aos scripts

```bash
chmod +x scripts/run_fastqc.sh
chmod +x scripts/run_multiqc.sh
```

### 3. Rodar o FastQC

```bash
./scripts/run_fastqc.sh
```

### 4. Rodar o MultiQC

```bash
./scripts/run_multiqc.sh
```

Esse fluxo corresponde ao procedimento básico ensinado em tutoriais introdutórios de QC de reads com FastQC e MultiQC.[web:22][web:64][web:11]  

## Resultados

Depois da execução:

- Os relatórios do FastQC ficarão em:
  - `results/fastqc/`
- O relatório final do MultiQC ficará em:
  - `results/multiqc/multiqc_report.html`

O relatório MultiQC permite comparar várias amostras de uma vez, o que facilita a interpretação do QC.[web:11][web:80][web:81]  

## Observações

## Proximos passos 
- Aprender a interpretar os ralatorios fastqc e multiqc
- Estudarf sobre Trimming e ferramentas de trimming (Trimmomatic, trim galore) e pensar em qual usar no projeto
- Aprender a baixar SRR pelo terminal via SRAtoolkit
Este projeto pode ser reutilizado em outros conjuntos de dados, bastando trocar os arquivos FASTQ na pasta `data/raw/` e ajustar os metadados, se necessário.

# AULA 2 - QC + Trimming

Nesta aula vamos:

Interpretar os relatórios do FastQC e do MultiQC.

Aplicar 3 ferramentas de trimming diferentes ao mesmo conjunto de dados.

Rodar de novo FastQC e MultiQC depois de cada trimming.

Comparar os resultados e discutir qual abordagem faz mais sentido.

Objetivo
Ao final da aula, o aluno deve ser capaz de:

Ler os principais gráficos do FastQC e do MultiQC e dizer se os dados estão “bons o suficiente” para seguir na análise.

Explicar, em termos simples, o que fazem:

Ferramenta 1 (por exemplo, Trimmomatic).

Ferramenta 2 (por exemplo, Cutadapt).

Ferramenta 3 (por exemplo, fastp).

Comparar os efeitos de cada ferramenta no mesmo conjunto de FASTQ (perda de reads, remoção de adaptadores, qualidade por base).

Estrutura do projeto (mantida, com pequenas extensões)
Nome do projeto continua: treinamento_orchid_qc

```
docs/                      # documentos, prints de relatórios e anotações
data/raw/                  # arquivos FASTQ originais (sem trimming)
data/metadata/             # metadados das amostras (metadata.csv)
data/trimmed_trimmomatic/  # FASTQ após trimming com ferramenta 1
data/trimmed_cutadapt/     # FASTQ após trimming com ferramenta 2
data/trimmed_fastp/        # FASTQ após trimming com ferramenta 3
scripts/                   # scripts bash para QC e trimming
results/
  ├── before_trim/
  │   ├── fastqc/          # FastQC antes do trimming
  │   └── multiqc/         # MultiQC antes do trimming
  ├── trimmomatic/
  │   ├── fastqc/          # FastQC pós Trimmomatic
  │   └── multiqc/         # MultiQC pós Trimmomatic
  ├── cutadapt/
  │   ├── fastqc/          # FastQC pós Cutadapt
  │   └── multiqc/         # MultiQC pós Cutadapt
  └── fastp/
      ├── fastqc/          # FastQC pós fastp
      └── multiqc/         # MultiQC pós fastp
README.md                  # resumo da aula
```
Bloco 1 – Revisão e interpretação do FastQC / MultiQC
1.1. Relembrar a execução (já feita)
QC inicial (já feito na Aula 1):

```
conda activate orchid_qc

# QC antes do trimming – pode reutilizar ou repetir
./scripts/run_fastqc.sh        # salva em results/fastqc/
./scripts/run_multiqc.sh       # salva em results/multiqc/
```
Sugestão: para esta aula, renomear esses resultados para results/before_trim/ ou rodar scripts que já gravem nesse caminho.

1.2. O que olhar no FastQC
Orientação para alunos (em docs/aula.md, por exemplo):

Abrir 1 relatório FastQC em HTML.

Focar nos módulos:

Per base sequence quality.

Per sequence GC content.

Adapter content.

Responder em 2–3 frases:

A qualidade geral é boa, média ou ruim?

Há muito adaptador?

1.3. O que olhar no MultiQC
Abrir results/before_trim/multiqc/multiqc_report.html.

Comparar as amostras:

Qual tem pior qualidade média?

Alguma tem muito adaptador?

Bloco 2 – Trimming com 3 ferramentas
Aqui você pode só especificar o objetivo de cada ferramenta, sem ainda mergulhar em todos os parâmetros (isso pode vir em outra aula):

Ferramenta 1 (Trimmomatic): foca em cortar bases de baixa qualidade nas pontas e remover adaptadores com base em um arquivo de adaptadores.

Ferramenta 2 (Cutadapt): foca fortemente em remover adaptadores ou sequências conhecidas nas extremidades.

Ferramenta 3 (fastp): faz trimming, filtragem e QC rápido, tudo em um único comando.

Objetivo didático
Mostrar que, embora todas “cortem” leituras, o efeito final em qualidade, tamanho e número de reads não é idêntico.

Fazer os alunos pensarem em termos de trade-off: limpar vs. perder dados.

Organização de scripts
Sugestão de nomes (dentro de scripts/):

Bloco 3 – Comparação dos resultados
Depois de rodar os scripts:

Abrir os 4 relatórios MultiQC:

results/before_trim/multiqc/multiqc_report.html

results/trimmomatic/multiqc/multiqc_report.html

results/cutadapt/multiqc/multiqc_report.html

results/fastp/multiqc/multiqc_report.html

Para cada ferramenta, pedir que o grupo responda, em docs/tabela_comparacao.md ou similar:

Houve redução de adaptadores?

A qualidade por base ficou melhor?

Quantos reads foram perdidos (aproximadamente)?

No final, cada grupo escolhe:

Qual resultado usaria para seguir a pipeline de RNA‑Seq?

Em uma frase: por quê?
