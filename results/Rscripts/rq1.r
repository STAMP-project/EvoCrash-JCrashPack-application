# R script
# 
# author: Xavier Devroey

library(ggplot2)
library(dplyr)

source('dataclean.r')

colorpalette="Spectral" # Use photocopy friendly colors (http://colorbrewer2.org/)

# ------------------------------
# Functions definition
# ------------------------------

plotGroupedCoverageRanges <- function(results){
  majority <- getBestResult()
  
  p <- ggplot(data=majority, aes(x=majority_result, fill=majority_result)) +
    geom_bar(stat="count") +
    xlab("") +
    ylab("Average Number of frames (logarithmic scale)") +
    theme(axis.text.x = element_text(size = 6, angle=90), axis.text.y = element_text(size = 4)) +
    facet_grid(exception_factor ~ application_kind_factor, scales="free_x") +
    scale_fill_brewer(palette=colorpalette) +
    scale_y_log10() +
    guides(fill=FALSE)

    return(p)
}

# ------------------------------
# Main function definition
# ------------------------------

main <- function(){
	results <- getResults()

	p <- plotGroupedCoverageRanges(results)
	ggsave(plot = p, filename = '../plots/rq1_compact.pdf', width=130, height=135, units = "mm" )
	
}

# ------------------------------
# Program
# ------------------------------

main()


