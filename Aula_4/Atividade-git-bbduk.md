# Atividade Prática — Git 

**Objetivo:** exercício prático de filtragem de qualidade com **BBDuk**, usando os dados já baixados pela turma, e praticando os comandos básicos de Git.

---

## Passo 0 — Instalar o Git e configurar sua identidade

### Instalação (Linux/Ubuntu)

Abra o terminal e execute:

```bash
sudo apt update
sudo apt install git
```

Confirme que a instalação funcionou:

```bash
git --version
```

### Configurar nome e e-mail

Antes do primeiro commit, configure seu nome e e-mail. Isso é feito uma única vez por máquina:

```bash
git config --global user.name "Seu Nome"
git config --global user.email "seu-email@exemplo.com"
```

Confira o que foi salvo:

```bash
git config --list
```

> Se você pular esse passo, o Git vai reclamar na hora do commit com a mensagem **"Please tell me who you are"**.

### Criando seu primeiro commit

1. Entre na pasta do projeto ou crie uma nova pasta:

```bash
mkdir treinamento_git
cd treinamento_git
```

2. Crie a estrutura inicial do projeto:

```bash
mkdir data scripts results
```

3. Crie um arquivo `README.md`.
4. Adicione um arquivo de transcriptoma `.fastq` pareado das aulas anteriores na pasta `data/`.
5. Inicialize o Git na pasta, se ainda não for um repositório clonado:

```bash
git init
```

6. Verifique o que o Git está vendo:

```bash
git status
```

7. Adicione os arquivos à área de preparação:

```bash
git add .
```

8. Faça o primeiro commit:

```bash
git commit -m "Primeiro commit: criada estrutura do projeto"
```

9. Confira o estado final:

```bash
git status
```

Pronto — esse é o primeiro commit local, salvo no histórico do repositório.

---

## Passo 1 — Pré-requisitos

Antes de rodar o BBDuk, confirme que você tem:

- Dados de sequenciamento FASTQ já baixados na pasta do projeto.
- Um ambiente Conda criado para o BBDuk.
- O BBDuk instalado corretamente.

Exemplo de ambiente:

```bash
conda create -n bbduk_env
conda activate bbduk_env
```

---

## Passo 2 — Rodar o BBDuk nos dados

Dentro da pasta com os arquivos FASTQ, rode:

```bash
bbduk.sh in1=R1.fastq.gz in2=R2.fastq.gz \
  out1=R1_trimmed.fastq.gz out2=R2_trimmed.fastq.gz \
  ref=adapters.fa ktrim=r k=23 mink=11 hdist=1 tpe tbo \
  qtrim=rl trimq=20 minlen=50 \
  stats=bbduk_stats.txt > bbduk_log.txt
```

### O que cada parte faz

| Parâmetro | Função |
|---|---|
| `ktrim=r k=23 mink=11 hdist=1` | Remove adaptadores na ponta 3', permitindo 1 mismatch |
| `tbo` / `tpe` | Usa sobreposição das reads pareadas para trimming mais preciso |
| `qtrim=rl trimq=20` | Corta bases de baixa qualidade nas duas pontas (Q<20) |
| `minlen=50` | Descarta reads menores que 50 pb após o trim |
| `stats=` | Gera relatório de adaptadores encontrados |

Confira o resultado:

```bash
cat bbduk_stats.txt
```

---

## Passo 3 — Tarefa final

Agora você deve:

- Fazer o commit informando que o BBDuk foi realizado.
- Criar um arquivo `.gitignore` para não enviar os arquivos `.fastq`.
- Criar um repositório no GitHub e subir o projeto `treinamento_git`.


Exemplo de `.gitignore`:

```gitignore
# Dados brutos
*.fastq
*.fastq.gz
*.fq
*.fq.gz

# Resultados pesados
results/*.bam
results/*.cram
results/*.fastq
results/*.fastq.gz

# Arquivos temporários
*.tmp
*.log

# Ambiente Conda
.env/
conda/
```

Exemplo de commit final:

```bash
git add bbduk_stats.txt bbduk_log.txt .gitignore
git commit -m "Adiciona resultados do BBDuk e .gitignore"
```

> **Atenção:** não adicione arquivos FASTQ grandes (>50 MB quebra o repositório). Versione apenas os resultados, scripts e README. Todo projeto deve ter seu `.gitignore`.

### Adicionar rmfsantos@uefs.br como colborador (dar permissão edicao e leitura)


## Checklist final

- [ ] Git instalado e configurado
- [ ] Estrutura do projeto criada
- [ ] Primeiro commit realizado
- [ ] Ambiente Conda criado
- [ ] BBDuk executado com sucesso
- [ ] `bbduk_stats.txt` e `bbduk_log.txt` gerados
- [ ] `.gitignore` criado
- [ ] Repositório no GitHub criado
- [ ] Projeto enviado para o GitHub
