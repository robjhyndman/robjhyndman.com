###exercises
# Using demography v1.17 and forecast v5.1

# Load packages
library(demography)
library(MortalitySmooth)  

#ex1 denmark males 20th century

dnk <- hmd.mx("DNK","username","password", "Denmark")   
dnk.ex1 <- extract.ages(extract.years(dnk,1900:1999), 0:95)
dnk.ex1 #check
plot(dnk.ex1,'male')


#ex2 denmark females 1950-
dnk.ex2 <- extract.ages(extract.years(dnk,1950:max(dnk$year)), 0:100)
dnk.ex2
Ext <- dnk.ex2$pop$female
Dxt <- dnk.ex2$rate$female * Ext
fitBIC <- Mort2Dsmooth(x=dnk.ex2$age, y= dnk.ex2$year, Z=Dxt, offset=log(Ext))
sm.dnk.ex2 <- smooth.demogdata(dnk.ex2)

par(mfrow=c(1,2))
plot(fitBIC$x, log(dnk.ex2$rate$female[,"1950"]), xlab="Year", ylab="Log death rate",
    main="Denmark: female death rates 1950", col="gray")
lines(fitBIC$x, log(fitBIC$fitted.values[,"1950"]/Ext[,"1950"]))
lines(sm.dnk.ex2,year=1950, series="female", lty=2)
legend("topleft",lty=1:2, legend=c("CDE smoothing", "HU smoothing"))
plot(fitBIC$x, log(dnk.ex2$rate$female[,"2000"]), xlab="Year", ylab="Log death rate",
     main="Denmark: female death rates 2000", col="gray")
lines(fitBIC$x, log(fitBIC$fitted.values[,"2000"]/Ext[,"2000"]))
lines(sm.dnk.ex2,year=2000, series="female", lty=2)
legend("topleft",lty=1:2, legend=c("CDE smoothing", "HU smoothing"))


#ex3 canada total

can <- hmd.mx("CAN","username","password", "Canada")
can
lc <- lca(can,series="total")
forecast.lc <- forecast(lc, h=20)
lm <- lca(can,series="total", adjust="e0")
forecast.lm <- forecast(lm, h=20)
lc.e0 <- e0(forecast.lc )
lm.e0 <- e0(forecast.lm )
plot(lc.e0, ylim=c(55,85), main="Canada: total mortality")
lines(lm.e0$mean, col= 2, lwd=2)
legend("bottomright", lwd=2, col=c(4,2),legend=c("Lee-Carter","Lee-Miller"))


#ex4 canada total

bms <- bms(can, series="total", minperiod=20, breakmethod="bms")
bms$year # years in fitting period 
forecast.bms <- forecast(bms, h=20)
bms.e0 <- e0(forecast.bms)
bms.e0$mean[20]
lm.e0$mean[20]
lines(bms.e0$mean,col=3, lwd=2)


#ex5 

jpn <- hmd.mx("JPN","username","password", "Japan")
jpn
jpn.sm <- smooth.demogdata(jpn)
fdm.female <- fdm(jpn.sm, "female", order=3)
forecast.fdm.female <- forecast(fdm.female, h=20)
plot(forecast.fdm.female, "c")
plot(forecast.fdm.female)
jpn.fdm.e0 <- e0(forecast.fdm.female, PI=TRUE) 
lc.jpn <- lca(jpn, adjust="none")
jpn.lc.e0 <- e0(forecast(lc.jpn,h=20), PI=TRUE)

plot(jpn.fdm.e0, main="Japan females", ylim=c(50,95),col=2,fcol=2,shadecols ="#ff000040")
par(new=TRUE)
plot(jpn.lc.e0,col=2,fcol=2,flty=2,ylim=c(50,95),main="",lty=2,shadecols ="#ff000040")
legend("bottomright", lwd=2, lty=c(1,2), col=2,legend=c("Hyndman-Ullah","Lee-Carter(unadj)"))


#ex6

jpn
fdm.male <- fdm(jpn.sm, "male", order=3)
forecast.fdm.male <- forecast(fdm.male, h=20)
jpn.fdm.e0.male <- e0(forecast.fdm.male,PI=TRUE)
plot(jpn.fdm.e0, main="Japan", ylim=c(50,92), col=2, fcol=2,shadecols ="#ff000040")
par(new=TRUE)
plot(jpn.fdm.e0.male,col=4, ylim=c(50,92),main="",shadecols = "#0000ff40")
legend("bottomright", lwd=2, col=c(2,4),legend=c("female","male"))


#ex7

jpn
jpn.pr <- coherentfdm(jpn.sm, weight=FALSE) #using HU (unweighted FDM)
jpn.pr.f <- forecast(jpn.pr, h=20)
par(mfrow=c(1,2))
plot(jpn.pr$product$y, ylab="Log of geometric mean death rate", font.lab=2,
       lty=2, las=1, ylim=c(-10,-1), main="Japan: product function")
lines(jpn.pr.f$product)
plot(sex.ratio(jpn.sm), ylab="Sex ratio of rates: M/F", ylim=c(0.7,3.5),
       lty=2, las=1, font.lab=2, main="Japan: ratio function")
lines(sex.ratio(jpn.pr.f))
jpn.pr.e0.female <- e0(jpn.pr.f,"female",PI=TRUE)
jpn.pr.e0.male <- e0(jpn.pr.f,"male",PI=TRUE)

par(mfrow=c(1,1))
plot(jpn.fdm.e0, main="Japan", ylim=c(50,92), col=2, fcol=2,shadecols ="#ff000040",xlab="Note: PR PI shown in grey")
par(new=TRUE)
plot(jpn.fdm.e0.male,col=4, ylim=c(50,92),main="",shadecols = "#0000ff40")
par(new=TRUE)
plot(jpn.pr.e0.female, col=2, fcol=2, ylim=c(50,92),main="", flty=2,shadecols ="#00000f20")
par(new=TRUE)
plot(jpn.pr.e0.male, col=4, fcol=4, ylim=c(50,92),main="",flty=2,shadecols = "#00000f20")
legend("bottomright", lwd=2,lty=c(1,2,1,2), col=c(2,2,4,4),legend=c("FDM female","PR female","FDM male","PR male"))


#ex8

plot(life.expectancy(jpn.sm,series="female",age=0)-life.expectancy(jpn.sm,series="male",age=0),
     main="Life expectancy difference: F-M",ylab="Years",xlab="Year",xlim=c(min(jpn$year),max(jpn$year)+22), ylim=c(0,7))
lines(flife.expectancy(jpn.pr.f$female,age=0)$mean - flife.expectancy(jpn.pr.f$male,age=0)$mean,lwd=2)
lines(flife.expectancy(forecast.fdm.female,age=0)$mean - flife.expectancy(forecast.fdm.male,age=0)$mean,lty=2,lwd=2)
legend("bottomright", lwd=2,lty=c(1,2), legend=c("Coherent", "Independent"))

#end