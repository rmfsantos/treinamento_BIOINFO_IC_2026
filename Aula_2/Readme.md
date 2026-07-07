# Treinamento_IC_Aula3 – Interpretação do QC e Trimming com 3 Ferramentas

Nesta aula vamos:

- Entender melhor os relatórios do **FastQC** e **MultiQC**.
- Aplicar **3 ferramentas de trimming** (Trimmomatic, Cutadapt e fastp) ao mesmo conjunto de dados.
- Rodar novamente FastQC e MultiQC após cada trimming.
- Comparar os efeitos de cada ferramenta e discutir vantagens e limitações.

## 1. Objetivos da aula

Ao final desta aula, você deve ser capaz de:

- Ler os principais gráficos do FastQC e do MultiQC e identificar:
  - Qualidade por base.
  - Conteúdo GC.
  - Presença de adaptadores.
- Explicar, em termos simples, o que fazem:
  - **Trimmomatic** (trimming clássico com regras).
  - **Cutadapt** (focado em adaptadores).
  - **fastp** (trimming moderno “tudo em um”).
- Comparar as saídas das três ferramentas no mesmo conjunto de FASTQ:
  - Quanto de adaptador foi removido.
  - Quanto de leitura foi perdida.
  - Se a qualidade por base melhorou ou não.

## 2. Estrutura do projeto

```text
treinamento_orchid_qc/
├── docs/
│   ├── aula2_qc.md
│   └── aula3_trimming.md      # este arquivo (opcional)
├── data/
│   ├── raw/                   # FASTQ originais (sem trimming)
│   ├── metadata/              # metadata.csv
│   ├── trimmed_trimmomatic/   # FASTQ após Trimmomatic
│   ├── trimmed_cutadapt/      # FASTQ após Cutadapt
│   └── trimmed_fastp/         # FASTQ após fastp
├── results/
│   ├── before_trim/
│   │   ├── fastqc/
│   │   └── multiqc/
│   ├── trimmomatic/
│   │   ├── fastqc/
│   │   └── multiqc/
│   ├── cutadapt/
│   │   ├── fastqc/
│   │   └── multiqc/
│   └── fastp/
│       ├── fastqc/
│       └── multiqc/
└── scripts/
    ├── 01_run_fastqc_raw.sh
    ├── 02_run_multiqc_raw.sh
    ├── 03_trim_trimmomatic.sh
    ├── 04_trim_cutadapt.sh
    ├── 05_trim_fastp.sh
    ├── 06_run_fastqc_trimmomatic.sh
    ├── 07_run_multiqc_trimmomatic.sh
    ├── 08_run_fastqc_cutadapt.sh
    ├── 09_run_multiqc_cutadapt.sh
    ├── 10_run_fastqc_fastp.sh
    └── 11_run_multiqc_fastp.sh
```

## 3. Programas necessários

Antes de começar, é preciso ter instalado:

- VS Code
- Conda (Miniconda ou Mambaforge)
- FastQC
- MultiQC
- Trimmomatic
- Cutadapt
- fastp

Essas ferramentas são amplamente usadas em fluxos introdutórios de QC e pré-processamento de RNA-Seq.[1][2][3][4]

## 4. Como criar o ambiente

No terminal, dentro da pasta do projeto:

```bash
# cria o ambiente
conda create --name orchid_qc -y

# ativa o ambiente
conda activate orchid_qc

# instala as ferramentas principais
conda install -y fastqc multiqc trimmomatic cutadapt fastp

# checa se tudo foi instalado
fastqc --version
multiqc --version
cutadapt --version
fastp --version
```

O uso de Conda para instalar FastQC, MultiQC e ferramentas de trimming é uma prática comum em treinamentos de RNA-Seq.[5][6][7]

## 5. Dados de entrada

Os arquivos FASTQ originais devem estar em:

```text
data/raw/
```

Exemplo:

```text
data/raw/SRR8175630.fastq.gz
data/raw/SRR8175637.fastq.gz
data/raw/SRR8175650.fastq.gz
```

Se quiser, mantenha também uma tabela de metadados em:

```text
data/metadata/metadata.csv
```

## 6. Revisão do QC antes do trimming

### 6.1. Rodar FastQC e MultiQC nos dados brutos

```bash
conda activate orchid_qc
bash scripts/01_run_fastqc_raw.sh
bash scripts/02_run_multiqc_raw.sh
```

Relatório principal:

```text
results/before_trim/multiqc/multiqc_report.html
```

O fluxo FastQC → MultiQC é o padrão para resumir a qualidade inicial de reads antes de decidir se trimming é necessário.[8][9][10]

### 6.2. O que observar no relatório

Abrir o relatório do MultiQC e responder:

- A qualidade por base parece boa?
- Existe sinal de adaptadores?
- Alguma amostra parece claramente pior?

Também é importante abrir pelo menos um relatório individual do FastQC para observar módulos como **Per base sequence quality**, **Per sequence GC content** e **Adapter content**.[9][1]

## 7. Trimming com 3 ferramentas

Nesta aula, o mesmo conjunto de dados será processado com três ferramentas diferentes.

### 7.1. Trimmomatic

Script:

```text
scripts/03_trim_trimmomatic.sh
```

Execução:

```bash
conda activate orchid_qc
bash scripts/03_trim_trimmomatic.sh
```

Saída:

```text
data/trimmed_trimmomatic/
```

Trimmomatic é uma ferramenta clássica de trimming baseada em regras para qualidade, tamanho mínimo e remoção de adaptadores.[11][7][4]

### 7.2. Cutadapt

Script:

```text
scripts/04_trim_cutadapt.sh
```

Execução:

```bash
conda activate orchid_qc
bash scripts/04_trim_cutadapt.sh
```

Saída:

```text
data/trimmed_cutadapt/
```

Cutadapt é amplamente usado quando o foco principal é remover adaptadores e sequências conhecidas nas extremidades das reads.[12][4]

### 7.3. fastp

Script:

```text
scripts/05_trim_fastp.sh
```

Execução:

```bash
conda activate orchid_qc
bash scripts/05_trim_fastp.sh
```

Saída:

```text
data/trimmed_fastp/
```

fastp combina trimming, filtragem e geração de relatórios em uma única ferramenta, sendo muito usado em pipelines modernos.[2][13][14]

## 8. QC após cada trimming

Depois do trimming, cada conjunto deve passar novamente por FastQC e MultiQC.

### 8.1. Pós-Trimmomatic

```bash
conda activate orchid_qc
bash scripts/06_run_fastqc_trimmomatic.sh
bash scripts/07_run_multiqc_trimmomatic.sh
```

Relatório:

```text
results/trimmomatic/multiqc/multiqc_report.html
```

### 8.2. Pós-Cutadapt

```bash
conda activate orchid_qc
bash scripts/08_run_fastqc_cutadapt.sh
bash scripts/09_run_multiqc_cutadapt.sh
```

Relatório:

```text
results/cutadapt/multiqc/multiqc_report.html
```

### 8.3. Pós-fastp

```bash
conda activate orchid_qc
bash scripts/10_run_fastqc_fastp.sh
bash scripts/11_run_multiqc_fastp.sh
```

Relatório:

```text
results/fastp/multiqc/multiqc_report.html
```

A comparação entre QC antes e depois do trimming é um procedimento didático central em cursos de pré-processamento de RNA-Seq.[1][2][3]

## 9. Atividade de comparação

Abrir os quatro relatórios MultiQC:

1. `results/before_trim/multiqc/multiqc_report.html`
2. `results/trimmomatic/multiqc/multiqc_report.html`
3. `results/cutadapt/multiqc/multiqc_report.html`
4. `results/fastp/multiqc/multiqc_report.html`

Depois, preencher uma tabela comparativa.

### Modelo de tabela

| Ferramenta | Adaptador diminuiu? | Qualidade melhorou? | Houve perda de reads? | Comentário do grupo |
|------------|----------------------|---------------------|-----------------------|---------------------|
| Sem trimming |                      |                     |                       |                     |
| Trimmomatic |                      |                     |                       |                     |
| Cutadapt    |                      |                     |                       |                     |
| fastp       |                      |                     |                       |                     |

Perguntas para discussão:

- Qual ferramenta removeu mais adaptadores?
- Qual ferramenta perdeu mais reads?
- Qual ferramenta pareceu mais equilibrada?
- Qual conjunto de dados você usaria para seguir para alinhamento?

A comparação entre ferramentas diferentes é útil para mostrar que trimming envolve escolhas metodológicas e trade-offs.[1][2][13]

## 10. Próximos passos

Depois desta aula, os próximos temas podem ser:

- Escolher uma estratégia final de trimming para o projeto.
- Aprender a baixar dados diretamente pelo terminal com SRA Toolkit.
- Preparar a próxima etapa de RNA-Seq, como alinhamento ou pseudoalinhamento.

Materiais de treinamento de RNA-Seq normalmente seguem essa sequência: QC, trimming/preprocessamento e depois alinhamento/quantificação.[15][16][17]
