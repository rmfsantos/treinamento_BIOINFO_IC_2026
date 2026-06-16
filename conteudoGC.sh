#!/bin/bash

GC=`grep '^[^>]' $1 | grep -o  '[GC]' | wc -l`
AT=`grep '^[^>]' $1 | grep -o '[AT]' | wc -l`
tot=$(($GC+$AT))
perc=$(($GC*100/$tot))
echo O percentual GC é de $perc %

