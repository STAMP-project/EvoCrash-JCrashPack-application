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

updateFromOld <- function(){
  results <- getResults()
  
  succeeding <- results %>%
    filter(result == 'reproduced') %>%
    distinct(application, application_name, application_kind, version, case, frame_level)
  
  failing <- results %>%
    distinct(application, application_name, application_kind, version, case, frame_level) %>%
    setdiff(succeeding)
  
  succeeding_cases <- results %>%
    filter(result == 'reproduced') %>%
    distinct(application, application_name, application_kind, version, case)
  
  failing_cases <- results %>%
    distinct(application, application_name, application_kind, version, case) %>%
    setdiff(succeeding_cases)
  
  previous_analysis <- read.csv('../manual-analysis/categorisation-old.csv', quote = "", stringsAsFactors = FALSE )
  
  df <- failing %>%
    left_join(previous_analysis, by = c("application", "application_name", "application_kind", "version", "case", "frame_level", "case", "frame_level")) %>%
    select(application, application_name, application_kind, version, case, frame_level, Category) %>%
    arrange(application_kind, case, frame_level)
  
  # write.csv(df, file = '../manual-analysis/categorisation.csv', quote = FALSE)
}

# ------------------------------
# Main function definition
# ------------------------------

main <- function(){
  manual_analysis <- read.csv('../manual-analysis/categorisation.csv', quote = "", stringsAsFactors = FALSE )
  
  df <- manual_analysis %>% 
    group_by(Category) %>%
    summarise(count = n())
  
  cat("Summary:")
  print(df)
  
  
}

# ------------------------------
# Program
# ------------------------------

main()


