SHELL=/bin/bash

all: analysebenchmark analyseresults tables plots
	
# Prints statistics on the benchmark
analysebenchmark:
	(cd Rscripts && Rscript analysebenchmark.r)

# Prints statistics on the results
analyseresults:
	(cd Rscripts && Rscript analyseresults.r)

# Print tables describing benchmark and results in tables/	
tables:
	mkdir tables
	(cd Rscripts && Rscript makecategorisationtable.r)
	(cd Rscripts && Rscript makeresultstable.r)	

# Print plots describing benchmark in plots/
plots:
	mkdir plots
	(cd Rscripts && Rscript makebenchmarkplots.r)
	
clean: 
	rm -rf plots/
	rm -rf tables/