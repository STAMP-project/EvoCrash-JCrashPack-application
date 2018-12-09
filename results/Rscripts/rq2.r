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

getMedian <- function(data,ind,formula){  
  # ind is the random indexes for the bootstrap sample
  # samp <- sample(data,ind)
  return(median(data[ind]))  
}

getTotalDf <- function(filtered_results){
  total <- data.frame(
    filtered_results %>%
      summarise(
        crashes = n_distinct(case),
        frames = n(),
        min = min(fitness_function_number_of_tries),
        max = max(fitness_function_number_of_tries),
        mean = mean(fitness_function_number_of_tries),
        median = median(fitness_function_number_of_tries),
        variance = var(fitness_function_number_of_tries),
        lowerquartile = quantile(fitness_function_number_of_tries, probs=0.25),
        upperquartile = quantile(fitness_function_number_of_tries, probs=0.75),
        skewness = skewness(fitness_function_number_of_tries),
        kurtosis = kurtosis(fitness_function_number_of_tries),
        cilower = 0,
        ciupper = 0
      )
  )
  
  b <- boot(data = filtered_results$fitness_function_number_of_tries, statistic=getMedian, R=100000)
  medianCi <- boot.ci(b, type = c("basic"))
  total$cilower <- medianCi$basic[4]
  total$ciupper <- medianCi$basic[5]
  
  return(total)
}

printApplicationTable <- function(filtered_results){
  df <- data.frame(
    filtered_results %>%
      group_by(application_factor, application_name) %>%
      # For each application, compute the following values
      summarise(
        crashes = n_distinct(case),
        frames = n(),
        min = min(fitness_function_number_of_tries),
        max = max(fitness_function_number_of_tries),
        mean = mean(fitness_function_number_of_tries),
        median = median(fitness_function_number_of_tries),
        variance = var(fitness_function_number_of_tries),
        lowerquartile = quantile(fitness_function_number_of_tries, probs=0.25),
        upperquartile = quantile(fitness_function_number_of_tries, probs=0.75),
        skewness = skewness(fitness_function_number_of_tries),
        kurtosis = kurtosis(fitness_function_number_of_tries),
        cilower = 0,
        ciupper = 0
      )
  )
  
  # Adding CI lower and higher values 
  for (app in df$application_factor) {
    x <- filtered_results %>%
      filter(application_factor == app)
    b <- boot(data = x$fitness_function_number_of_tries, statistic=getMedian, R=100000)
    medianCi <- boot.ci(b, type = c("basic"))
    df$cilower[df$application_factor == app] <- medianCi$basic[4]
    df$ciupper[df$application_factor == app] <- medianCi$basic[5]
  }

  # Print table
  cat("\\begin{tabularx}{\\textwidth}{ l r r r R{0.6} R{1.4} r R{1} r }", "\n")
  #cat("\\begin{tabularx}{\\textwidth}{ l r r r R{1} R{1} r R{1} r r r }", "\n")
  cat("\\hline", "\n")
  #cat("\\textbf{Applications} & \\textbf{st} & \\textbf{fr}& \\textbf{Min} & \\textbf{Lower Quart.} & \\textbf{Median CI} & \\textbf{Median} & \\textbf{Upper Quart.} & \\textbf{Max} & \\textbf{Skew.} & \\textbf{Kurt.} \\\\", "\n")
  cat("\\textbf{Applications} & \\textbf{st} & \\textbf{fr}& \\textbf{Min} & \\textbf{Lower Quart.} & \\textbf{Median CI} & \\textbf{Median} & \\textbf{Upper Quart.} & \\textbf{Max} \\\\", "\n")
  cat("\\hline", "\n")
  for (app in df$application_factor) {
    x <- df %>%
      filter(application_factor == app)
    cat("\\textbf{", x$application_name,"} & ");
    cat(x$crashes," & ");
    cat(x$frames," & ");
    cat(x$min," & ");
    cat(x$lowerquartile," & ");
    cat("[", x$cilower,",",x$ciupper, "]" ," & ", sep = "");
    cat(formatC(x$median, digits=2, format="f", big.mark = ',')," & ");
    cat(formatC(x$upperquartile, digits=1, format="f", big.mark = ',')," & ");
    cat(formatC(x$max, format="d", big.mark = ',')," ");
    # cat(formatC(x$max, format="d", big.mark = ',')," & ");
    # cat(formatC(x$skewness, digits=2, format="f", big.mark = ',')," & ");
    # cat(formatC(x$kurtosis, digits=2, format="f", big.mark = ',')," ");
    cat("\\\\", "\n")
  }
  x <- getTotalDf(filtered_results)
  cat("\\hline", "\n")
  cat("\\textbf{Total} & ");
  cat(x$crashes," & ");
  cat(x$frames," & ");
  cat(x$min," & ");
  cat(x$lowerquartile," & ");
  cat("[", x$cilower,",",x$ciupper, "]" ," & ", sep = "");
  cat(formatC(x$median, digits=2, format="f", big.mark = ',')," & ");
  cat(formatC(x$upperquartile, digits=1, format="f", big.mark = ',')," & ");
  cat(formatC(x$max, format="d", big.mark = ',')," ");
  # cat(formatC(x$max, format="d", big.mark = ',')," & ");
  # cat(formatC(x$skewness, digits=2, format="f", big.mark = ',')," & ");
  # cat(formatC(x$kurtosis, digits=2, format="f", big.mark = ',')," ");
  cat("\\\\", "\n")
  cat("\\hline", "\n")
  cat("\\end{tabularx}", "\n")
}


printExceptionTable <- function(filtered_results){
  df <- data.frame(
    filtered_results %>%
      group_by(exception_factor, exception) %>%
      # For each application, compute the following values
      summarise(
        crashes = n_distinct(case),
        frames = n(),
        min = min(fitness_function_number_of_tries),
        max = max(fitness_function_number_of_tries),
        mean = mean(fitness_function_number_of_tries),
        median = median(fitness_function_number_of_tries),
        variance = var(fitness_function_number_of_tries),
        lowerquartile = quantile(fitness_function_number_of_tries, probs=0.25),
        upperquartile = quantile(fitness_function_number_of_tries, probs=0.75),
        skewness = skewness(fitness_function_number_of_tries),
        kurtosis = kurtosis(fitness_function_number_of_tries),
        cilower = 0,
        ciupper = 0
      )
  )
  
  # Adding CI lower and higher values 
  for (ex in df$exception_factor) {
    x <- filtered_results %>%
      filter(exception_factor == ex)
    b <- boot(data = x$fitness_function_number_of_tries, statistic=getMedian, R=100000)
    medianCi <- boot.ci(b, type = c("basic"))
    df$cilower[df$exception_factor == ex] <- medianCi$basic[4]
    df$ciupper[df$exception_factor == ex] <- medianCi$basic[5]
  }
  
  # Print table
  cat("\\begin{tabularx}{\\textwidth}{ l r r r R{0.6} R{1.4} r R{1} r }", "\n")
  # cat("\\begin{tabularx}{\\textwidth}{ l r r r R{1} R{1} r R{1} r r r }", "\n")
  cat("\\hline", "\n")
  # cat("\\textbf{Exception kind} & \\textbf{st} & \\textbf{fr}& \\textbf{Min} & \\textbf{Lower Quart.} & \\textbf{Median CI} & \\textbf{Median} & \\textbf{Upper Quart.} & \\textbf{Max} & \\textbf{Skew.} & \\textbf{Kurt.} \\\\", "\n")
  cat("\\textbf{Exception kind} & \\textbf{st} & \\textbf{fr}& \\textbf{Min} & \\textbf{Lower Quart.} & \\textbf{Median CI} & \\textbf{Median} & \\textbf{Upper Quart.} & \\textbf{Max} \\\\", "\n")
  cat("\\hline", "\n")
  for (ex in df$exception_factor) {
    x <- df %>%
      filter(exception_factor == ex)
    cat("\\textbf{", x$exception,"} & ");
    cat(x$crashes," & ");
    cat(x$frames," & ");
    cat(x$min," & ");
    cat(x$lowerquartile," & ");
    cat("[", x$cilower,",",x$ciupper, "]" ," & ", sep = "");
    cat(formatC(x$median, digits=2, format="f", big.mark = ',')," & ");
    cat(formatC(x$upperquartile, digits=1, format="f", big.mark = ',')," & ");
    #cat(formatC(x$max, format="d", big.mark = ',')," & ");
    cat(formatC(x$max, format="d", big.mark = ','));
    # cat(formatC(x$skewness, digits=2, format="f", big.mark = ',')," & ");
    # cat(formatC(x$kurtosis, digits=2, format="f", big.mark = ',')," ");
    cat("\\\\", "\n")
  }
  x <- getTotalDf(filtered_results)
  cat("\\hline", "\n")
  cat("\\textbf{Total} & ");
  cat(x$crashes," & ");
  cat(x$frames," & ");
  cat(x$min," & ");
  cat(x$lowerquartile," & ");
  cat("[", x$cilower,",",x$ciupper, "]" ," & ", sep = "");
  cat(formatC(x$median, digits=2, format="f", big.mark = ',')," & ");
  cat(formatC(x$upperquartile, digits=1, format="f", big.mark = ',')," & ");
  cat(formatC(x$max, format="d", big.mark = ',')," ");
  # cat(formatC(x$max, format="d", big.mark = ',')," & ");
  # cat(formatC(x$skewness, digits=2, format="f", big.mark = ',')," & ");
  # cat(formatC(x$kurtosis, digits=2, format="f", big.mark = ',')," ");
  cat("\\\\", "\n")
  cat("\\hline", "\n")
  cat("\\end{tabularx}", "\n")
}

# ------------------------------
# Main function definition
# ------------------------------

main <- function(){
  results <- getResults()
  majority <- getMostFrequentResult()
  
  # Filter results to keep only those that have been most frequently reproduced
  filtered_results <- results %>%
    semi_join(majority, by = c("case", "frame_level")) %>%
    filter(result == "reproduced")
  
  outputFile <- "../tables/tab-excepstats.tex"
  unlink(outputFile)
  # Redirect cat outputs to file
  sink(outputFile, append = TRUE, split = TRUE)
  printExceptionTable(filtered_results)
  # Restore cat outputs to console
  sink()
  
  outputFile <- "../tables/tab-appstats.tex"
  unlink(outputFile)
  # Redirect cat outputs to file
  sink(outputFile, append = TRUE, split = TRUE)
  printApplicationTable(filtered_results)
  # Restore cat outputs to console
  sink()

  p <- ggplot(filtered_results, aes(x = exception_factor, y = fitness_function_number_of_tries, fill = exception_factor)) +
    geom_boxplot() +
    scale_y_log10() + 
    ylab("Number of fitness evaluation (log. scale)") + 
    guides(fill=FALSE) + 
    scale_fill_brewer(palette=colorpalette) +
    theme(axis.text.x = element_text(angle = 90, hjust = 1))
  ggsave(plot = p, filename = '../plots/rq2_excepstats.pdf', width=100, height=100, units = "mm" )
  
  p <- ggplot(filtered_results, aes(x = application_factor, y = fitness_function_number_of_tries, fill = application_factor)) +
    geom_boxplot() +
    scale_y_log10() + 
    ylab("Number of fitness evaluation (log. scale)") + 
    guides(fill=FALSE) + 
    scale_fill_brewer(palette=colorpalette) +
    theme(axis.text.x = element_text(angle = 90, hjust = 1))
  ggsave(plot = p, filename = '../plots/rq2_appstats.pdf', width=100, height=100, units = "mm" )
  
  p <- ggplot(filtered_results, aes(x = application_factor, y = fitness_function_number_of_tries, fill = application_factor)) +
    geom_boxplot(outlier.shape = NA) +
    facet_grid(exception_factor ~ application_factor, scales="free_x") +
    scale_y_log10() + 
    ylab("Number of fitness evaluation (log. scale)") + 
    theme(axis.title.x=element_blank(),
          axis.text.x=element_blank(),
          axis.ticks.x=element_blank()) + 
    guides(fill=FALSE) + 
    scale_fill_brewer(palette=colorpalette)
  ggsave(plot = p, filename = '../plots/rq2_excepappstats.pdf', width=200, height=150, units = "mm" )
  
  # Getting extreme cases for each exception type
  for(ex in distinct(filtered_results, exception_factor)$exception_factor){
    cat("Costliest case for exception ", ex, "\n")
    df <- filtered_results %>%
      filter(exception_factor == ex) %>%
      top_n(1, fitness_function_number_of_tries) %>%
      select(application, case, frame_level, exception, exception_name, fitness_function_number_of_tries)
    print(df)
  }
  
  for(ex in distinct(filtered_results, exception_factor)$exception_factor){
    cat("Chepeast case for exception ", ex, "\n")
    df <- filtered_results %>%
      filter(exception_factor == ex) %>%
      arrange(fitness_function_number_of_tries) %>%
      slice(1) %>%
      select(application, case, frame_level, exception, exception_name, fitness_function_number_of_tries)
    print(df)
  }
  
  # Getting extreme cases for each application
  for(app in distinct(filtered_results, application)$application){
    cat("Extreme case for application ", app, "\n")
    df <- filtered_results %>%
      filter(application == app) %>%
      top_n(1, fitness_function_number_of_tries) %>%
      select(application, case, frame_level, exception, exception_name, fitness_function_number_of_tries)
    print(df)
  }
  
}

# ------------------------------
# Program
# ------------------------------

main()


