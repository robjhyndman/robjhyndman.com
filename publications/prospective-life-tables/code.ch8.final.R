# Using demography v1.17 and forecast v5.1
## not necessarily complete for all plots and includes some plots not shown
## this file has been amended to accommodate copy-editor's changes to titles

# Load packages
library(demography)
library(MortalitySmooth)

# LOAD DATA FROM HUMAN MORTALITY DATABASE www.mortality.org
usa <- hmd.mx("USA", "username", "password", "USA") ### HMD username & password

usa1950 <- extract.years(usa, years = 1950:2010)

# HU SMOOTHING
plot(usa1950, years = 2003, series = "male", type = "p", pch = 1, main = "")

smus <- smooth.demogdata(usa)
smus1950 <- extract.years(smus, years = 1950:2010)

plot(
  usa1950,
  years = 2003,
  series = "male",
  type = "p",
  pch = 1,
  col = "gray",
  main = ""
)
lines(smus1950, years = 2003, series = "male")

# CDE method
Ext <- usa1950$pop$male
Dxt <- usa1950$rate$male * Ext
fitBIC <- Mort2Dsmooth(
  x = usa1950$age,
  y = usa1950$year,
  Z = Dxt,
  offset = log(Ext)
)

par(mfrow = c(1, 2))
plot(
  fitBIC$x,
  log(usa1950$rate$male[, "2003"]),
  xlab = "Age",
  ylab = "Log death rate",
  col = "gray",
  main = "USA: male death rates 2003"
)
lines(fitBIC$x, log(fitBIC$fitted.values[, "2003"] / Ext[, "2003"]))
lines(smus, year = 2003, series = "male", lty = 2)
legend("topleft", lty = 1:2, legend = c("CDE smoothing", "HU smoothing"))

plot(
  fitBIC$y,
  log(Dxt["65", ] / Ext["65", ]),
  xlab = "Year",
  ylab = "Log death rate",
  main = "USA: male death rates age 65",
  col = "gray"
)
lines(fitBIC$y, log(fitBIC$fitted.values["65", ] / Ext["65", ]))
lines(smus$year, log(smus$rate$male["65", ]), lty = 2)
legend("bottomleft", lty = 1:2, legend = c("CDE smoothing", "HU smoothing"))

year <- usa1950$year[seq(1, 62, by = 3)]
age <- usa1950$age[seq(1, 111, by = 3)]

par(mfrow = c(1, 2))
persp(
  age,
  year,
  log(usa1950$rate$male[seq(1, 111, by = 3), seq(1, 62, by = 3)]),
  theta = -30,
  main = "Observed death rates",
  col = grey(.93),
  shade = TRUE,
  xlab = "Age",
  ylab = "",
  zlab = "Log death rate",
  ticktype = "detailed",
  cex.axis = 0.6,
  cex.lab = 0.6
)
persp(
  age,
  year,
  predict(fitBIC)[seq(1, 111, by = 3), seq(1, 62, by = 3)],
  theta = -30,
  main = "Smoothed death rates",
  col = grey(.93),
  shade = TRUE,
  xlab = "Age",
  ylab = "",
  zlab = "Log death rate",
  ticktype = "detailed",
  cex.axis = 0.6,
  cex.lab = 0.6
)

### OTHER METHODS

forecastyears <- 2011:2030
forecastdata <- list(x = usa1950$age, y = forecastyears)
CDEpredict <- predict(fitBIC, newdata = forecastdata, se.fit = TRUE)
whiA <- c(66, 86)
plot(
  usa1950,
  series = "male",
  age = whiA - 1,
  plot.type = "time",
  xlim = c(1950, 2030),
  ylim = c(-6.2, -1),
  xlab = "Year",
  main = "USA: forecast male death rates using 2-dimensional CDE method",
  col = c(1, 2)
)
matlines(forecastyears, t(CDEpredict$fit[whiA, ]), lty = 1, lwd = 2)
matlines(
  forecastyears,
  t(CDEpredict$fit[whiA, ] + 2 * CDEpredict$se.fit[whiA, ]),
  lty = 2
)
matlines(
  forecastyears,
  t(CDEpredict$fit[whiA, ] - 2 * CDEpredict$se.fit[whiA, ]),
  lty = 2
)
legend("bottomleft", lty = 1, col = 1:2, legend = c("Age 65", "Age 85"))

## LEE-CARTER
usa.90 <- extract.ages(usa, ages = 0:90) # all years & combined upper ages
lc.male <- lca(usa.90, "male")
forecast.lc.male <- forecast(lc.male, h = 20)

plot(usa.90, series = "male", main = "")

plot(lc.male) # not shown

plot(forecast.lc.male, plot.type = "component", ylab1 = "bx")

plot(usa, "male", ages = 0:90, ylim = c(-10, 0), lty = 2)
lines(forecast.lc.male)

# LCnone
lcnone.male <- lca(usa.90, "male", adjust = "none")

plot(lcnone.male$kt, ylab = expression(k[t]), ylim = c(-70, 90), xlab = "")
lines(lc.male$kt, lty = 2)
legend("topright", lty = 1:2, legend = c("LCnone", "LC"))

# LC with MLE
lc.mle.male <- lca(usa, "male", adjust = "dxt")
# lines(lc.mle.male$kt,lty=3, col=2)  #not shown

# LM
lm.male <- lca(
  usa.90,
  series = "male",
  adjust = "e0",
  years = 1950:max(usa$year)
)
forecast.lm.male <- forecast(lm.male, h = 20, jumpchoice = "actual")

## BMS
bms.male <- bms(usa.90, series = "male", minperiod = 30, breakmethod = "bms")
forecast.bms.male <- forecast(bms.male, h = 20)
colnames(bms.male$mdevs) <- c("Total", "Base", "Ratio")

plot(bms.male$mdevs, main = "", xlab = "") # main="Mean deviances for base and total models"

bms.male$year[1]
plot(bms.male$kt)

plot(
  usa.90,
  "male",
  years = bms.male$year[1]:max(usa$year),
  ylim = c(-10, 0),
  lty = 2,
  main = ""
) # main="BMS method: observed (1979-2010) and forecast (2011-2030) rates"
lines(forecast.bms.male)

# BMS USING LCA
bms.male <- lca(
  usa.90,
  "male",
  adjust = "dxt",
  chooseperiod = TRUE,
  minperiod = 30,
  breakmethod = "bms"
)
forecast.bms.male <- forecast(bms.male, h = 20)
bms.male$year[1]

### HU
usa1950.100 <- extract.years(
  extract.ages(usa, 0:100),
  years = 1950:max(usa$year)
)
smus1950.100 <- smooth.demogdata(usa1950.100)

fdm.male <- fdm(smus1950.100, "male", order = 3)
forecast.fdm.male <- forecast.fdm(fdm.male, h = 20)

plot(forecast.fdm.male, plot.type = "component")

plot(smus1950.100, series = "male", ylim = c(-10, 0), lty = 2, main = "") # main ="HU method: observed (1950-2010) and forecast (2011-2030) rates"
lines(forecast.fdm.male)

# compare methods - not shown
par(mfrow = c(1, 2))
fdm.male <- fdm(smus, series = "male", method = "rapca")
forecast.fdm.male <- forecast.fdm(fdm.male, h = 20)
plot(forecast.fdm.male)

fdm.male <- fdm(
  smus,
  series = "male",
  method = "classical",
  weight = TRUE,
  beta = 0.1
)
forecast.fdm.male <- forecast.fdm(fdm.male, h = 20)
plot(forecast.fdm.male)

### coherent using HU
usa.pr <- coherentfdm(smus1950.100, weight = TRUE, beta = 0.05)
usa.pr.f <- forecast(usa.pr, h = 20, ic = "bic")

plot(usa.pr.f$ratio$male, plot.type = "component", components = 3) # PRratiocomp.pdf

plot(usa.pr.f$ratio$female, "c", components = 3) # not shown
plot(usa.pr.f$product, "c", components = 3) # not shown

par(mfrow = c(1, 2))
plot(
  usa.pr$product$y,
  ylab = "Log of geometric mean death rate",
  font.lab = 2,
  lty = 2,
  las = 1,
  ylim = c(-10, -1),
  main = "Product function"
)
lines(usa.pr.f$product)
plot(
  sex.ratio(smus1950.100),
  ylab = "Sex ratio of rates: M/F",
  ylim = c(0.7, 3.5),
  lty = 2,
  las = 1,
  font.lab = 2,
  main = "Ratio function"
)
lines(sex.ratio(usa.pr.f))

par(mfrow = c(1, 2))
plot(smus1950.100, series = "male", lty = 2, ylim = c(-11, -1), main = "Males")
lines(usa.pr.f$male)
plot(
  smus1950.100,
  series = "female",
  lty = 2,
  ylim = c(-11, -1),
  main = "Females"
)
lines(usa.pr.f$female)

# coherent e0
e0.fcast.m <- e0(usa.pr.f, PI = TRUE, series = "male", nsim = 2000)
e0.fcast.f <- e0(usa.pr.f, PI = TRUE, series = "female", nsim = 2000)

plot(
  e0.fcast.m,
  ylim = c(65, 85),
  col = "blue",
  fcol = "blue",
  ylab = "Years",
  main = ""
) # main="Product-Ratio method: coherent life expectancy forecasts"
par(new = TRUE)
plot(e0.fcast.f, ylim = c(65, 85), col = "red", fcol = "red", main = "")
# legend("topleft", lty=c(1,1), lwd=c(2,2), col=c("red", "blue"), legend=c("female","male"))
text(1960, 75, "Female")
text(1960, 68, "Male")

# Cohort 1950 plot
usa.pr.f150 <- forecast(usa.pr, h = 150)
com.mx <- cbind(
  smus1950.100$rate$male[1:nrow(usa.pr.f150$male$rate$male), ],
  usa.pr.f150$male$rate$male
)
birthyear <- 1950
mx <- com.mx[1:nrow(com.mx), (birthyear - 1950 + 1):ncol(com.mx)]
cohort.mx <- diag(mx)

plot(
  log(cohort.mx),
  main = "Cohort death rates US males born in 1950",
  ylab = "Log death rate",
  xlab = "Age",
  cex = 0.7
)

mat3d <- persp(
  seq(0, 99, by = 3),
  seq(1950, 1950 + 209, by = 5),
  log(com.mx[seq(1, 100, by = 3), seq(1, 210, by = 5)]),
  theta = -30,
  xlab = "Age",
  ylab = "Year",
  zlab = "Log death rate",
  ticktype = "detailed",
  col = grey(.93),
  shade = TRUE,
  cex = 0.7
)
xyz3d <- trans3d(0:100, birthyear + 0:100, log(cohort.mx), mat3d)
lines(xyz3d, col = "white", lwd = 2)

### end
