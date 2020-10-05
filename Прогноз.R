library(distcrete)
library(EpiEstim)
library(ggplot2)
library(incidence)
library(projections)
library(epitrix)
library(magrittr)

mu <- 4
sigma <- 3
cv <- sigma / mu
params <- gamma_mucv2shapescale(mu, cv)
params


si <- distcrete("gamma", shape = params$shape,
                scale = params$scale,
                interval = 1, w = 0.5)
si

n=17
dates1=rep(as.Date('2020-07-31'), n)
dates1=dates1+0:(n-1)


inc=as.numeric(readClipboard())
inc=as.incidence(inc, dates=dates1)

set.seed(1)
pred_1 <- project(inc, R = 0.72, si = si, n_days = 15, n_sim = 1000)


plot(inc, alpha = 0.5) %>%
  add_projections(pred_1, boxplots = FALSE, quantiles = c(0.01, 0.5)) +
  theme_bw()+ggtitle("г.Нур-Султан (R=0.72)")
