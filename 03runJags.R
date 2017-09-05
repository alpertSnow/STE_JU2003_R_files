############# Bayesian inference ##############
### run STE using R2jags                    ###
### with dcat prior of location             ###
### This is a 3-d version                   ###
### Date: 2017-09-02                        ###
### By: xf                                  ###
###############################################

library(R2jags)
library(coda)
library(lattice)

# check if it is a 2-d case
if (nk == 1){
        stop('This is a two-dimenssional case!')
}

data <- list('ni', 'nj', 'M', 'H', 'mu', 'tau','logqLower','logqUpper',
             'xc', 'yc', 'zc', 'pk', 'pjk', 'pijk', 'iCat', 'jCat', 'kCat')
parameters <- c('i','j', 'k','q','x','y', 'z')
inits <- NULL
#inits <- function() {list(icon = 26, jcon = 31, q = 60)}

sf.sim <- jags.parallel(data, inits, parameters, "STE3d.bug",n.chains=3,n.iter=2000,n.burnin=1000,n.thin=1)


sf.coda <- as.mcmc(sf.sim)
print(sf.sim)


# print(xyplot(sf.coda[1][,2]))