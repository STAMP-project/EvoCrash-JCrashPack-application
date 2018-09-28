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

plotFramesPerException <- function(benchmark){
  # Consider only distinct cases
  df <- benchmark %>% 
    distinct(application, case, exception_factor, frame_count)
  p <- 	ggplot(df, aes(x=exception_factor, y=frame_count, fill=factor(exception_factor))) + 
    geom_boxplot(outlier.shape = NA) +
    xlab("Exception class") + 
    ylab("Number of frames") + 
    scale_y_log10() +
    guides(fill=FALSE) +
    scale_fill_brewer(palette=colorpalette)
  return(p)
}

plotExceptionsPerApp <- function(benchmark){
  # Consider only distinct cases
  df <- benchmark %>% 
    distinct(application, application_name, case, exception_factor) #%>%
    #mutate(application_name = ifelse(application %in% c('math', 'time', 'chart', 'mockito', 'lang'), 'Defects4J', application_name))
  p <- ggplot(df, aes(x=application_name, fill=exception_factor)) +
    #geom_bar(stat="count") +
    geom_bar(position = position_dodge(preserve = 'single')) +
    xlab("") + 
    ylab("Number of exceptions") + 
    labs(fill="Exception") +
    #scale_y_log10() +
    scale_fill_brewer(palette=colorpalette)
  return (p)
}

plotAvgCCNPerApp <- function(benchmark){
  # Consider only distinct cases
  df <- benchmark %>% 
    distinct(application, application_name, case, avg_ccn) #%>%
    #mutate(application_name = ifelse(application %in% c('math', 'time', 'chart', 'mockito', 'lang'), 'Defects4J', application_name))
  p <- ggplot(df, aes(x=application_name, y=avg_ccn, fill=factor(application_name))) +
    geom_bar(position = "dodge", stat = "summary", fun.y = "mean") +
    geom_point() +
    xlab("") + 
    ylab("Average CCN") + 
    #scale_y_log10() +
    guides(fill=FALSE) +
    scale_fill_brewer(palette=colorpalette)
  return (p)
}

plotAvgNCSSPerApp <- function(benchmark){
  # Consider only distinct cases
  df <- benchmark %>% 
    distinct(application, application_name, case, application_ncss) #%>%
    #mutate(application_name = ifelse(application %in% c('math', 'time', 'chart', 'mockito', 'lang'), 'Defects4J', application_name))
  p <- ggplot(df, aes(x=application_name, y=application_ncss, fill=factor(application_name))) +
    geom_bar(position = "dodge", stat = "summary", fun.y = "mean") +
    geom_point() +
    xlab("") + 
    ylab("Average NCSS") + 
    #scale_y_log10() +
    guides(fill=FALSE) +
    scale_fill_brewer(palette=colorpalette)
  return (p)
}


# ------------------------------
# Main function definition
# ------------------------------

main <- function(){
	benchmark <- getCleanBenchmarkDf('../csv/benchmark.csv')

  # Number of frames per exception boxplot
	p <- plotFramesPerException(benchmark)
	ggsave(plot = p, filename = '../plots/benchmark-frames-per-exception-boxplot.pdf', width=110, height=50, units = "mm" )
	
	# Number of exceptions per application stacked bar graph
	p <- plotExceptionsPerApp(benchmark)
	ggsave(plot = p, filename = '../plots/benchmark-exceptions-per-app-barchart.pdf', width=110, height=50, units = "mm" )
	
	# CCN distribution per project
	p <- plotAvgCCNPerApp(benchmark)
	ggsave(plot = p, filename = '../plots/benchmark-ccn-per-app-boxplot.pdf', width=190, height=90, units = "mm" )
	
	# CCN distribution per project
	p <- plotAvgNCSSPerApp(benchmark)
	ggsave(plot = p, filename = '../plots/benchmark-ncss-per-app-boxplot.pdf', width=190, height=90, units = "mm" )
	
}

# ------------------------------
# Program
# ------------------------------

main()
 

