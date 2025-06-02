#!/bin/bash

linguagem=""
algoritmo=""
execucoes=0
entrada=0

mostrar_uso() {
  echo "Uso: $0 -l <c|python> -a <merge|bubble> -n <numero> -t <arquivo_entrada>"
  exit 1
}

while getopts "l:a:n:t:" opt; do
  case $opt in
    l)
    linguagem="$OPTARG"
      ;;
    a)
    algoritmo="$OPTARG"
      ;;
    n)
    execucoes="$OPTARG"
      ;;
    t)
    entrada="$OPTARG"
      ;;
    \?)
    echo "Opção inválida!";;
    :)  
    echo "Opção -$OPTARG requer um argumento." >&2
      mostrar_uso
      ;;
    
  esac
done

escolhe_algoritmo() {
    if [ "$algoritmo" = "merge" ]; then
        echo "mergesort"
    elif [ "$algoritmo" = "bubble"]; then
        echo "bubblesort"
    else
        echo "algoritmo inválido"
    fi  
}



escolhe_linguagem() {
    if [ "$linguagem" = "c" ]; then
        python3 escolhe_algoritmo.py $entrada
    elif [ "$linguagem" = "python" ]; then
        gcc escolhe_algoritmo.c -o run && ./run $entrada
    else
        echo "linguagem inválida"
    fi  
}

