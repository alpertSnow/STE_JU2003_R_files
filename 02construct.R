############ Bayesian model maker #############
### Construct source finder BUGS/JAGS model ###
### using dcat() location prior,            ###
### i.e. some location with 0 possibility   ###
### This is a 3-d version                   ###
### Date: 2017-09-02                        ###
### By: xf                                  ###
###############################################
library(R2WinBUGS)
library(coda)

# check if it is a 2-d case
if (nk == 1){
        stop('This is a two-dimenssional case!')
}

sf <- function(){
        # likelihood
        ijk <- (k-1)*ni*nj + (j-1)*ni + i    # grid location
        for(m in 1 : M) {
                a[m] <- H[m, ijk]
                c[m] <- a[m] * q
                mu[m] ~ dnorm(c[m], tau[m])
                # mu[m] ~ dt(c[m],tau[m],2)
        }
        # prior
        # location prior
        Mk ~ dcat(pk[])
        k <- kCat[Mk]
        z <- zc[k]
        Mj ~ dcat(pjk[1:nj, k])
        j <- jCat[Mj]
        y <- yc[j]
        Mi ~ dcat(pijk[1:ni, (k-1)*nj + j])
        i <- iCat[Mi]
        x <- xc[i]
        #
        #log.q ~ dunif(logqLower, logqUpper)
        #q <- 10^log.q
        q ~ dunif(0,100)
}
sf.path <- file.path(getwd(), "STE3d.bug")
write.model(sf, sf.path)