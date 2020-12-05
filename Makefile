all: lualatex-test.pdf xelatex-test.pdf

lualatex-test.pdf: build.txt lualatex-test.tex
	docker run --rm  -v $$PWD:/workdir -it alpine-texlive-ja-modern \
	latexmk \
	-e '$$latex=q/lualatex %O -synctex=1 -interaction=nonstopmode -file-line-error %S/' \
	-e '$$bibtex=q/upbibtex %O %B/' \
	-e '$$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/' \
	-e '$$makeindex=q/upmendex %O -o %D %S/' \
	-norc -gg -pdflua lualatex-test.tex
	find . -type f -name "*.toc" -o -name "*.out" | xargs -I{} rm {}
	rm *.log *.aux *.fls *.fdb_latexmk

xelatex-test.pdf: build.txt xelatex-test.tex
	docker run --rm -v $$PWD:/workdir -it  alpine-texlive-ja-modern \
	latexmk \
	-e '$$latex=q/xelatex %O -synctex=1 -interaction=nonstopmode -file-line-error %S/' \
	-e '$$bibtex=q/upbibtex %O %B/' \
	-e '$$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/' \
	-e '$$makeindex=q/upmendex %O -o %D %S/' \
	-norc -gg -pdfxe xelatex-test.tex
	find . -type f -name "*.toc" -o -name "*.out" | xargs -I{} rm {}
	rm *.log *.aux *.fls *.fdb_latexmk *.xdv

build.txt: Dockerfile
	docker build -t alpine-texlive-ja-modern ./
	docker inspect alpine-texlive-ja-modern:latest |
	grep Id |
	awk -F:  '{print $$3}' |
	awk -F\" '{print $$1}' > build.txt

.PHONY clean:
	rm *.pdf *.synctex.gz
	docker rmi $$(build.txt)
	rm build.txt