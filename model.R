# Fit Stan Model
library(rstan)
source('utils.R')
library(shinystan)
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

shot_data <- load_soccer_data('data/events.csv')

# Pick a random 300 players to model

players <- sample(unique(shot_data$player), 70)
shot_data <- shot_data %>% 
  filter(player %in% players)

stan_data <- collect_model_data(shot_data)

rt <- stanc(file="multi_level.stan")
sm <- stan_model(stanc_ret = rt, verbose=FALSE)
system.time(fit <- sampling(sm, data=stan_data$stan_data))

fit_extract <- extract(fit)
skill_levels <- colMeans(fit_extract$beta_skill)
best_shooter <- stan_data$player_index[which.max(skill_levels)]
best_shooter
s