#!/bin/bash

for file in `ls ../htdocs/2*html`
do
    nome=`echo $file | cut -d \/ -f 3 | cut -d\. -f 1`
    grep http $file | cut -d \" -f 2 > urls
    grep http $file | cut -d \" -f 7 | cut -d \> -f 2 | cut -d\< -f 1 > titoli
    paste -d\| urls titoli | sed 's/|/ | /g' > $nome
    rm urls titoli
done
