#Este makefile hacer parte del proyecto CSPA

SRC = ./src
BIN = ./bin
DOC = ./doc

TANGLE = notangle 

cspa.h: CSPA.nw
	notangle -R"Cabezera CSPA" CSPA.nw | cpif $(SRC)/$@

1ejemplo.c: cspa.h CSPA.nw
	$(TANGLE) -L'#line %L "%F" %N' -R"1 Ejemplo" CSPA.nw > $(SRC)/$@

1ejemplo: cspa.h 1ejemplo.c
	gcc -std=c99 -Wall $(SRC)/1ejemplo.c -o $(BIN)/$@

2ejemplo.c: cspa.h CSPA.nw
	$(TANGLE) -R"2 Ejemplo" CSPA.nw > $(SRC)/$@

2ejemplo: cspa.h 2ejemplo.c
	gcc -std=c99 -Wall $(SRC)/2ejemplo.c -o $(BIN)/$@

3ejemplo.c: cspa.h CSPA.nw
	$(TANGLE) -R"3 Ejemplo" CSPA.nw > $(SRC)/$@

3ejemplo: cspa.h 3ejemplo.c
	gcc -std=c99 -Wall $(SRC)/3ejemplo.c -o $(BIN)/$@

adivina_el_numero.c: cspa.h CSPA.nw
	$(TANGLE) -R"Adivina el n\'\''umero" CSPA.nw > $(SRC)/$@

adivina_el_numero: cspa.h adivina_el_numero.c
	gcc -std=c99 -Wall $(SRC)/adivina_el_numero.c -o $(BIN)/$@

puja_y_empuja.c: cspa.h CSPA.nw
	$(TANGLE) -R"Puja y Empuja" CSPA.nw > $(SRC)/$@

puja_y_empuja: puja_y_empuja.c
	gcc -std=c99 -Wall $(SRC)/$< -o $(BIN)/$@

raton_alzado.c: cspa.h CSPA.nw
	$(TANGLE) -L'#line %L "%F"%N' -R"raton\_alzado.c" CSPA.nw > $(SRC)/$@

raton_alzado: raton_alzado.c
	gcc -std=c99 -lSDL -Wall $(SRC)/$< -o $(BIN)/$@

doc: CSPA.nw
#noweave -filter 'awk -f flisting.awk' -delay CSPA.nw | sed 's/\\{/{/g' | sed 's/\\}/}/g'  > $(SRC)/CSPA.tex
	noweave  -delay CSPA.nw > $(SRC)/CSPA.tex	
	pdflatex -output-directory $(DOC) $(SRC)/CSPA.tex


ayuda:
	echo "make help #muestra esta ayuda"
	echo "make doc #genera documentacion"
	echo "make all #compila todos los ejemplos"

all: raton_alzado puja_y_empuja adivina_el_numero 3ejemplo 2ejemplo 1ejemplo
