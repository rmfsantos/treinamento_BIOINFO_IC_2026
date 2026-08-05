# Projeto de Bioinformática com Git e BBDuk

> **Template de apresentação dos resultados**. Preencha com os dados do seu projeto.

## Descrição do projeto

Este projeto aplica Git/GitHub para organizar um fluxo de trabalho em bioinformática com **BBDuk**, usando arquivos FASTQ pareados e registrando os resultados de filtragem de qualidade.

## Objetivo

O objetivo foi remover adaptadores, cortar bases de baixa qualidade e gerar arquivos filtrados para análise posterior, mantendo o projeto versionado de forma reprodutível.

## Dados de entrada

| Campo | Descrição |
|---|---|
| Projeto | [nome do projeto] |
| Aluno | [seu nome] |
| Amostras | [quantidade de amostras] |
| Tipo de dado | FASTQ pareado |
| Origem dos dados | [origem/curso/lab] |
| Data da análise | [data] |

## Fluxo de trabalho

1. Criar a estrutura do projeto.
2. Configurar Git 
3. Rodar o BBDuk nos arquivos FASTQ.
4. Registrar os resultados.
5. Fazer commit e push para o GitHub.

## Comando usado no BBDuk

```bash
bbduk.sh in1=R1.fastq.gz in2=R2.fastq.gz \
  out1=R1_trimmed.fastq.gz out2=R2_trimmed.fastq.gz \
  ref=adapters.fa ktrim=r k=23 mink=11 hdist=1 tpe tbo \
  qtrim=rl trimq=20 minlen=50 \
  stats=bbduk_stats.txt > bbduk_log.txt
```

## Parâmetros principais

| Parâmetro | Função |
|---|---|
| `ktrim=r` | Remove adaptadores na extremidade 3' |
| `k=23` | Tamanho do k-mer usado na comparação |
| `mink=11` | Permite k-mers menores na borda |
| `hdist=1` | Aceita até 1 diferença |
| `tbo` | Usa sobreposição das reads pareadas para trimming |
| `tpe` | Garante trimming equivalente nos pares |
| `qtrim=rl` | Faz corte por qualidade nas duas pontas |
| `trimq=20` | Limite mínimo de qualidade |
| `minlen=50` | Remove reads muito curtas |

## Resultados

### Resumo da execução

| Métrica | Valor |
|---|---|
| Reads de entrada | [número] |
| Reads mantidas | [número] |
| Reads descartadas | [número] |
| Adaptadores detectados | [número/descrição] |
| Comprimento mínimo após trimming | [valor] |
| Arquivo de log | `bbduk_log.txt` |
| Arquivo de estatísticas | `bbduk_stats.txt` |

### Arquivos gerados

| Arquivo | Descrição |
|---|---|
| `R1_trimmed.fastq.gz` | Leitura 1 após filtragem |
| `R2_trimmed.fastq.gz` | Leitura 2 após filtragem |
| `bbduk_log.txt` | Saída do comando BBDuk |
| `bbduk_stats.txt` | Resumo das estatísticas de trimming |

## Interpretação dos resultados

- [Descreva se houve muita perda de reads ou não].
- [Explique se a remoção de adaptadores foi importante].
- [Comente se os arquivos finais ficaram prontos para a etapa seguinte].

## Reprodutibilidade

Para reproduzir este projeto, basta:

1. Clonar o repositório.
2. Instalar o Git e o ambiente Conda.
3. Baixar os FASTQ de entrada.
4. Executar o comando do BBDuk.
5. Conferir os arquivos de saída em `results/`.

## Estrutura do repositório

```text
.
├── data/
├── results/
├── scripts/
├── README.md
└── .gitignore
```

## `.gitignore`

O projeto deve ignorar arquivos grandes e temporários, como FASTQ brutos e logs desnecessários.

```gitignore
*.fastq
*.fastq.gz
*.fq
*.fq.gz
*.tmp
*.log
results/*.bam
results/*.cram
```

## Conclusão

Este projeto demonstrou o uso de Git/GitHub em um fluxo simples e reprodutível de bioinformática, com geração de relatórios e organização dos resultados em um README claro.

## Como apresentar o projeto

Na apresentação, mostre:

1. O objetivo do projeto.
2. Os dados usados.
3. O comando do BBDuk.
4. Os principais resultados.
5. Os arquivos gerados.
6. A estrutura do repositório e o uso do `.gitignore`.

## Checklist final

- [ ] Objetivo descrito
- [ ] Dados de entrada informados
- [ ] Comando BBDuk registrado
- [ ] Resultados resumidos em tabela
- [ ] Arquivos de saída listados
- [ ] Interpretação escrita
- [ ] `.gitignore` incluído
- [ ] Projeto pronto para commit 
