library(tidyverse)
library(CodeClanData)
library(shiny)
library(shinythemes)


# This scatter plot takes the user score and multiples 
# by 10 so that it matches the critics_score measurement 
# and then compares both

user_v_critic_percent <- game_sales %>% 
  mutate(user_score = round((user_score * 10))) %>% 
  ggplot() +
  aes(
    x = critic_score,
    y = user_score,
  ) +
  geom_point() 

