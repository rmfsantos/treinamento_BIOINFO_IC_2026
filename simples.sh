#!/bin/bash

# $1 - nome pasta, $2 - url

mkdir $1 # crio pasta 
cd $1    # entro na pasta
echo 'Iniciando Download .. '
wget -r -c -np -nd $2
gunzip *.gz
cd ..    # saio da pasta
echo 'Iniciando Análise.. '
ls $1 > $1/Analise.dat # coloco o nome do arquivo
./conteudoGC.sh $1/* >> $1/Analise.dat #salvo resultado da análise
