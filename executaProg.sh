#!/bin/bash

linguagem=""
algoritmo=""
execucoes=0
entrada=0
soma_total=0

mostrar_uso() {
  echo "Uso: $0 -l <c|python> -a <merge|bubble> -n <execucoes> -t <entrada>"
  exit 1
}

escolhe_algoritmo() {
    if [ "$algoritmo" != "merge" ] && [ "$algoritmo" != "bubble" ]; 
      then
        echo "Algoritmo inválido. Use 'merge' ou 'bubble'." >&2
        exit 1
    fi  
}

escolhe_prog() {
    if [ "$linguagem" != "c" ] && [ "$linguagem" != "python" ]; 
      then
        echo "Linguagem inválida. Use 'c' ou 'python'." >&2
        exit 1
    fi  
}

executa_programa() {
        comando=()
        diretoriolog="${algoritmo}${linguagem}/"

        mkdir -p "$diretoriolog"

        arquivolog="${diretoriolog}/${entrada}.csv"

        > "$arquivolog"

        if [ "$linguagem" = "c" ]; then
          gcc "${algoritmo}sort.c" -o run
          comando=("./run" "$entrada")
        elif [ "$linguagem" = "python" ]; then
          comando=("python3" "${algoritmo}sort.py" "$entrada")
        fi

        for ((i=1; i<=execucoes; i++))
          do
            valor_atual=$( "${comando[@]}" | cut -d ';' -f2)

            echo $valor_atual>>"$arquivolog"
            
            echo $valor_atual

            soma_total=$(echo "$soma_total + $valor_atual" | bc -l)

            echo "Contagem: $i"
          done
        
        MEDIA=$(echo "scale=6; $soma_total / $execucoes" | bc -l)

        echo "${entrada};${MEDIA}"
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

if [ -z "$linguagem" ] || [ -z "$algoritmo" ] || [ -z "$entrada" ];
  then
    echo "Erro: Faltam argumentos obrigatórios!" >&2
    mostrar_uso
fi

escolhe_algoritmo && escolhe_prog && executa_programa