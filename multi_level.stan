data {
  int<lower=0> n;
  int<lower=0> nplayers;
  int<lower=0> nplaces;
  int<lower=1,upper=nplayers> players[n];
  int<lower=1,upper=nplaces> places[n];
  int<lower=0,upper=1> y[n];
}
parameters {
  vector[nplayers] beta_skill;
  vector[nplaces] beta_place;
  real b0;
  real b1;
  real b2;
  real<lower=0> sigma_skill;
  real<lower=0> sigma_place;
}
transformed parameters {
  vector[nplayers] skill_factor;
  vector[nplaces] place_factor;
  vector[n] yhat;
  
  skill_factor = sigma_skill * beta_skill;
  place_factor = sigma_place * beta_place;
  
  for (i in 1:n)
    yhat[i] = b0 + skill_factor[players[i]] * b1 + place_factor[places[i]] * b2;
}
model {
  beta_skill ~ normal(0, 1);
  y ~ bernoulli_logit(yhat);
}
