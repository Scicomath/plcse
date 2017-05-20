aixin-new.pdf: aixin-new.tex fig1.eps fig2.eps fig3.eps fig4.eps fig5.eps
	xelatex aixin-new.tex
diff.pdf: diff.tex
	xelatex diff.tex
diff.tex: aixin-new.tex aixin-old.tex
	latexdiff --encoding=ascii aixin-old.tex aixin-new.tex > diff.tex
