SCHEMES=Bones Chez Chibi Chicken5 Chicken5CSI Foment GambitC Gauche Guile IronScheme Kawa Larceny Loko MIT Petite Picrin Bigloo Racket Rhizome RScheme S7 S9fES Sagittarius Scheme48 Stalin TinyScheme Ypsilon Cyclone Femtolisp Gerbil SISC

.PHONY: csv clean all
.SILENT: results2csv

doc:
	echo Run make all to run all tests
csv: all.csv

all.csv:
	grep -a -h '+!CSVLINE' results.* | sed 's/+!CSVLINE!+//' > all.csv

html: index.html benchmark.html csv

index.html: all.csv
	mit-scheme --load "graph.scm" --eval '(%exit 0)'

results2csv:
	./results2csv.sh $(SCHEMES)

clean:
	rm -f results.* all.csv outputs/*

chicken-dependencies:
	chicken-install r7rs srfi-1 srfi-13 srfi-14 srfi-69

include Makefile.schemes
