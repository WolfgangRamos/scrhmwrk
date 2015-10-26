pdf: bibliography index scrhmwrk.dtx
	pdflatex scrhmwrk.dtx

ctan_zip: pdf scrhmwrk.dtx

bibliography: scrhmwrk.bib scrhmwrk.dtx init
	biber scrhmwrk

init: scrhmwrk.dtx cls
	pdflatex scrhmwrk.dtx

index: scrhmwrk.dtx scrhmwrk.idx
	pdflatex scrhmwrk.dtx
	pdflatex scrhmwrk.dtx
	sed -i '/[_]*!\^[_]*/d' scrhmwrk.idx # clean index
	makeindex -s gind.ist -o scrhmwrk.ind scrhmwrk.idx

cls: scrhmwrk.ins scrhmwrk.dtx
	latex scrhmwrk.ins
