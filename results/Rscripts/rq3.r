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

}

# ------------------------------
# Main function definition
# ------------------------------

main <- function(){
	results <- getResults()

	succeeding <- results %>%
	  filter(result == 'reproduced') %>%
	  distinct(application, application_kind, case, frame_level)
	
	failing <- results %>%
	  distinct(application, application_kind, case, frame_level) %>%
	  setdiff(succeeding)
	
	succeeding_cases <- results %>%
	  filter(result == 'reproduced') %>%
	  distinct(application, application_kind, case)
	
	failing_cases <- results %>%
	  distinct(application, application_kind, case) %>%
	  setdiff(succeeding_cases)
	
	failing_cases %>%
	  group_by(application) %>%
	  summarise(n())
	
	
	df <- failing %>%
	  filter(case %in% failing_cases$case)
	
	
	previous_analysis <- read.csv('../manual-analysis/categorisation.csv', quote = "", stringsAsFactors = FALSE )
	
	empty_category <- previous_analysis %>%
	  filter(Category == "") %>%
	  distinct(case)
	
	filled_category <- previous_analysis %>%
	  filter(Category != "") %>%
	  distinct(case)
	
	never_succeeded <- empty_category %>%
	  setdiff(filled_category)
	
	failing_cases %>%
	  filter(!(case %in% previous_analysis$case)) %>%
	  group_by(application) %>%
	  summarise(n())

}

# ------------------------------
# Program
# ------------------------------

main()


