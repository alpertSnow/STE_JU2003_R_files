### Source finder: run using R2jags
### with dcat prior of location
### date: 2016-09-20

library(R2jags)
library(coda)
library(lattice)

data <- list('ni', 'nj', 'M', 'H', 'mu', 'tau','logqLower','logqUpper',
             'xc', 'yc', 'zc', 'pk', 'pjk', 'pijk', 'iCat', 'jCat', 'kCat')
parameters <- c('i','j', 'k','q','x','y', 'z')
inits <- NULL
#inits <- function() {list(icon = 26, jcon = 31, q = 60)}

sf.sim <- jags(data, inits, parameters, "sf.bug",n.chains=3,n.iter=50000,n.burnin=5000,n.thin=1)


sf.coda <- as.mcmc(sf.sim)
print(sf.sim)


# print(xyplot(sf.coda[1][,2]))