# R script
# 
# author: Xavier Devroey

library(ggplot2)
library(dplyr)

source('dataclean.r')

# ------------------------------
# Functions definition
# ------------------------------


printCategoriesTable <- function(categories){
  df <- categories %>%
    filter(!is.na(Category) & Category != '') %>%
    arrange(case, frame_level)
  cat("\\begin{longtable}{l r l}", "\n")
  cat("\\textbf{Id} & \\textbf{Frame} & \\textbf{Category} ", "\n")
  cat("\\\\")
  cat("\\hline", "\n")
  for (i in 1:nrow(df)) {
    cat(df[i, 'case'], " & ")
    cat(df[i, 'frame'], " & ")
    cat(df[i, 'Category'])
    cat(" \\\\", "\n")
  }
  cat("\\end{longtable}", "\n", "\n")
}


printCategoriesShortTable <- function(categories){
  df <- categories %>%
    filter(!is.na(Category) & Category != '') %>%
    group_by(Category) %>%
    summarise(nb = n()) %>%
    arrange(desc(nb))
  cat("\\begin{tabular}{lr}", "\n")
  cat("\\textbf{Category} & \\textbf{count} ", "\n")
  cat("\\\\")
  cat("\\hline", "\n")
  for (i in 1:nrow(df)) {
    cat(df[i, 'Category'][[1]], " & ")
    cat(df[i, 'nb'][[1]])
    cat(" \\\\", "\n")
  }
  cat("\\end{tabular}", "\n")
}

# ------------------------------
# Main function definition
# ------------------------------

main <- function(){
  csvFile <- '../manual-analysis/categorisation.csv'
  categories <- read.csv(csvFile, stringsAsFactors = FALSE)
  
  cat("Categories are", "\n")
  df <- categories %>% 
    distinct(Category) %>% 
    arrange(Category)
  print(df)
  
  outputFile <- "../tables/categorisation-table.tex"
  unlink(outputFile)
  # Redirect cat outputs to file
  sink(outputFile, append = TRUE, split = TRUE)
  printCategoriesTable(categories)
  # Restore cat outputs to console
  sink()
  
  outputFile <- "../tables/categorisation-short-table.tex"
  unlink(outputFile)
  # Redirect cat outputs to file
  sink(outputFile, append = TRUE, split = TRUE)
  printCategoriesShortTable(categories)
  # Restore cat outputs to console
  sink()
  
}

# ------------------------------
# Program
# ------------------------------

main()

