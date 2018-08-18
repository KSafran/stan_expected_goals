data {
  int<lower=0> n;
  int<lower=0> nplaces;
  matrix[n, nplaces] places;
  int<lower=0,upper=1> y[n];
}
parameters {
  vector[nplaces] beta_place;
  real beta_0;
}
transformed parameters {
}
model {
  beta_place ~ normal(0, 2);
  y ~ bernoulli_logit(beta_0 + places * beta_place);
}
