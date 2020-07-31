library(png)

uk_flag <- readPNG("flags/united-kingdom-flag-xs.png")
germany_flag <- readPNG("flags/germany-flag-xs.png")
usa_flag <- readPNG('flags/united-states-of-america-flag-xs.png')
soviet_flag <- readPNG("flags/1200px-Flag_of_the_Soviet_Union.png")
italy_flag <- readPNG("flags/italy-flag-xs.png")


plot_medal <- function(m, s){ 
  olympics_overall_medals %>%
    filter(team %in% c("United States",
                       "Soviet Union",
                       "Germany",
                       "Italy",
                       "Great Britain")) %>%
    filter(medal == m) %>%
    filter(season == s) %>%
    ggplot() +
    aes(x = team, y = count, fill = medal) +
    geom_col() +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank()) +
    scale_fill_manual(values = c("Gold" = "#D1B04D", "Silver" =  "#BAB8B3", "Bronze" =  "#D18F4D")
    ) 
    
}

percent_olympics_summer_gmedals <- olympics_overall_medals %>% 
  filter(team %in% c("United States",
                     "Soviet Union",
                     "Germany",
                     "Italy",
                     "Great Britain")) %>%
  filter(medal == "Gold" & season == "Summer") %>% 
  mutate(percent_of_medals = (count/sum(count)))


percent_olympics_summer_gmedals_plot <- function(m, s){
  
  ggplot(percent_olympics_summer_gmedals, aes(x = 2, y = percent_of_medals, fill = team)) +
  geom_col(colour = "black") +
  coord_polar("y", start = 1) +
  geom_text(aes(label = paste0(round(percent_of_medals*100), "%")),
            position = position_stack(vjust = 0.5)) +
  theme(panel.background = element_blank(),
        axis.line = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        axis.title = element_blank(),
        plot.title = element_text(hjust = 0.5, size = 18)) +
  labs(title = "Summer Olympics Total Gold Medal Count")}








