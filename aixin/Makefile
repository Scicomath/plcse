aixin: aixin.c
	gcc -O3 -o aixin aixin.c -lcuba -lgsl -lgslcblas -lm
aixin.c: aixin.w
	ctangle aixin.w
aixin.tex: aixin.w
	cweave aixin.w
aixin.pdf: aixin.tex
	xelatex aixin.tex
