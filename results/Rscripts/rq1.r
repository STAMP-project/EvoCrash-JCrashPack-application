# R script
# 
# author: Xavier Devroey

library(ggplot2)
library(tidyverse)

source('dataclean.r')

colorpalette="Spectral" # Use photocopy friendly colors (http://colorbrewer2.org/)

# ------------------------------
# Functions definition
# ------------------------------

plotGroupedCoverageRanges <- function(majority){
  
  p <- ggplot(data=majority, aes(x=majority_result_factor, fill=majority_result_factor)) +
    geom_bar(stat="count") +
    xlab("") +
    ylab("Number of frames (logarithmic scale)") +
    theme(axis.text.x = element_text(angle=90)) +
    facet_grid(exception_factor ~ application_kind_factor, scales="free_x", margins = TRUE) +
    scale_fill_brewer(palette=colorpalette) +
    scale_y_log10() +
    guides(fill=FALSE)

    return(p)
}

plotGroupedCoverageRangesAllApps <- function(majority){
  
  p <- ggplot(data=majority, aes(x=majority_result_factor, fill=majority_result_factor)) +
    geom_bar(stat="count") +
    xlab("") +
    ylab("Number of frames (logarithmic scale)") +
    theme(axis.text.x = element_text(angle=90)) +
    facet_grid(exception_factor ~ application_factor, margins = TRUE) +
    scale_fill_brewer(palette=colorpalette) +
    scale_y_log10() +
    guides(fill=FALSE)
  
  return(p)
}

plotGroupedCoverageRangesAllApps <- function(majority){
  
  p <- ggplot(data=majority, aes(x=majority_result_factor, fill=majority_result_factor)) +
    geom_bar(stat="count") +
    xlab("") +
    ylab("Number of frames (logarithmic scale)") +
    theme(axis.text.x = element_text(angle=90)) +
    facet_grid(exception_factor ~ application_factor, margins = TRUE) +
    scale_fill_brewer(palette=colorpalette) +
    scale_y_log10() +
    guides(fill=FALSE)
  
  return(p)
}

plotSummary <- function(majority){
  
  p <- ggplot(data=majority, aes(x=majority_result_factor, fill=majority_result_factor)) +
    geom_bar(stat="count") +
    xlab("") +
    ylab("Number of frames (log. scale)") +
    scale_fill_brewer(palette=colorpalette) +
    scale_y_log10() +
    guides(fill=FALSE)
  
  return(p)
}

plotSummaryPieChart <- function(majority){
  df <- majority %>%
    group_by(majority_result_factor) %>%
    summarise(n = n()) %>%
    mutate(Frequency = n / sum(n), label = paste0(n)) %>%
    mutate(Tool = "EvoCrash_results")
  p <- ggplot(df, aes(x = Tool, y = Frequency, fill = majority_result_factor)) + 
   geom_bar(stat = "identity", width = 1) +
    geom_text(aes(label = label), position = position_stack(vjust = 0.5), size = 5) +
    scale_fill_brewer(palette=colorpalette) +
    scale_y_continuous(labels = scales::percent) +
    xlab(NULL) +
    ylab(NULL) +
    guides(fill=guide_legend(title=NULL)) +
    theme(legend.position="bottom",
          axis.title.y = element_blank(),
          axis.text.y=element_blank(),
          axis.ticks.y=element_blank()
          ) +
    coord_polar("y", start=0)
}

STATUS_LEVELS = c("not reproduced", "reproduced")

getReproduceStatus <- function(results){
  df <- results %>%
    group_by(case, majority_result) %>%
    mutate(max_reproduced = ifelse(majority_result == 'reproduced', max(frame_level), 0)) %>%
    ungroup() %>%
    group_by(case) %>%
    mutate(max_reproduced = max(max_reproduced)) %>%
    ungroup() %>%
    distinct(application_name, application_factor, case, exception, exception_factor, max_reproduced)
  df <- data.frame(df) %>%
    group_by(case) %>%
    mutate(highest = max(max_reproduced)) %>%
    ungroup() %>%
    mutate(status = ifelse(max_reproduced > 0 & max_reproduced >= highest, STATUS_LEVELS[2], STATUS_LEVELS[1]))
  df <- data.frame(df)
  df$status_factor <- factor(df$status, levels = STATUS_LEVELS, ordered = TRUE)
  return(df)
}


buildStackedBarCrashStatusPerApp <- function(majority){
  # Get result status
  reproduction <- getReproduceStatus(majority) 
  # Add count and frequency 
  df <- reproduction %>%
    mutate(application_name = '(all)')
  df$application_factor = factor(df$application_name, levels = c(levels(df$application_factor), '(all)'))
  df <- df %>%
    rbind(reproduction) %>%
    group_by(application_factor, exception_factor, status_factor) %>%
    summarise(n = n()) %>%
    mutate(Frequency = n / sum(n), label = paste0(n))
  df$exception_factor <- fct_rev(df$exception_factor)
  p <- ggplot(df, aes(x = exception_factor, y = Frequency, fill = status_factor)) + 
    geom_bar(stat = "identity") +
    geom_text(aes(label = label), position = position_stack(vjust = 0.5), size = 3) +
    scale_fill_brewer(palette=colorpalette) +
    scale_y_continuous(labels = scales::percent) +
    xlab(NULL) +
    ylab(NULL) +
    guides(fill=guide_legend(title=NULL)) +
    theme(legend.position="bottom") +
    coord_flip() +
    facet_wrap(. ~ application_factor, ncol = 4)
  return(p)
}

# ------------------------------
# Main function definition
# ------------------------------

main <- function(){
	results <- getResults()
	
	frequent <- getMostFrequentResult()
	
	# Print plots
	p <- plotGroupedCoverageRanges(frequent)
	ggsave(plot = p, filename = '../plots/rq1_compact.pdf', width=130, height=135, units = "mm" )
	
	p <- plotGroupedCoverageRangesAllApps(frequent)
	ggsave(plot = p, filename = '../plots/rq1_all.pdf', width=230, height=250, units = "mm" )
	
	#p <- plotSummary(frequent)
	#ggsave(plot = p, filename = '../plots/rq1_summary.pdf', width=140, height=80, units = "mm" )
	
	p <- plotSummaryPieChart(frequent)
	ggsave(plot = p, filename = '../plots/rq1_summary.pdf', width=130, height=130, units = "mm" )
	
	# Compute values from the text
	
	cat("Most frequent outcome frequencies:", "\n")
	df <- frequent %>%
	  group_by(majority_result) %>%
	  summarise (n = n(), crashescount = n_distinct(case)) %>%
	  mutate(freq = n / sum(n), total = sum(n))
	print(df)
	
	cat("Most frequent outcome frequencies for Elasticsearch:", "\n")
	df <- frequent %>%
	  filter(application_name == "Elasticsearch") %>%
	  group_by(majority_result) %>%
	  summarise (n = n(), crashescount = n_distinct(case)) %>%
	  mutate(freq = n / sum(n), total = sum(n))
	print(df)
	
	cat("Most frequent outcome frequencies for Defects4J:", "\n")
	df <- frequent %>%
	  filter(application_kind == "Defects4J") %>%
	  group_by(majority_result) %>%
	  summarise (n = n(), crashescount = n_distinct(case)) %>%
	  mutate(freq = n / sum(n), total = sum(n))
	print(df)
	
	cat("Result for MOCKITO-4b:", "\n")
	df <- frequent %>%
	  filter(case == "MOCKITO-4b") 
	print(df)
	
	cat("Most frequent outcome frequencies for Mockito:", "\n")
	df <- frequent %>%
	  filter(application_name == "Mockito") %>%
	  group_by(majority_result) %>%
	  summarise (n = n(), crashescount = n_distinct(case)) %>%
	  mutate(freq = n / sum(n), total = sum(n))
	print(df)
	
	cat("Most frequent outcome frequencies for XWiki:", "\n")
	df <- frequent %>%
	  filter(application_name == "XWiki") %>%
	  group_by(majority_result) %>%
	  summarise (n = n(), crashescount = n_distinct(case)) %>%
	  mutate(freq = n / sum(n), total = sum(n))
	print(df)
	
	cat("Number of frames reproduced at least once:", "\n")
	df <- results %>%
	  filter(result == "reproduced") %>%
	  distinct(case, frame_level) %>%
	  count()
	print(df)
	
	cat("Number of crashes were a frame has been reproduced at least once:", "\n")
	df <- results %>%
	  filter(result == "reproduced") %>%
	  distinct(case) %>%
	  count()
	print(df)
	
	cat("Most frequent outcome frequencies for NPE:", "\n")
	df <- frequent %>%
	  filter(exception == "NPE") %>%
	  group_by(majority_result) %>%
	  summarise (n = n(), crashescount = n_distinct(case)) %>%
	  mutate(freq = n / sum(n), total = sum(n))
	print(df)
	
	cat("Most frequent outcome frequencies for IAE:", "\n")
	df <- frequent %>%
	  filter(exception == "IAE") %>%
	  group_by(majority_result) %>%
	  summarise (n = n(), crashescount = n_distinct(case)) %>%
	  mutate(freq = n / sum(n), total = sum(n))
	print(df)
	
	cat("Most frequent outcome frequencies for AIOOBE:", "\n")
	df <- frequent %>%
	  filter(exception == "AIOOBE") %>%
	  group_by(majority_result) %>%
	  summarise (n = n(), crashescount = n_distinct(case)) %>%
	  mutate(freq = n / sum(n), total = sum(n))
	print(df)
	
	cat("Most frequent outcome frequencies for CCE:", "\n")
	df <- frequent %>%
	  filter(exception == "CCE") %>%
	  group_by(majority_result) %>%
	  summarise (n = n(), crashescount = n_distinct(case)) %>%
	  mutate(freq = n / sum(n), total = sum(n))
	print(df)
	
	cat("Most frequent outcome frequencies for SIOOBE:", "\n")
	df <- frequent %>%
	  filter(exception == "SIOOBE") %>%
	  group_by(majority_result) %>%
	  summarise (n = n(), crashescount = n_distinct(case)) %>%
	  mutate(freq = n / sum(n), total = sum(n))
	print(df)
	
	cat("Most frequent outcome frequencies for ISE:", "\n")
	df <- frequent %>%
	  filter(exception == "ISE") %>%
	  group_by(majority_result) %>%
	  summarise (n = n(), crashescount = n_distinct(case)) %>%
	  mutate(freq = n / sum(n), total = sum(n))
	print(df)
	
	cat("Most frequent outcome frequencies for Oth.:", "\n")
	df <- frequent %>%
	  filter(exception == "Oth.") %>%
	  group_by(majority_result) %>%
	  summarise (n = n(), crashescount = n_distinct(case)) %>%
	  mutate(freq = n / sum(n), total = sum(n))
	print(df)
	
	
}

# ------------------------------
# Program
# ------------------------------

main()
