# Fit Stan Model
library(rstan)
source('utils.R')
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

shot_data <- load_soccer_data('data/events.csv')

# Pick a random 300 players to model

players <- sample(unique(shot_data$player), 300)
shot_data <- shot_data %>% 
  filter(player %in% players) %>% 
  mutate(player = as.factor(player))

stan_data <- list(n = nrow(shot_data),
                  nplayers = length(unique(shot_data$player)),
                  nplaces = length(unique(shot_data$shot_place)),
                  y = shot_data$is_goal,
                  players = as.numeric(shot_data$player),
                  places = shot_data$shot_place)

rt <- stanc(file="multi_level.stan")
sm <- stan_model(stanc_ret = rt, verbose=FALSE)
system.time(fit <- sampling(sm, data=stan_data))


