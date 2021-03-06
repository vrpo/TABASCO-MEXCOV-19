source("~/TABASCO-MEXCOV-19/src/packages/install.packages.R");
swabspos <- read.csv(gzfile("~/TABASCO-MEXCOV-19/data/cleansed/0718/swabspos_0718.csv.gz"));

#################################################################################################################################################################################################################################################################################
## Bootstrap | FACTOR Regressors ################################################################################################################################################################################################################################################
#################################################################################################################################################################################################################################################################################

col <- c(1, 3:11); B <- 10^4; n <- nrow(swabspos);
results <- matrix(0, ncol = length(col), nrow = B); colnames(results) <- colnames(swabspos);

for(i in col)
{cat(paste0("i-", i), "\n");
  for(j in 1:B)
  {cat(paste0("  j-", j, "\n"));
    ind = sample(1:n, n, replace = TRUE);
    results[j, i] = OddsRatio(table(swabspos[ind, i], swabspos[ind, 12]), method = "wald");
  };
}; rm(i, j);

# saveRDS(results, "~/TABASCO-MEXCOV-19/src/models/logit-deceased/bayes/Prior-Models/Model_2/Prior-Parameters/results.rds"); 
results <- readRDS("~/TABASCO-MEXCOV-19/src/models/logit-deceased/bayes/Prior-Models/Model_2/Prior-Parameters/results.rds");

#################################################################################################################################################################################################################################################################################
## Bootstrap | Intercept ########################################################################################################################################################################################################################################################
#################################################################################################################################################################################################################################################################################

for(j in 1:B)
{cat(paste0("  j-", j, "\n"));
  ind = sample(1:n, n, replace = TRUE);
  fact_matrix[j, 12] = length(which(swabspos$FALLECIDO[ind] == "Yes"))/length(which(swabspos$FALLECIDO[ind] == "No"))
}; rm(i);

# saveRDS(results, "~/TABASCO-MEXCOV-19/src/models/logit-deceased/bayes/Prior-Models/Model_2/Prior-Parameters/results.rds"); 
results <- readRDS("~/TABASCO-MEXCOV-19/src/models/logit-deceased/bayes/Prior-Models/Model_2/Prior-Parameters/results.rds");