set terminal png size 1024,768

set output 'grafico.png'

set title "Grafico Tempo x Entradas"

set datafile separator ";"

set grid

set xlabel "Tamanho da Entrada (N)"
set ylabel "Tempo Médio de Execução (segundos)"


set logscale x

# quando a gente for gerar o código tem que conferir o nome dos arquivos
# coluna 1 eixo x e coluna 2 eixo y
# linespoints pra conectar os pontos gerados

plot \
    'medias/cbubblemedias.csv' using 1:2 with linespoints smooth bezier linewidth 2 title 'BubbleSort (C)', \
    'medias/cmergemedias.csv' using 1:2 with linespoints smooth bezier linewidth 2 title 'MergeSort (C)', \
    'medias/pythonbubblemedias.csv' using 1:2 with linespoints smooth bezier linewidth 2 title 'BubbleSort (Python)', \
    'medias/pythonmergemedias.csv' using 1:2 with linespoints smooth bezier linewidth 2 title 'MergeSort (Python)'

set output
