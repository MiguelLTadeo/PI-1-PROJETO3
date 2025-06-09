#!/bin/bash

linguagem=""
algoritmo=""
execucoes=0
entrada=0
soma_total=0.0

mostrar_uso() {
  echo "Uso: $0 -l <c|python> -a <merge|bubble> -n <execucoes> -t <entrada>"
  exit 1
}

while getopts "l:a:n:t:" opt; do
  case $opt in
    l) linguagem="$OPTARG" ;;
    a) algoritmo="$OPTARG" ;;
    n) execucoes="$OPTARG" ;;
    t) entrada="$OPTARG" ;;
    \?) echo "Opção inválida!"; mostrar_uso ;;
    :) echo "Opção -$OPTARG requer um argumento." >&2; mostrar_uso ;;
  esac
done

if [ -z "$linguagem" ] || [ -z "$algoritmo" ] || [ -z "$entrada" ]; then
  echo "Erro: Faltam argumentos obrigatórios!" >&2
  mostrar_uso
fi

escolhe_algoritmo() {
    if [ "$algoritmo" != "merge" ] && [ "$algoritmo" != "bubble" ]; then
        echo "Algoritmo inválido. Use 'merge' ou 'bubble'." >&2
        return 1
    fi  
}

executa_prog() {
    if [ "$linguagem" = "python" ]; then
        for ((i=1; i<=execucoes; i++))
        do
            valor_atual=$( python3 "${algoritmo}sort.py" "$entrada" | awk -F '[;)]' '{print $2}' )
            soma_total=$( echo "$soma_total + $valor_atual" | bc )
            echo "Contagem: $i"
        done
        MEDIA=$( echo "scale=4; $soma_total / $execucoes" | bc )
        echo $MEDIA
    elif [ "$linguagem" = "c" ]; then
        gcc "${algoritmo}sort.c" -o run
        for ((i=1; i<=execucoes; i++))
        do
            valor_atual=$( ./run "$entrada" | awk -F '[;)]' '{print $2}' )
            soma_total=$( echo "$soma_total + $valor_atual" | bc )
            echo "Contagem: $i"
        done
        MEDIA=$( echo "scale=4; $soma_total / $execucoes" | bc )
        echo $MEDIA
    else
        echo "Linguagem inválida. Use 'c' ou 'python'." >&2
        return 1
    fi  
}

# Chamada das funções
escolhe_algoritmo && executa_prog