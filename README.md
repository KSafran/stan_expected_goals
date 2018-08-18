# stan_expected_goals
Use Stan to predict likelihood of a goal

# Installing rstan on Windows
Make sure RTools is installed (and in system PATH)
https://cran.r-project.org/bin/windows/Rtools/

Run the following in R for a ~2x speed boost
```
dotR <- file.path(Sys.getenv("HOME"), ".R")
if (!file.exists(dotR))
  dir.create(dotR)
M <- file.path(dotR, "Makevars")
if (!file.exists(M))
  file.create(M)
cat("\nCXXFLAGS=-O3 -Wno-unused-variable -Wno-unused-function",
    file = M, sep = "\n", append = TRUE)
```

# Data
https://www.kaggle.com/secareanualin/football-events/version/1#events.csv
