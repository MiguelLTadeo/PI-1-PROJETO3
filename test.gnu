
set xrange [0:1000]
set yrange [0:1000]


set title "Linha vertical em x = 5"
set grid


plot '-' using 1:2 with lines title 'x = y' lc rgb "red" lw 1
0 0
10 1000
e
