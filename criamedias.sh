#!/bin/bash

mostrar_uso() {
  echo "Uso: $0 -l <linguagem> -a <algoritmo>"
  echo "  Exemplos:"
  echo "    $0 -l c -a merge"
  echo "    $0 -l python -a bubble"
  exit 1
}

escolhe_prog() {
    if [ "$linguagem" != "c" ] && [ "$linguagem" != "python" ]; 
      then
        echo "Linguagem inválida. Use 'c' ou 'python'." >&2
        exit 1
    fi  
}

escolhe_algoritmo() {
    if [ "$algoritmo" != "merge" ] && [ "$algoritmo" != "bubble" ]; 
      then
        echo "Algoritmo inválido. Use 'merge' ou 'bubble'." >&2
        exit 1
    fi  
}

linguagem=""
algoritmo=""

while getopts "l:a:" opt; do
  case $opt in
    l) linguagem="$OPTARG" ;;
    a) algoritmo="$OPTARG" ;;
    *) mostrar_uso ;;
  esac
done

if [ -z "$linguagem" ] || [ -z "$algoritmo" ]; 
    then
        echo "Erro: Parâmetros -l (linguagem) e -a (algoritmo) são obrigatórios."
        mostrar_uso
        exit 1
fi

escolhe_algoritmo && escolhe_prog

mkdir -p medias/

ARQUIVO_MEDIAS="medias/${linguagem}${algoritmo}medias.csv"

PROGRAMA="./executaProg.sh" 

ENTRADAS="10 100 1000 10000 100000 1000000"

if [ ! -f "$PROGRAMA" ]; 
    then
        echo "Erro: O programa executável '$PROGRAMA' não foi encontrado."
        exit 1
fi

if [ ! -f "$ARQUIVO_MEDIAS" ]; 
    then
        echo "entrada;tempo" > "$ARQUIVO_MEDIAS"
fi

for entrada in $ENTRADAS
do
  if grep -q "^${entrada};" "$ARQUIVO_MEDIAS"; 
    then
        echo "Entrada $entrada já existe. Pulando."
  else
    echo "Entrada $entrada não encontrada. Executando programa..."

    RESULTADO=$($PROGRAMA -l $linguagem -a $algoritmo -n 10 -t $entrada | tail -n 1)

    echo "${RESULTADO}" >> "$ARQUIVO_MEDIAS"

    echo "Nova linha '${RESULTADO}' inserida."
  fi
done
