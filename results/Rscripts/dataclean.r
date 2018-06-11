# Contains functions to produce a clean/easy to process dataframe from the input and 
# output csv files.
# authors: Xavier Devroey, and Mozhan Soltani

require(dplyr)

# ------------------------------
# Functions definition
# ------------------------------

# Adds full name for applications
#
addApplicationName <- function(df){
  df$application_name[df$application == "lang"] <- "Commons-lang"
  df$application_name[df$application == "math"] <- "Commons-math"
  df$application_name[df$application == "mockito"] <- "Mockito"
  df$application_name[df$application == "time"] <- "Joda-Time"
  df$application_name[df$application == "chart"] <- "JFreechart"
  df$application_name[df$application == "closure"] <- "Closure comp."
  df$application_name[df$application == "xwiki"] <- "XWiki"
  df$application_name[df$application == "es"] <- "Elasticsearch"
  df$application_factor <- factor(df$application_name, levels = c("Commons-lang", "Commons-math", "Mockito", "Joda-Time", "JFreechart", "Closure comp.", "Elasticsearch", "XWiki"))
  return(df)
}


# Adds application kind
#
addApplicationKind <- function(df){
  df$application_kind[df$application == "lang"] <- "Defects4J"
  df$application_kind[df$application == "math"] <- "Defects4J"
  df$application_kind[df$application == "mockito"] <- "Defects4J"
  df$application_kind[df$application == "time"] <- "Defects4J"
  df$application_kind[df$application == "chart"] <- "Defects4J"
  df$application_kind[df$application == "closure"] <- "Defects4J"
  df$application_kind[df$application == "xwiki"] <- "XWiki"
  df$application_kind[df$application == "es"] <- "Elasticsearch"
  df$application_kind_factor <- factor(df$application_kind, levels = c("Defects4J", "XWiki", "Elasticsearch"))
  return(df)
}

# Adds accronyms for exceptions 
#
addExceptionShortName <- function(df){
  df$exception <- "Oth."
  df$exception[df$exception_name == "java.lang.NullPointerException"] <- "NPE"
  df$exception[df$exception_name == "java.lang.IllegalArgumentException"] <- "IAE"
  df$exception[df$exception_name == "java.lang.ArrayIndexOutOfBoundsException"] <- "AIOOBE"
  df$exception[df$exception_name == "java.lang.ClassCastException"] <- "CCE"
  df$exception[df$exception_name == "java.lang.StringIndexOutOfBoundsException"] <- "SIOOBE"
  df$exception[df$exception_name == "java.lang.IllegalStateException"] <- "ISE"
  df$exception_factor <- factor(df$exception, levels = c("NPE", "IAE", "AIOOBE", "CCE", "SIOOBE", "ISE", "Oth."))
  return(df)
}

# Produces an easy to process dataframe from the given benchmark description csv file.
# csvFile: a csv file describing the benchmark 
#
getCleanBenchmarkDf <- function(csvFile){
  df <- read.csv(csvFile, stringsAsFactors = FALSE)
  # Add name of the applications
  df$application <- tolower(df$application)
  df <- addApplicationName(df)
  df <- addApplicationKind(df)
  # Add short name for exceptions
  df <- addExceptionShortName(df)
  return(df)
}

getBenchmark <- function(){
  df <- getCleanBenchmarkDf('../csv/benchmark.csv')
  return(df)
}


# Produces an easy to process dataframe from the given results csv file.
# csvFile: a csv file produced by the experimentation framework
#
getCleanResultsDf <- function(csvFile){
  df <- read.csv(csvFile, stringsAsFactors = FALSE)
  # Add name of the applications
  df <- addApplicationName(df)
  df <- addApplicationKind(df)
  # Add short name for exceptions
  df <- addExceptionShortName(df)
  # Set the global result of the execution
  df$result[is.na(df$fitness_function_value) | !is.numeric(df$fitness_function_value)] <- "crashed"
  df$result[is.numeric(df$fitness_function_value) & df$fitness_function_value > 3] <- "failed"
  df$result[is.numeric(df$fitness_function_value) & df$fitness_function_value == 3] <- "line reached"
  df$result[is.numeric(df$fitness_function_value) & df$fitness_function_value != 0 & df$fitness_function_value <= 1] <- "ex. thrown"
  df$result[is.numeric(df$fitness_function_value) & df$fitness_function_value == 0] <- "reproduced"
  # Set the order of exceptions
  df$result_factor <- factor(df$result, levels = c("crashed", "failed", "line reached", "ex. thrown", "reproduced"))
  # Check if isKilled factor is present 
  if(!("iskilled" %in% colnames(df))){
    df$iskilled <- NA
  }
  return(df)
}

getResults <- function(){
  # Get results dataframe
  results <- getCleanResultsDf('../csv/results.csv')
  return(results)
}


get_merged_df_for_3 <- function(csvpaths, population){
  pop <- population
  results_1 <- getCleanResultsDf(csvpaths[1])
  results_2 <- getCleanResultsDf(csvpaths[2])
  results_3 <- getCleanResultsDf(csvpaths[3])
  
  # take three data frames from each csv file, where population is equal to 150
  df1 <- subset(results_1,results_1$population==pop)
  df2 <- subset(results_2,results_2$population==pop)
  df3 <- subset(results_3,results_3$population==pop)
  df12 <- rbind(df1, df2)
  
  # generate an integrated data frame
  df123 <- rbind(df12, df3)
  
  return(df123)
}

get_fitness_tries_DF <- function(csvpaths, population){
  pop <- population
  results_1 <- getCleanResultsDf(csvpaths[1])
  results_2 <- getCleanResultsDf(csvpaths[2])
  results_3 <- getCleanResultsDf(csvpaths[3])
  results_4 <- getCleanResultsDf(csvpaths[4])
  results_5 <- getCleanResultsDf(csvpaths[5])
  
  # take three data frames from each csv file, where population is equal to 150 and fitness==0
  df1 <- subset(results_1,results_1$population==pop)
  df2 <- subset(results_2,results_2$population==pop)
  df3 <- subset(results_3,results_3$population==pop)
  df4 <- subset(results_4,results_4$population==pop)
  df5 <- subset(results_5,results_5$population==pop)
  
  #first sort by crash case and frame level, then take the number of tries
  df1$ft1 <- df1$fitness_function_number_of_tries[order(df1$case,df1$frame_level)]
  df2$ft2 <- df2$fitness_function_number_of_tries[order(df2$case,df2$frame_level)]
  df3$ft3 <- df3$fitness_function_number_of_tries[order(df3$case,df3$frame_level)]
  df4$ft4 <- df4$fitness_function_number_of_tries[order(df4$case,df4$frame_level)]
  df5$ft5 <- df5$fitness_function_number_of_tries[order(df5$case,df5$frame_level)]
  
  #turn Strings to numeric values (or NA/missing)
  df1$t1 <- sapply(df1$ft1, function(x) as.numeric(as.character(x)))
  df2$t2 <- sapply(df2$ft2, function(x) as.numeric(as.character(x)))
  df3$t3 <- sapply(df3$ft3, function(x) as.numeric(as.character(x)))
  df4$t4 <- sapply(df4$ft4, function(x) as.numeric(as.character(x)))
  df5$t5 <- sapply(df5$ft5, function(x) as.numeric(as.character(x)))
  
  dataframe <- data.frame(fitness_try1=df1$t1, fitness_try2=df2$t2, fitness_try3=df3$t3, fitness_try4=df4$t4, fitness_try5=df5$t5)
  
  # compute the mean of rows from column 1 to 3
  dataframe$meanFitnessTries <- rowMeans(dataframe, na.rm = TRUE)
  
  #add the application factor (first sort by crash case and frame level)
  dataframe$application_factor <- df1$application_name[order(df1$case,df1$frame_level)]
  #add the exception factor (first sort by crash case and frame level)
  dataframe$exception_factor <- df1$exception_name[order(df1$case,df1$frame_level)]
  #add the fitness function vector (first sort by crash case and frame level)
  dataframe$fitness1 <- df1$fitness_function_value[order(df1$case,df1$frame_level)]
  dataframe$fitness2 <- df2$fitness_function_value[order(df2$case,df2$frame_level)]
  dataframe$fitness3 <- df3$fitness_function_value[order(df3$case,df3$frame_level)]
  dataframe$fitness4 <- df4$fitness_function_value[order(df4$case,df4$frame_level)]
  dataframe$fitness5 <- df5$fitness_function_value[order(df5$case,df5$frame_level)]
  return(dataframe)
}

get_avg_ranges_DF <- function(csvpaths, population){
  pop <- population
  results_1 <- getCleanResultsDf(csvpaths[1])
  results_2 <- getCleanResultsDf(csvpaths[2])
  results_3 <- getCleanResultsDf(csvpaths[3])
  results_4 <- getCleanResultsDf(csvpaths[4])
  results_5 <- getCleanResultsDf(csvpaths[5])
  
  # take three data frames from each csv file, where population is equal to 150 and fitness==0
  df1 <- subset(results_1,results_1$population==pop)
  df2 <- subset(results_2,results_2$population==pop)
  df3 <- subset(results_3,results_3$population==pop)
  df4 <- subset(results_4,results_4$population==pop)
  df5 <- subset(results_5,results_5$population==pop)
  
  #add the result vectors (first sort by crash case and frame level)
  rf1 <- df1$result_factor[order(df1$case,df1$frame_level)]
  rf2 <- df2$result_factor[order(df2$case,df2$frame_level)]
  rf3 <- df3$result_factor[order(df3$case,df3$frame_level)]
  rf4 <- df4$result_factor[order(df4$case,df4$frame_level)]
  rf5 <- df5$result_factor[order(df5$case,df5$frame_level)]
  
  dataframe <- data.frame(result_factor1=rf1, result_factor2=rf2, result_factor3=rf3, result_factor4=rf4, result_factor5=rf5 )
  
  dataframe$most_common <- apply(dataframe,1,function(x) names(which.max(table(x))))
  
  #add the fitness function vectors (first sort by crash case and frame level)
  f1 <- df1$fitness_function_value[order(df1$case,df1$frame_level)]
  f2 <- df2$fitness_function_value[order(df2$case,df2$frame_level)]
  f3 <- df3$fitness_function_value[order(df3$case,df3$frame_level)]
  f4 <- df4$fitness_function_value[order(df4$case,df4$frame_level)]
  f5 <- df5$fitness_function_value[order(df5$case,df5$frame_level)]
  
  dataframe$fitness1 <- f1
  dataframe$fitness2 <- f2
  dataframe$fitness3 <- f3
  dataframe$fitness4 <- f4
  dataframe$fitness5 <- f5
  
  #add the application factor (first sort by crash case and frame level)
  dataframe$application_factor <- df1$application_name[order(df1$case,df1$frame_level)]
  
  str(dataframe$most_common)
  return(dataframe)
}
