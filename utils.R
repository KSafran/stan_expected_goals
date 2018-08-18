library(data.table)
library(dplyr)

load_soccer_data <- function(data_loc){
  soccer <- fread(data_loc)
  
  shot_data <- soccer %>% 
    filter(event_type == 1,     #Only Shots
           situation == 1,     #Open Play (no free kicks)
           !is.na(shot_place)) %>%  
    select(player, shot_place, shot_outcome, 
           is_goal, fast_break)
}

