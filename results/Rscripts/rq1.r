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

plotSummaryCrashes <- function(majority){
  # Get result status
  reproduction <- getReproduceStatus(majority) 
  # Add (all) applications
  allApps <- reproduction %>%
    mutate(application_name = '(all)')
  allApps$application_factor = factor(allApps$application_name, levels = c(levels(allApps$application_factor), '(all)'))
  # Add (all) applications
  allEx <- reproduction %>%
    rbind(allApps) %>%
    mutate(exception = '(all)')
  allEx$exception_factor = factor(allEx$exception, levels = c(levels(allEx$exception_factor), '(all)'))
  # Add (all) exceptions
  # Add count and frequency 
  df <- allApps %>%
    rbind(allEx) %>%
    rbind(reproduction) %>%
    group_by(application_factor, exception_factor, status_factor) %>%
    summarise(n = n()) %>%
    mutate(Frequency = n / sum(n), label = paste0(n))
  # Reverse order of exceptions
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
	
	results %>%
	  filter( result == 'reproduced' ) %>%
	  group_by(application, application_factor, exception, exception_factor, case, frame_level) %>%
	  summarise(count = n()) %>%
	  data.frame() %>%
	  ggplot(aes(x = application_factor, y = count)) +
	   geom_boxplot()
	
	results %>%
	  filter( result == 'reproduced' ) %>%
	  group_by(application, application_factor, exception, exception_factor, case, frame_level) %>%
	  summarise(count = n()) %>%
	  data.frame() %>%
	  ggplot(aes(x = exception_factor, y = count)) +
	  geom_boxplot()
	
	results %>%
	  filter( result == 'reproduced' ) %>%
	  group_by(application, application_factor, exception, exception_factor, case, frame_level) %>%
	  summarise(count = n()) %>%
	  data.frame() %>%
	  ggplot(aes(x = as.factor(frame_level), y = count)) +
	  geom_boxplot() +
	  facet_grid(exception_factor ~ application_factor, margins = TRUE)
	
	results %>%
	  filter( result == 'reproduced' ) %>%
	  group_by(application, application_factor, exception, exception_factor, case, frame_level, result, result_factor) %>%
	  summarise(count = n()) %>%
	  data.frame() %>%
	  ggplot(aes(x = as.factor(frame_level), y = count)) +
	  geom_boxplot()
	
	# Blue: #2b83ba
	
	frequent <- getMostFrequentResult() %>%
	  mutate(caseframe = paste0(case, frame_level)) %>%
	  filter(majority_result == 'reproduced')
	  
	df <- results %>%
	  mutate(caseframe = paste0(case, frame_level)) %>%
	  filter(caseframe %in% frequent$caseframe, result == 'reproduced') %>%
	  group_by(application, application_factor, case, frame_level) %>%
	  summarise(count = n()) %>%
	  filter(count < 9)
	
	df %>%
	  group_by(application_factor) %>%
	  count()
	
	df <- results %>%
	  filter(result == 'reproduced') %>%
	  group_by(application, application_factor, case, frame_level) %>%
	  summarise(count = n()) %>%
	  filter(count < 9)
	
	df %>%
	  group_by(application_factor) %>%
	  count()
	
	
	# Print plots
	p <- plotGroupedCoverageRanges(frequent)
	ggsave(plot = p, filename = '../plots/rq1_compact.pdf', width=130, height=135, units = "mm" )
	
	p <- plotGroupedCoverageRangesAllApps(frequent)
	ggsave(plot = p, filename = '../plots/rq1_all.pdf', width=230, height=250, units = "mm" )
	
	#p <- plotSummary(frequent)
	#ggsave(plot = p, filename = '../plots/rq1_summary.pdf', width=140, height=80, units = "mm" )
	
	p <- plotSummaryPieChart(frequent)
	ggsave(plot = p, filename = '../plots/rq1_summary.pdf', width=130, height=130, units = "mm" )
	
	p <- plotSummaryCrashes(frequent)
	ggsave(plot = p, filename = '../plots/rq1_crashes.pdf', width=250, height=150, units = "mm" )
	
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
