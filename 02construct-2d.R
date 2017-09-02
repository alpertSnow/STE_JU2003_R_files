############ Bayesian model maker #############
### Construct source finder BUGS/JAGS model ###
### using dcat() location prior,            ###
### i.e. some location with 0 possibility   ###
### This is a 2-d version                   ###
### Date: 2017-09-02                        ###
### By: xf                                  ###
###############################################
library(R2WinBUGS)
library(coda)
# check if it is a 2-d case
if (nk != 1){
        stop('This is not a two-dimenssional case!')
}

sf <- function(){
        # likelihood
        ij <- (j-1)*ni + i    # grid location
        for(m in 1 : M) {
                a[m] <- H[m, ij]
                c[m] <- a[m] * q
                mu[m] ~ dnorm(c[m], tau[m])
                # mu[m] ~ dt(c[m],tau[m],2)
        }
        # prior
        # location prior
        Mj ~ dcat(pj[])
        j <- jCat[Mj]
        y <- yc[j]
        Mi ~ dcat(pij[1:ni, j])
        i <- iCat[Mi]
        x <- xc[i]
        #
        log.q ~ dunif(logqLower, logqUpper)
        q <- 10^log.q
        #q ~ dunif(0,100)
}
sf.path <- file.path(getwd(), "STE2d.bug")
write.model(sf, sf.path)