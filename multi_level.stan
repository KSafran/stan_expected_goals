data {
  int<lower=0> n;
  int<lower=0> nplaces;
  int<lower=0> nplayers;
  matrix[n, nplaces] places;
  int<lower=1, upper=nplayers> player[n];
  int<lower=0,upper=1> y[n];
}
parameters {
  vector[nplaces] beta_place;
  vector[nplayers] beta_skill;
  real beta_0;
}
transformed parameters {
  vector[n] skill_factor;
  for (i in 1:n)
    skill_factor[i] = beta_skill[player[i]];
}
model {
  beta_place ~ normal(0, 2);
  beta_skill ~ normal(0, 1);
  y ~ bernoulli_logit(beta_0 + skill_factor + places * beta_place);
}
