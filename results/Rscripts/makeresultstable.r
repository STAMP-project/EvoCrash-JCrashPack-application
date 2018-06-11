# R script
# 
# author: Xavier Devroey

library(dplyr)

source('dataclean.r')

# ------------------------------
# Functions definition
# ------------------------------

# Prints table with exceptions and applications informations
printResultsDetailedTable <- function(results){
  for(app in unique((results %>% arrange(application_factor))$application)){
    df <- results %>%
      filter(application == app) %>%
      select(application_name, case, frame_level, execution_idx, result) %>%
      arrange(case, frame_level)
    appname <- unique(df$application_name)
    cat("\\subsection{",appname,"}", "\n", "\n", sep = '')
    cat("\\begin{longtable}{p{22mm} r c c c c c c c c c c}", "\n")
    cat("\\textbf{Id} & \\textbf{Fr.} & \\textbf{Run 1} & \\textbf{Run 2} & \\textbf{Run 3} & \\textbf{Run 4} & \\textbf{Run 5} & \\textbf{Run 6} & \\textbf{Run 7} & \\textbf{Run 8} & \\textbf{Run 9} & \\textbf{Run 10}", "\\\\", "\n")
    cat("\\hline", "\n")
    for (id in unique(df$case)) {
      c <- df %>% filter(case == id)
      for (l in unique(c$frame_level)) {
        cat(id, '&', l)
        for(i in 1:10){
          r <- c %>% filter(frame_level == l & execution_idx == i) %>%
            distinct(result)
          color <- case_when(r$result == "crashed" ~ 'purple',
                             r$result == "failed" ~ 'red', 
                             r$result == "line reached" ~ 'orange',
                             r$result == "ex. thrown" ~ 'yellow',
                             r$result == "reproduced" ~ 'green')
          cat('& ', '\\colorbox{', color, '}{\\makebox[13mm]{', r$result, '} }', sep='')
        }
        cat('\\\\', '\n')
      }
    }
    cat("\\hline", "\n")
    cat("\\end{longtable}", "\n", "\n")
  }
}

# ------------------------------
# Main function definition
# ------------------------------

main <- function(){
  
  results <- getResults()
  
  outputFile <- "../tables/results-detailed-table.tex"
  unlink(outputFile)
  # Redirect cat outputs to file
  sink(outputFile, append = TRUE, split = TRUE)
  printResultsDetailedTable(results)
  # Restore cat outputs to console
  sink()
  
  
}

# ------------------------------
# Program
# ------------------------------

main()


