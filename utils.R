library(data.table)
library(dplyr)

load_soccer_data <- function(data_loc){
  soccer <- fread(data_loc)
  
  shot_data <- soccer %>% 
    filter(event_type == 1,     #Only Shots
           situation == 1) %>%  #Open Play (no free kicks)
    select(player, location, shot_outcome, 
           is_goal, fast_break)
}

collect_model_data <- function(data){
  # See data/dictionary.txt for shot location meanings
  location_matrix <- data_frame(long_range = data$location %in% c(2, 6, 16:18),
                                tough_angle = data$location %in% 6:8,
                                side_box = data$location %in% c(9, 11),
                                side_6 = data$location %in% c(10, 12),
                                very_close = data$location == 13,
                                outside_box = data$location == 15) %>% 
    as.matrix() * 1 # convert to int

    good_data <- rowSums(location_matrix) > 0
  
  list(n = sum(good_data),
       nplaces = ncol(location_matrix),
       y = data$is_goal[good_data],
       places = location_matrix[good_data,])
  
}

