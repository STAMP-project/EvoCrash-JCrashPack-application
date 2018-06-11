# R script
# 
# author: Xavier Devroey

library(ggplot2)
library(dplyr)

source('dataclean.r')

cat('======================', '\n')
cat('Benchmark description:', '\n')
cat('======================', '\n')

benchmark <- getBenchmark()

simplified <- benchmark %>% 
  distinct(application, application_name, case, exception_factor) %>%
  mutate(application_name = ifelse(application %in% c('math', 'time', 'chart', 'mockito', 'lang'), 'Defects4J', application_name))

cat('Stacktraces statistics per application:', '\n')
df <- benchmark %>%
  distinct(application, application_name, case, exception_class, exception, exception_factor, frame_count) %>%
  group_by(application, application_name) %>%
  summarise(n_cases = n(), mean_frame_count = mean(frame_count), sd_frame_count = sd(frame_count))
print(df)

cat('Stacktraces statistics per application per exception type:', '\n')
df <- benchmark %>%
  distinct(application, case, exception_class, exception, exception_factor, frame_count) %>%
  group_by(application, exception_factor) %>%
  summarise(n_cases = n(), mean_frame_count = mean(frame_count), sd_frame_count = sd(frame_count))
print(df)

cat('CCN for applications:', '\n')
df <- benchmark %>% 
  distinct(application, application_name, case, avg_ccn) %>%
  group_by(application,application_name) %>%
  summarise(min_avg_ccn = min(avg_ccn), max_avg_ccn = max(avg_ccn), mean_avg_ccn= mean(avg_ccn))
print(df)

cat('CCN for application groups:', '\n')
df <- benchmark %>% 
  distinct(application, application_name, case, avg_ccn) %>%
  mutate(application_name = ifelse(application %in% c('math', 'time', 'chart', 'mockito', 'lang'), 'Defects4J', application_name)) %>% 
  group_by(application_name) %>%
  summarise(min_avg_ccn = min(avg_ccn), max_avg_ccn = max(avg_ccn), mean_avg_ccn= mean(avg_ccn))
print(df)

cat('NCSS for applications:', '\n')
df <- benchmark %>% 
  distinct(application, application_name, case, application_ncss) %>%
  group_by(application,application_name) %>%
  summarise(min_ncss = min(application_ncss), max_ncss = max(application_ncss), mean_ncss = mean(application_ncss))
print(df)

cat('NCSS for application groups:', '\n')
df <- benchmark %>% 
  distinct(application, application_name, case, application_ncss) %>%
  mutate(application_name = ifelse(application %in% c('math', 'time', 'chart', 'mockito', 'lang'), 'Defects4J', application_name)) %>% 
  group_by(application_name) %>%
  summarise(min_ncss = min(application_ncss), max_ncss = max(application_ncss), mean_ncss = mean(application_ncss))
print(df)

cat('Total number of frames:')
df <- benchmark %>%
  distinct(application, case, frame_count) %>%
  summarise(total_stack_traces = n(), total_frames=sum(frame_count))
print(df)

