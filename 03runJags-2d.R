############# Bayesian inference ##############
### run STE using R2jags                    ###
### with dcat prior of location             ###
### This is a 2-d version                   ###
### Date: 2017-09-02                        ###
### By: xf                                  ###
###############################################

library(R2jags)
library(coda)
library(lattice)
# check if it is a 2-d case
if (nk != 1){
        stop('This is not a two-dimenssional case!')
}

data <- list('ni', 'M', 'H', 'mu', 'tau','logqLower','logqUpper',
             'xc', 'yc', 'pj', 'pij', 'iCat', 'jCat')
parameters <- c('i','j','q','x','y')
inits <- NULL
#inits <- function() {list(icon = 26, jcon = 31, q = 60)}

sf.sim <- jags(data, inits, parameters, "STE2d.bug",n.chains=3,n.iter=2000,n.burnin=1000,n.thin=1)


sf.coda <- as.mcmc(sf.sim)
print(sf.sim)


# print(xyplot(sf.coda[1][,2]))