# Atividade Prática — Git colaborativo com BBDuk

**Objetivo:** aplicar o fluxo de branch + Pull Request no GitHub, usando como exercício prático a filtragem de qualidade (BBDuk) do conjunto de dados que sua equipe já baixou.

**Organização:** Cada aluno trabalha na sua própria branch.

---

## Passo 0 — Instalar o Git e configurar sua identidade

### Instalação (Linux/Ubuntu)

Abra o terminal e execute 

```bash
sudo apt update
sudo apt install git
```

Confirme que a instalação funcionou:

```bash
git --version
```

### Configurar nome e e-mail (obrigatório antes do 1º commit)

O Git grava seu nome e e-mail em todo commit que você faz, então essa configuração é feita uma única vez por máquina, de forma global 

```bash
git config --global user.name "Seu Nome"
git config --global user.email "seu-email@exemplo.com"
```

Confira o que foi salvo:

```bash
git config --list
```

> Se você pular esse passo, o Git vai bloquear (ou reclamar) na hora do commit pedindo "Please tell me who you are" 

### Criando seu primeiro commit

1. Entre na pasta do seu projeto (ou clone o repositório do treinamento):
```bash
cd treinamento_bioinfo
```
2. Inicialize o Git na pasta (só se ainda não for um repositório clonado):
```bash
git init
```
3. Crie ou edite um arquivo, por exemplo um `README.md`.
4. Verifique o que o Git está vendo:
```bash
git status
```
5. Adicione o arquivo à área de preparação (staging):
```bash
git add README.md
```
6. Confirme a mudança com uma mensagem clara:
```bash
git commit -m "Primeiro commit: adiciona README do projeto"
```

Pronto — esse é seu primeiro commit local, salvo no histórico do repositório.

---

## Passo 0 — Pré-requisitos

- Repositório já clonado localmente (`git clone ...`).
- Dados de sequenciamento (FASTQ) já baixados na pasta do projeto.
- instalar bbduk - Criar env conda 

---

## Passo 1 — Criar sua branch

Cada aluno cria uma branch com seu nome (troque `N` pelo seu nome):

```bash
git checkout -b nome-bbduk
```

Confirme que está na branch nova:

```bash
git status
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

**O que cada parte faz:**

| Parâmetro | Função |
|---|---|
| `ktrim=r k=23 mink=11 hdist=1` | Remove adaptadores na ponta 3', permitindo 1 mismatch |
| `tbo` / `tpe` | Usa sobreposição das reads pareadas para trim mais preciso |
| `qtrim=rl trimq=20` | Corta bases de baixa qualidade nas duas pontas (Q<20) |
| `minlen=50` | Descarta reads menores que 50 pb após o trim |
| `stats=` | Gera relatório de adaptadores encontrados |

Confira o resultado:

```bash
cat bbduk_stats.txt
```

---

## Passo 3 — Versionar os resultados

**Atenção:** não adicione arquivos FASTQ grandes (>50 MB quebra o repositório). Versione apenas os relatórios:

```bash
git add bbduk_stats.txt bbduk_log.txt
git commit -m "Adiciona resultados de trimming com BBDuk - equipe N"
```

---

## Passo 4 — Enviar a branch para o GitHub

```bash
git push -u origin nome-bbduk
```

---

## Passo 5 — Abrir o Pull Request (PR)

1. Acesse o repositório no navegador.
2. Vai aparecer um banner amarelo "equipe-N-bbduk had recent pushes" → clique em **Compare & pull request**.
   - Se não aparecer, vá em **Pull requests → New pull request** e selecione sua branch como *compare* e a branch principal como *base*.
3. Escreva um título (ex: "BBDuk - Equipe N") e uma descrição curta explicando os parâmetros usados.
4. Clique em **Create pull request**.

Pronto — o professor será notificado e vai revisar, comentar ou aprovar o merge.

---

## Passo 6 — Adicionar o professor como colaborador (só precisa ser feito uma vez por equipe)

1. No repositório, vá em **Settings → Collaborators**.
2. Clique em **Add people**.
3. Digite o usuário, nome ou e-mail do GitHub do professor e selecione o resultado correto.
4. Clique em **Add [usuário] to this repository**.
5. O professor vai receber um convite por e-mail/notificação e precisa aceitá-lo.

---

## Checklist final de cada equipe

- [ ] Branch `nome-bbduk` criada
- [ ] BBDuk executado com sucesso
- [ ] `bbduk_stats.txt` e `bbduk_log.txt` commitados
- [ ] Branch enviada com `git push`
- [ ] Pull Request aberto
- [ ] Professor adicionado como colaborador
</content>
