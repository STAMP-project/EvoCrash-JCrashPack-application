# R script
# 
# author: Xavier Devroey

library(ggplot2)
library(dplyr)

library(moments)
library(boot)

source('dataclean.r')

colorpalette="Spectral" # Use photocopy friendly colors (http://colorbrewer2.org/)

# ------------------------------
# Functions definition
# ------------------------------

printApplicationTable <- function(filtered_results){
  df <- data.frame(
    filtered_results %>%
      group_by(application_factor, application_name) %>%
      summarise(
        crashes = n_distinct(case),
        frames = n(),
        min = min(fitness_function_number_of_tries),
        max = max(fitness_function_number_of_tries),
        mean = mean(fitness_function_number_of_tries),
        median = median(fitness_function_number_of_tries),
        variance = var(fitness_function_number_of_tries),
        lowerquartile = quantile(fitness_function_number_of_tries, probs=0.25),
        upperquartile = quantile(fitness_function_number_of_tries, probs=0.25),
        skewness = skewness(fitness_function_number_of_tries),
        kurtosis = kurtosis(fitness_function_number_of_tries)
        
      )
  )
  

  
}


printExceptionTable <- function(filtered_results){
  
  
  
  
  
}

# ------------------------------
# Main function definition
# ------------------------------

main <- function(){
  results <- getResults()
  majority <- getBestResult()
  
  # Filter results to keep only those that have been reproduced in a majority of time
  filtered_results <- results %>%
    semi_join(majority, by = c("case", "frame_level")) %>%
    filter(result == "reproduced")
  
  printExceptionTable(filtered_results)
  
  printApplicationTable(filtered_results)
  
  
  ggplot(filtered_results, aes(x = application_factor, y = fitness_function_number_of_tries, fill = application_factor)) +
    geom_boxplot() +
    scale_y_log10() + 
    xlab("Application") +
    ylab("Number of fitness function evaluation (logarithmic scale)") + 
    guides(fill=FALSE) + 
    theme(axis.text.x = element_text(angle = 90, hjust = 1))
  
  ggplot(filtered_results, aes(x = exception_factor, y = fitness_function_number_of_tries, fill = exception_factor)) +
    geom_boxplot() +
    scale_y_log10() + 
    xlab("Application") +
    ylab("Number of fitness function evaluation (logarithmic scale)") + 
    guides(fill=FALSE) + 
    theme(axis.text.x = element_text(angle = 90, hjust = 1))
  
}

# ------------------------------
# Program
# ------------------------------

main()


