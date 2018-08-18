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
  filter(player %in% players) %>% 
  mutate(player = as.factor(player))

stan_data <- collect_model_data(shot_data)

rt <- stanc(file="multi_level.stan")
sm <- stan_model(stanc_ret = rt, verbose=FALSE)
system.time(fit <- sampling(sm, data=stan_data))


launch_shinystan(fit)

# Compare to logistic regression
library(glmnet)
lm <- glmnet(cbind(stan_data$places, rep(1, length(stan_data$y))),
             stan_data$y, family = 'binomial')
coef(lm, s=lm$lambda[70])
