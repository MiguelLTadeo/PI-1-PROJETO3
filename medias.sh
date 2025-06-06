#!/bin/bash

function help(){
    echo "Uso: $0 <arquivo.csv>"
    echo "Calcular a média"
    echo "  ex: ./medias.sh resultados_bubblesort_c_1000.csv"
}

if [ "$#" -ne 1 ]; 
then
    echo "Erro: numero incorreto de parâmetros."
    help
    exit 1
fi

arquivo_csv=$1

if [ ! -f "$arquivo_csv" ]; 
then
    echo "Erro: O arquivo '$arquivo_csv' não foi encontrado."
    help
    exit 1
fi

echo "Analisando o arquivo: $arquivo_csv"

soma_tempos="0"
num_linhas=0
linha_atual=0

while read linha; 
do
    ((linha_atual++))

    if [ "$linha_atual" -eq 1 ]; 
        then
        continue
    fi

    tempo=$(echo "$linha" | cut -d ',' -f 2)
    soma_tempos=$(echo "$soma_tempos + $tempo" | bc -l)
    ((num_linhas++))

done < "$arquivo_csv"

if [ "$num_linhas" -gt 0 ]; then
    media=$(echo "scale=6; $soma_tempos / $num_linhas" | bc -l)

    
    echo "  Amostras de tempo coletadas: $num_linhas "
    echo "  Soma total dos tempos: ${soma_tempos}s, média dos tempos:${media}s"

else
    echo "Nenhuma linha encontrada"
fi