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

printExceptionsApplicationsDescription <- function(){
  benchmark <- getBenchmark()
  # Get statistics for each application and each exception
  df <- benchmark %>%
    distinct(application, application_name, application_factor, application_kind, application_kind_factor, case, exception_class, exception, exception_factor, frame_count) %>%
    mutate(exception_class = ifelse(exception == "Oth.", 'Others', exception_class)) %>%
    group_by(application_kind, application_kind_factor, exception_class, exception, exception_factor) %>%
    summarise(n_cases = n(), mean_frame_count = mean(frame_count), sd_frame_count = sd(frame_count)) %>%
    arrange(application_kind_factor, exception_factor)
  
  totalException <- benchmark %>%
    distinct(application, application_name, application_factor, application_kind, application_kind_factor, case, exception_class, exception, exception_factor, frame_count) %>%
    mutate(exception_class = ifelse(exception == "Oth.", 'Others', exception_class)) %>%
    group_by(exception_class, exception, exception_factor) %>%
    summarise(n_cases = n(), mean_frame_count = mean(frame_count), sd_frame_count = sd(frame_count)) %>%
    arrange(exception_factor)
  
  totalApplication <- benchmark %>%
    distinct(application, application_name, application_factor, application_kind, application_kind_factor, case, exception_class, exception, exception_factor, frame_count) %>%
    mutate(exception_class = ifelse(exception == "Oth.", 'Others', exception_class)) %>%
    group_by(application_kind, application_kind_factor) %>%
    summarise(n_cases = n(), mean_frame_count = mean(frame_count), sd_frame_count = sd(frame_count)) %>%
    arrange(application_kind_factor)
  
  total <- benchmark %>%
    distinct(application, application_name, application_factor, application_kind, application_kind_factor, case, exception_class, exception, exception_factor, frame_count) %>%
    mutate(exception_class = ifelse(exception == "Oth.", 'Others', exception_class)) %>%
    summarise(n_cases = n(), mean_frame_count = mean(frame_count), sd_frame_count = sd(frame_count))
  
  exceptions <- benchmark %>%
    mutate(exception_class = ifelse(exception == "Oth.", 'Others', exception_class)) %>%
    arrange(exception_factor) %>% 
    distinct(exception, exception_class, exception_factor)
  applications <- benchmark %>%
    arrange(application_kind_factor) %>% 
    distinct(application_kind, application_kind_factor)
  
  cat("\\begin{tabular}{ l | r r r | r r r | r r r | r r r } ")
  # Print headers 
  cat("\\textbf{Exception type} ")
  for(j in 1:nrow(applications)){
    app <- applications[j,]
    cat(" & \\multicolumn{3}{c}{\\textbf{", app$application_kind, "}} ")
  }
  cat(" & \\multicolumn{3}{c}{\\textbf{ Total }} ")
  cat("\\\\", "\n")
  cat("\t\t ")
  for(j in 1:nrow(applications)){
    cat(" & \\# &  $\\overline{fr.}$ & $\\sigma$ ")
  }
  cat(" & \\# &  $\\overline{fr.}$ & $\\sigma$ ")
  cat("\\\\", "\n")
  cat("\\hline", "\n")
  for (i in 1:nrow(exceptions)) {
    ex <- exceptions[i,]
    # Print row header
    cat(ex$exception_class, " {\\tiny(", ex$exception, ")} ", sep = "")
    for(j in 1:nrow(applications)){
      app <- applications[j,]
      square <- df %>%
        filter(application_kind_factor == app$application_kind_factor, exception_factor == ex$exception_factor)
      if(nrow(square) != 0){
        cat(" &", square$n_cases)
        cat(" &", formatC(square$mean_frame_count, digits=1, format="f"))
        cat(" &", formatC(square$sd_frame_count, digits=1, format="f"))
      } else {
        # If there is no case for that app and exception
        cat(" &", 0, " ")
        cat(" &", "  ")
        cat(" &", "  ")
      }
    }
    # Print total exception
    square <- totalException %>%
      filter(exception_factor == ex$exception_factor)
    cat(" &", square$n_cases)
    cat(" &", formatC(square$mean_frame_count, digits=1, format="f"))
    cat(" &", formatC(square$sd_frame_count, digits=1, format="f"))
    cat("\\\\", "\n")
  }
  # Print total application
  cat("\\hline", "\n")
  cat("\\textbf{ Total }")
  for(j in 1:nrow(applications)){
    app <- applications[j,]
    square <- totalApplication %>%
      filter(application_kind_factor == app$application_kind_factor)
    cat(" &", square$n_cases)
    cat(" &", formatC(square$mean_frame_count, digits=1, format="f"))
    cat(" &", formatC(square$sd_frame_count, digits=1, format="f"))
  }
  #Print total
  cat(" &", total$n_cases)
  cat(" &", formatC(total$mean_frame_count, digits=1, format="f"))
  cat(" &", formatC(total$sd_frame_count, digits=1, format="f"))
  cat("\\\\", "\n")
  cat("\\end{tabular}")
}

# ------------------------------
# Main function definition
# ------------------------------

main <- function(){
  
  outputFile <- "../tables/benchmark-exceptionsapps-table.tex"
  unlink(outputFile)
  # Redirect cat outputs to file
  sink(outputFile, append = TRUE, split = TRUE)
  printExceptionsApplicationsDescription()
  # Restore cat outputs to console
  sink()
	
}

# ------------------------------
# Program
# ------------------------------

main()


