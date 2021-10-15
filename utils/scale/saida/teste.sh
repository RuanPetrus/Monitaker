#!/bin/bash

for n in {1..11};
do
    #Capturando o resultado
    arquivo_path="hero$n.bmp.s"
    saida_path="hero$n.data"
    mv $arquivo_path $saida_path 

done
    
