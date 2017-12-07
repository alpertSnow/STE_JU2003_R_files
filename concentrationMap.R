############## concentration map ##############
### plot concentration distributions        ###
### using ggplot2                           ###
### Date: 2017-12-07                        ###
### By: xf                                  ###
###############################################

## header
library(ggplot2)

## settings
# Input release location
release.loc <- c(634686,3926036,0)
# Input receptors' locations (transposed)
receptor.n <- 44
receptor.loc <- matrix(c(634483.8, 3925765.1, 0,
                         634596.5, 3925792.0, 0,
                         634713.3, 3925795.4, 0,
                         634768.3, 3925797.4, 0,
                         634910.8, 3925798.9, 0,
                         634319.9, 3925911.1, 0,
                         634476.0, 3925889.8, 0,
                         634634.9, 3925912.0, 0,
                         634803.1, 3925908.4, 0,
                         634926.9, 3925899.6, 0,
                         634313.1, 3926055.6, 0,
                         634459.4, 3926053.9, 0,
                         634928.6, 3926038.1, 0,
                         634180.3, 3926152.3, 0,
                         634340.2, 3926151.7, 0,
                         634480.0, 3926150.7, 0,
                         634618.6, 3926149.0, 0,
                         634697.4, 3926148.5, 0,
                         634804.0, 3926146.8, 0,
                         634929.4, 3926141.6, 0,
                         635045.0, 3926143.7, 0,
                         635203.6, 3926141.8, 0,
                         634184.5, 3926287.7, 0,
                         634323.0, 3926288.3, 0,
                         634460.1, 3926285.3, 0,
                         634600.6, 3926281.2, 0,
                         634695.4, 3926281.7, 0,
                         634780.4, 3926259.9, 0,
                         634947.6, 3926268.9, 0,
                         635056.3, 3926276.5, 0,
                         635186.4, 3926275.4, 0,
                         634341.8, 3926385.4, 0,
                         634480.9, 3926381.4, 0,
                         634621.8, 3926383.4, 0,
                         634804.2, 3926373.6, 0,
                         634946.7, 3926374.9, 0,
                         635059.9, 3926375.4, 0,
                         634343.5, 3926499.3, 0,
                         634464.6, 3926520.0, 0,
                         634622.8, 3926495.2, 0,
                         634780.6, 3926490.1, 0,
                         634930.5, 3926491.1, 0,
                         634602.9, 3926630.6, 0,
                         634777.1, 3926630.1, 0), nrow = 3, ncol = receptor.n)
# Input location mapping info
init.loc <- c(634614.5,3925939.8,0)
target.loc <- c(1900,1400,0)

# Calc translate vector, with vertical modification
transVec <- target.loc - init.loc + c(0,0,0.2)

# Translate and modify the vertical distance
releaseLocation <- round(release.loc + transVec,2)
receptorLocation <- round(t(receptor.loc + transVec),2)

## calculate 
building <- melt(pArray)$value
Bl2Wh <- colorRampPalette(c("#dddddd", "#ffffff"))
jet.colors <- colorRampPalette(c("#00007F", "blue", "#007FFF", "cyan", "#7FFF7F", "yellow", "#FF7F00", "red", "#7F0000"))

## plot map
gg <- ggplot(data= NULL) +
        geom_tile(aes(x=xv, y=yv, fill=building), width = w, height = h) +
        scale_fill_gradientn(colors = Bl2Wh(2)) +
        geom_point(aes(x=receptorLocation[,1], y=receptorLocation[,2], col=mu), size =2) +
        scale_color_gradientn(colors = jet.colors(7))

plot(gg)
