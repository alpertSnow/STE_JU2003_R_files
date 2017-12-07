############## Parameter loader ###############
### Load and calculate the parameters       ###
### used in JAGS                            ###
### This is a 2-d version                   ###
### Date: 2017-08-31                        ###
### By: xf                                  ###
###############################################

library(tmvtnorm)
library(R2WinBUGS)
library(coda)
library(R2jags)
library(data.table)
## settings
Sct <- '0.7'
srr.file <- 'SRR168.dat'
x.center <- 0  # reference center coord in CFD model
y.center <- 0 
z.center <- 0 
Zref <- 30  # reference height for wind speed (m)

Uref <- 6.13  # reference wind speed (m/s)

Href <- 1.0  # reference length (m)

norm.fac <- Uref * Zref^2  # normalization factor
# norm.fac <- 1.0

header <- as.vector(data.matrix(read.table(srr.file, nrows = 1, skip = 1)))
M <- header[1]
ni <- header[2]
nj <- header[3]
nk <- header[4]
N <- ni * nj * nk

# check if it is a 2-d case
if (nk != 1){
        stop('This is not a two-dimenssional case!')
}

SRR <- fread(srr.file, skip = 2)
H <- t(data.matrix(SRR))*1e6  # Source-receptor matrix

### measured data
receptorData <- fread('receptor.dat')
mu.original <- receptorData$concentration
mu <- mu.original # Measurement vector, M
R <- pmax((mu/2)^2, 10) # Measuremnet covariance vector, M
tau <- 1/R # tau vector, M

### Synthetic data
i.real <- 255 #for xmin=0.0
j.real <- 129 #for xmin=0.2
ij.real <- (j.real-1)*ni + i.real # source location
q.real <- 100.0
#sig.rate <- 0.5 # sigma/mu
#mu <- H[ ,ij.real] * q.real
#mu <- as.vector(mu + rtmvnorm(1, rep(0,M), diag(mu * sig.rate)))
#R <- (mu/10)^2
#tau <- 1/R

## cell info
## cell center (xc, yc, xz) and cell width (dx, dy dz) calculation
meshx <- as.vector(as.matrix(fread('meshx.dat', header = TRUE)))
meshy <- as.vector(as.matrix(fread('meshy.dat', header = TRUE)))
meshz <- as.vector(as.matrix(fread('meshz.dat', header = TRUE)))
meshx <- (meshx-x.center)/Href
meshy <- (meshy-y.center)/Href
meshz <- (meshz-z.center)/Href
xc <- vector(length = ni)
dx <- vector(length = ni)
for(i in 1:ni){
        xc[i] <- (meshx[i]+meshx[i+1])/2
        dx[i] <- meshx[i+1]-meshx[i]
}
yc <- vector(length = nj)
dy <- vector(length = nj)
for(j in 1:nj){
        yc[j] <- (meshy[j]+meshy[j+1])/2
        dy[j] <- meshy[j+1]-meshy[j]
}
zc <- vector(length = nk)
dz <- vector(length = nk)
for(k in 1:nk){
        zc[k] <- (meshz[k]+meshy[k+1])/2
        dz[k] <- meshz[k+1]-meshy[k]
}
## location prior distribution, decomposed into one 1d distribution and a 2d distribution (pi -> pij).
pArray.01 <- array(as.numeric(apply(H[,], 2, sum) != 0), c(ni, nj)) # 0 if it is impossible to have a prior
pArray <- pArray.01 * (dx %o% dy)
# search sequence: kji
pj <- apply(pArray, 2, sum)
pij <- matrix(pArray, nrow = ni, ncol = nj)

iCat <- 1:ni
jCat <- 1:nj
## emission rate q prior
logqUpper <- 3 # uper limit: 10^x
logqLower <- 0 # lower limit: 10^x