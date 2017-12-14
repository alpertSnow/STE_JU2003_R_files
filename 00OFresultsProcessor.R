########### OF results processor ##############
### Read .dat file from OF sample sets      ###
### Write MESHX(Y&Z).TXT and SRR*.TXT       ###
### This is a 3-d version                   ###
### Date: 2017-08-31                        ###
### By: xf                                  ###
###############################################

## header
library(dplyr)

## settings ##
M <- 44  # number of sensors
setsName <- 'samplePoints'
fieldNames <- c('T',sprintf('Tr%02d',1:M))
extention <- '.dat'
tol <- 2e-5 # tolarance
digits <- 5  # decimal places of coordinations
srrFile <- 'SRR174-CBD.dat' # source-receptor relationship output

## read sample sets file
inputFile <- paste0(setsName,'_',paste(fieldNames,collapse = '_'),extention)
inputFile <- 'samplePoints_T_Tr44-174CBD.dat'
inputDF <- read.table(inputFile, skip = 3+M, header = FALSE)
x <- inputDF[,1]
y <- inputDF[,2]
z <- inputDF[,3]
adjoints <- inputDF[,5:(4+M)]
colnames(adjoints) <- fieldNames[-1]

## cell center coords
xc <- as.numeric(names(table(x)))
yc <- as.numeric(names(table(y)))
zc <- as.numeric(names(table(z)))
ni <- length(xc)
nj <- length(yc)
nk <- length(zc)

## cell size & cell boundary coords
dx <- vector(length = length(xc))
dy <- vector(length = length(yc))
dz <- vector(length = length(zc))
meshx <- vector('numeric', length = length(xc) + 1)
meshy <- vector('numeric', length = length(yc) + 1)
meshz <- vector('numeric', length = length(zc) + 1)

# meshx第一个数的设置，只能手动给定第一个网格宽度了。。
meshx[1] <- xc[1] - 0.5 * (xc[2]-x[1])
for (i in 1:length(xc)){
        dx[i] <- 2 * (xc[i] - meshx[i])
        meshx[i+1] <- xc[i] + 0.5 * dx[i]
}
meshy[1] <- yc[1] - 0.5 * (yc[2]-yc[1])
for (i in 1:length(yc)){
        dy[i] <- 2 * (yc[i] - meshy[i])
        meshy[i+1] <- yc[i] + 0.5 * dy[i]
}
if (nk == 1){
        meshz <- c(zc - 1, zc + 1)
}else{
        meshz[1] <- zc[1] - 0.5 * (zc[2]-zc[1])
        for (i in 1:length(zc)){
        dz[i] <- 2 * (zc[i] - meshz[i])
        meshz[i+1] <- zc[i] + 0.5 * dz[i]
        }
}



## meshx, y, z: round and output
meshx <- round(meshx, digits)
meshy <- round(meshy, digits)
meshz <- round(meshz, digits)
write.table(meshx, 'meshx.dat', col.names = 'X', row.names = FALSE)
write.table(meshy, 'meshy.dat', col.names = 'Y', row.names = FALSE)
write.table(meshz, 'meshz.dat', col.names = 'Z', row.names = FALSE)

## make source-receptor relationship
SRR <- as.data.frame(matrix(0, nrow = ni*nj*nk, ncol = M))
N.input <- length(x)
clock <- progress_estimated(N.input)
li <- vector(length = N.input)
lj <- vector(length = N.input)
lk <- vector(length = N.input)
for (l in 1:length(x)){
        li[l] <- which(xc == x[l])
        lj[l] <- which(yc == y[l])
        lk[l] <- which(zc == z[l])
        clock$tick()$print()
}
SRR[(lk-1)*ni*nj+(lj-1)*ni+li,] <- adjoints
colnames(SRR) <- fieldNames[-1]

## output SRR.TXT
write.table(t(c('NSEN=','I=','J=','K=')), srrFile, col.names = FALSE, row.names = FALSE)
write.table(t(c(M, ni, nj, nk)), srrFile, col.names = FALSE, row.names = FALSE, append = TRUE)
write.table(SRR, srrFile, col.names = TRUE, row.names = FALSE, append = TRUE)