# R script
# 
# author: Xavier Devroey

library(ggplot2)
library(dplyr)

source('dataclean.r')

cat('======================', '\n')
cat('Results:', '\n')
cat('======================', '\n')

results <- getResults()

benchmark <- getBenchmark()

frames <- results %>%
  distinct(case, frame_level) 
  
succeeding <- results %>%
  filter(result == 'reproduced') %>%
  distinct(case, frame_level)

failing <- results %>%
  distinct(case, frame_level) %>%
  setdiff(succeeding)

cat('Executions that did not succeed at least once:', '\n')
print(failing)
cat('\n')

cat('All cases:', '\n')
df <- results %>%
  distinct(case)
print(df)
cat('\n')

cat('All frame levels:', '\n')
df <- results %>%
  distinct(case, frame_level)
print(df)
cat('\n')

cat('Results per frame:', '\n')
df <- results %>%
  group_by(case, frame_level, result) %>%
  summarise(count = n())
print(df)
cat('\n')

cat('Failing cases:', '\n')
df <- failing %>%
  distinct(case)
print(df)
cat('\n')

cat('Number of frames considered for evaluation / total number of frames by stack trace:', '\n')
df <- results %>% 
  left_join(benchmark, by = c("case", "frame_level")) %>%
  distinct(case, frame_count, frame_level) %>%
  group_by(case, frame_count) %>%
  summarise(effective_frames_count = n(), diff_frames = first(frame_count) - effective_frames_count)
print(df)
cat('\n')

cat('Total number of frames considered for evaluation / total number of frames:', '\n')
df <- results %>% 
  left_join(benchmark, by = c("case", "frame_level")) %>%
  distinct(case, frame_count, frame_level) %>%
  group_by(case, frame_count) %>%
  summarise(effective_frames_count = n(), diff_frames = first(frame_count) - effective_frames_count) %>%
  ungroup()
df <- df %>%
  summarise(all = sum(frame_count), effective = sum(effective_frames_count), diff = sum(diff_frames))
print(df)
cat('\n')

# Compute most frequent outcome to get results
majority <- results %>%
  group_by(application, case, frame_level) %>%
  summarize(majority_result = names(which.max(table(result)))) 

cat('Percentage of frames for each result per app: ', '\n')
df <- majority %>%
  group_by(application, majority_result) %>%
  summarise(number_of_frames = n()) %>%
  mutate(perc = number_of_frames / sum(number_of_frames))
print(df)
cat('\n')

cat('Percentage of frames reproduced by EvoCrash: ', '\n')
df <- majority %>%
  group_by(majority_result) %>%
  summarise(number_of_frames = n()) %>%
  mutate(perc = number_of_frames / sum(number_of_frames))
print(df)
cat('\n')

# Compute most frequent outcome to get results
majority <- results %>%
  mutate(application = ifelse(application %in% c('math', 'time', 'chart', 'mockito', 'lang'), 'd4j', application)) %>%
  group_by(application, case, frame_level) %>%
  summarize(majority_result = names(which.max(table(result))))

cat('Percentage of frames for each result per app: ', '\n')
df <- majority %>%
  group_by(application, majority_result) %>%
  summarise(number_of_frames = n()) %>%
  mutate(perc = number_of_frames / sum(number_of_frames))
print(df)
cat('\n')

majority <- results %>%
  group_by(application, case, exception, frame_level) %>%
  summarize(majority_result = names(which.max(table(result))))

cat('Percentage of frames for each result per exception kind: ', '\n')
df <- majority %>%
  group_by(exception, majority_result) %>%
  summarise(number_of_frames = n()) %>%
  mutate(perc = number_of_frames / sum(number_of_frames))
print(df)
cat('\n') 
