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
    summarise(n_cases = n(), tot_frame_count = sum(frame_count), mean_frame_count = mean(frame_count), sd_frame_count = sd(frame_count)) %>%
    arrange(application_kind_factor, exception_factor)
  
  totalException <- benchmark %>%
    distinct(application, application_name, application_factor, application_kind, application_kind_factor, case, exception_class, exception, exception_factor, frame_count) %>%
    mutate(exception_class = ifelse(exception == "Oth.", 'Others', exception_class)) %>%
    group_by(exception_class, exception, exception_factor) %>%
    summarise(n_cases = n(), tot_frame_count = sum(frame_count), mean_frame_count = mean(frame_count), sd_frame_count = sd(frame_count)) %>%
    arrange(exception_factor)
  
  totalApplication <- benchmark %>%
    distinct(application, application_name, application_factor, application_kind, application_kind_factor, case, exception_class, exception, exception_factor, frame_count) %>%
    mutate(exception_class = ifelse(exception == "Oth.", 'Others', exception_class)) %>%
    group_by(application_kind, application_kind_factor) %>%
    summarise(n_cases = n(), tot_frame_count = sum(frame_count), mean_frame_count = mean(frame_count), sd_frame_count = sd(frame_count)) %>%
    arrange(application_kind_factor)
  
  total <- benchmark %>%
    distinct(application, application_name, application_factor, application_kind, application_kind_factor, case, exception_class, exception, exception_factor, frame_count) %>%
    mutate(exception_class = ifelse(exception == "Oth.", 'Others', exception_class)) %>%
    summarise(n_cases = n(), tot_frame_count = sum(frame_count), mean_frame_count = mean(frame_count), sd_frame_count = sd(frame_count))
  
  exceptions <- benchmark %>%
    mutate(exception_class = ifelse(exception == "Oth.", 'Others', exception_class)) %>%
    arrange(exception_factor) %>% 
    distinct(exception, exception_class, exception_factor)
  applications <- benchmark %>%
    arrange(application_kind_factor) %>% 
    distinct(application_kind, application_kind_factor)
  
  cat("% ")
  for (i in 1:nrow(exceptions)) {
    ex <- exceptions[i,]
    cat(ex$exception_class, " (", ex$exception, "), ", sep = "")
  }
  cat("\n")
  
  cat("\\begin{tabular}{ l | r r r r | r r r r | r r r r | r r r r } ")
  # Print headers 
  cat("\\textbf{Except.} ")
  for(j in 1:nrow(applications)){
    app <- applications[j,]
    cat(" & \\multicolumn{4}{c}{\\textbf{", app$application_kind, "}} ")
  }
  cat(" & \\multicolumn{4}{c}{\\textbf{ Total }} ")
  cat("\\\\", "\n")
  cat("\t\t ")
  columnHeader <- " & \\textit{st} & \\textit{fr} & $\\overline{fr}$ & $\\sigma$ "
  for(j in 1:nrow(applications)){
    cat(columnHeader)
  }
  cat(columnHeader)
  cat("\\\\", "\n")
  cat("\\hline", "\n")
  for (i in 1:nrow(exceptions)) {
    ex <- exceptions[i,]
    # Print row header
    # cat(ex$exception_class, " {\\tiny(", ex$exception, ")} ", sep = "")
    cat(ex$exception)
    for(j in 1:nrow(applications)){
      app <- applications[j,]
      square <- df %>%
        filter(application_kind_factor == app$application_kind_factor, exception_factor == ex$exception_factor)
      if(nrow(square) != 0){
        cat(" &", square$n_cases)
        cat(" &", formatC(square$tot_frame_count, digits=0, format="f"))
        cat(" &", formatC(square$mean_frame_count, digits=1, format="f"))
        cat(" &", formatC(square$sd_frame_count, digits=1, format="f"))
      } else {
        # If there is no case for that app and exception
        cat(" &", 0, 0, " ")
        cat(" &", "  ")
        cat(" &", "  ")
      }
    }
    # Print total exception
    square <- totalException %>%
      filter(exception_factor == ex$exception_factor)
    cat(" &", square$n_cases)
    cat(" &", formatC(square$tot_frame_count, digits=0, format="f"))
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
    cat(" &", formatC(square$tot_frame_count, digits=0, format="f"))
    cat(" &", formatC(square$mean_frame_count, digits=1, format="f"))
    cat(" &", formatC(square$sd_frame_count, digits=1, format="f"))
  }
  #Print total
  cat(" &", total$n_cases)
  cat(" &", formatC(total$tot_frame_count, digits=0, format="f"))
  cat(" &", formatC(total$mean_frame_count, digits=1, format="f"))
  cat(" &", formatC(total$sd_frame_count, digits=1, format="f"))
  cat("\\\\", "\n")
  cat("\\end{tabular}")
}

printExceptionsApplicationsVertical <- function(){
  benchmark <- getBenchmark()
  # Get statistics for each application and each exception
  df <- benchmark %>%
    distinct(application, application_name, application_factor, application_kind, application_kind_factor, case, exception_class, exception, exception_factor, frame_count) %>%
    mutate(exception_class = ifelse(exception == "Oth.", 'Others', exception_class)) %>%
    group_by(application_name, application_factor, exception_class, exception, exception_factor) %>%
    summarise(n_cases = n(), tot_frame_count = sum(frame_count), mean_frame_count = mean(frame_count), sd_frame_count = sd(frame_count)) %>%
    arrange(application_name, exception_factor)
  
  totalException <- benchmark %>%
    distinct(application, application_name, application_factor, application_kind, application_kind_factor, case, exception_class, exception, exception_factor, frame_count) %>%
    mutate(exception_class = ifelse(exception == "Oth.", 'Others', exception_class)) %>%
    group_by(exception_class, exception, exception_factor) %>%
    summarise(n_cases = n(), tot_frame_count = sum(frame_count), mean_frame_count = mean(frame_count), sd_frame_count = sd(frame_count)) %>%
    arrange(exception_factor)
  
  totalApplication <- benchmark %>%
    distinct(application, application_name, application_factor, application_kind, application_kind_factor, case, exception_class, exception, exception_factor, frame_count) %>%
    mutate(exception_class = ifelse(exception == "Oth.", 'Others', exception_class)) %>%
    group_by(application_name, application_factor) %>%
    summarise(n_cases = n(), tot_frame_count = sum(frame_count), mean_frame_count = mean(frame_count), sd_frame_count = sd(frame_count)) %>%
    arrange(application_name)
  
  total <- benchmark %>%
    distinct(application, application_name, application_factor, application_kind, application_kind_factor, case, exception_class, exception, exception_factor, frame_count) %>%
    mutate(exception_class = ifelse(exception == "Oth.", 'Others', exception_class)) %>%
    summarise(n_cases = n(), tot_frame_count = sum(frame_count), mean_frame_count = mean(frame_count), sd_frame_count = sd(frame_count))
  
  exceptions <- benchmark %>%
    mutate(exception_class = ifelse(exception == "Oth.", 'Others', exception_class)) %>%
    arrange(exception_factor) %>% 
    distinct(exception, exception_class, exception_factor)
  
  applications <- benchmark %>%
    distinct(application_name, application_factor, version, application_ncss) %>% 
    group_by(application_name, application_factor) %>% 
    summarise(nb_versions = n(), avg_ncss = mean(application_ncss)/1000) %>%
    arrange(application_factor)
  
  cat("% ")
  for (i in 1:nrow(exceptions)) {
    ex <- exceptions[i,]
    cat(ex$exception_class, " (", ex$exception, "), ", sep = "")
  }
  cat("\n")
  
  cat("\\begin{tabular}{ l l | r r r r r r r | r } ")
  # Print headers
  cat("\\textbf{App.} &")
  for(j in 1:nrow(exceptions)){
    ex <- exceptions[j,]
    cat(" & \\textbf{\\rotatebox{90}{", ex$exception, "}}")
  }
  cat(" & \\textbf{ Tot. } ")
  cat("\\\\", "\n")
  cat("\\hline", "\n")
  
  columnHeader <- " & \\textit{st} & \\textit{fr} & $\\overline{fr}$ & $\\sigma$ "
  
  for (i in 1:nrow(applications)) {
    app <- applications[i,]
    
    cat("\\textbf{", app$application_name, "}")
    cat(" & \\textit{st} ")
    for(j in 1:nrow(exceptions)){
      ex <- exceptions[j,]
      square <- df %>%
        filter(application_factor == app$application_factor, exception_factor == ex$exception_factor)
      if(nrow(square) != 0){
        cat(" &", square$n_cases)
      } else {
        cat(" &", 0, " ")
      }
    }
    #Print total
    square <- totalApplication %>%
      filter(application_factor == app$application_factor)
    cat(" &", square$n_cases)
    cat("\\\\", "\n")
    
    cat(app$nb_versions, "versions")
    cat(" & \\textit{fr} ")
    for(j in 1:nrow(exceptions)){
      ex <- exceptions[j,]
      square <- df %>%
        filter(application_factor == app$application_factor, exception_factor == ex$exception_factor)
      if(nrow(square) != 0){
        cat(" &", formatC(square$tot_frame_count, digits=0, format="f"))
      } else {
        cat(" &", 0)
      }
    }
    #Print total
    square <- totalApplication %>%
      filter(application_factor == app$application_factor)
    cat(" &", square$tot_frame_count)
    cat("\\\\", "\n")
    
    cat("$\\overline{NCSS}$: ", formatC(app$avg_ncss, digits=2, format="f"), "k", sep = '')
    cat(" & $\\overline{fr}$ ")
    for(j in 1:nrow(exceptions)){
      ex <- exceptions[j,]
      square <- df %>%
        filter(application_factor == app$application_factor, exception_factor == ex$exception_factor)
      if(nrow(square) != 0){
        cat(" &", formatC(square$mean_frame_count, digits=1, format="f"))
      } else {
        cat(" &  ")
      }
    }
    #Print total
    square <- totalApplication %>%
      filter(application_factor == app$application_factor)
    cat(" &", formatC(square$sd_frame_count, digits=1, format="f"))
    cat("\\\\", "\n")
    
    cat(" & $\\sigma$ ")
    for(j in 1:nrow(exceptions)){
      ex <- exceptions[j,]
      square <- df %>%
        filter(application_factor == app$application_factor, exception_factor == ex$exception_factor)
      if(nrow(square) != 0){
        cat(" &", formatC(square$sd_frame_count, digits=1, format="f"))
      } else {
        cat(" &  ")
      }
    }
    #Print total
    square <- totalApplication %>%
      filter(application_factor == app$application_factor)
    cat(" &", formatC(square$sd_frame_count, digits=1, format="f"))
    cat("\\\\", "\n")
    cat("\\hline", "\n")
  }
  
  # Print total exception
  
  cat(" \\textbf{Total} ")
  cat(" & \\textit{st} ")
  for(j in 1:nrow(exceptions)){
    ex <- exceptions[j,]
    square <- totalException %>%
      filter(exception_factor == ex$exception_factor)
    cat(" &", square$n_cases)
  }
  
  cat(" &", total$n_cases)
  cat("\\\\", "\n")
  
  cat(" & \\textit{fr} ")
  for(j in 1:nrow(exceptions)){
    ex <- exceptions[j,]
    square <- totalException %>%
      filter(exception_factor == ex$exception_factor)
    cat(" &", formatC(square$tot_frame_count, digits=0, format="f"))
  }
  cat(" &", formatC(total$tot_frame_count, digits=0, format="f"))
  cat("\\\\", "\n")
  
  cat(" & $\\overline{fr}$ ")
  for(j in 1:nrow(exceptions)){
    ex <- exceptions[j,]
    square <- totalException %>%
      filter(exception_factor == ex$exception_factor)
    cat(" &", formatC(square$mean_frame_count, digits=0, format="f"))
  }
  cat(" &", formatC(total$mean_frame_count, digits=1, format="f"))
  cat("\\\\", "\n")
  
  cat(" & $\\sigma$ ")
  for(j in 1:nrow(exceptions)){
    ex <- exceptions[j,]
    square <- totalException %>%
      filter(exception_factor == ex$exception_factor)
    cat(" &", formatC(square$sd_frame_count, digits=1, format="f"))
  }
  cat(" &", formatC(total$sd_frame_count, digits=1, format="f"))
  cat("\\\\", "\n")
  cat("\\hline", "\n")
  
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
  
  outputFile <- "../tables/benchmark-exceptionsapps-table-vertical.tex"
  unlink(outputFile)
  # Redirect cat outputs to file
  sink(outputFile, append = TRUE, split = TRUE)
  printExceptionsApplicationsVertical()
  # Restore cat outputs to console
  sink()
	
}

# ------------------------------
# Program
# ------------------------------

main()


