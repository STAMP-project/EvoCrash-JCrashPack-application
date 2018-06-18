SHELL=/bin/bash

all: analysebenchmark analyseresults tables plots rqs
	
# Prints statistics on the benchmark
analysebenchmark:
	(cd Rscripts && Rscript analysebenchmark.r)

# Prints statistics on the results
analyseresults:
	(cd Rscripts && Rscript analyseresults.r)

# Print tables describing benchmark and results in tables/	
tables:
	mkdir -p tables
	(cd Rscripts && Rscript makebenchmarktables.r)
	(cd Rscripts && Rscript makecategorisationtable.r)
	(cd Rscripts && Rscript makeresultstable.r)	

# Print plots describing benchmark in plots/
plots:
	mkdir -p plots
	(cd Rscripts && Rscript makebenchmarkplots.r)
	
rqs:
	mkdir -p tables
	mkdir -p plots
	(cd Rscripts && Rscript rq1.r)
	(cd Rscripts && Rscript rq2.r)
	(cd Rscripts && Rscript rq3.r)
	
clean: 
	rm -rf plots/
	rm -rf tables/