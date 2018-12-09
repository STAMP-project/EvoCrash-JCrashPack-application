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

printChallengesTable <- function(manual_analysis){
  df <- manual_analysis %>% 
    group_by(Category) %>%
    summarise(count = n()) %>%
    mutate(freq = (count / sum(count)* 100), total = sum(count)) %>%
    arrange(desc(count))
  
  cat("\\begin{tabular}{l r r}", "\n")
  cat("\\textbf{Category} & \\textbf{Frames} & \\textbf{Frequency} ", "\n")
  cat("\\\\")
  cat("\\hline", "\n")
  for(i in 1:nrow(df)){
    challenge <- df[i,]
    cat(challenge$Category)
    cat(" &", challenge$count)
    cat(" & ", formatC(challenge$freq, digits=2, format="f"), "\\%", sep = '')
    cat("\\\\", "\n")
  }
  cat("\\hline", "\n")
  cat("\\textbf{Total}")
  cat(" &", df$total[1])
  cat(" & 100\\% ")
  cat("\\\\", "\n")
  cat("\\end{tabular}")
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
  
  
  outputFile <- "../tables/challenges-table.tex"
  unlink(outputFile)
  # Redirect cat outputs to file
  sink(outputFile, append = TRUE, split = TRUE)
  printChallengesTable(manual_analysis)
  # Restore cat outputs to console
  sink()
  
}

# ------------------------------
# Program
# ------------------------------

main()


