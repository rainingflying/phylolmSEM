## ---- message = FALSE, results = "hide"----------------------------------
# library(devtools)
# install_github("jslefche/piecewiseSEM")
library(phylolmSEM)
library(phylolm)
## ------------------------------------------------------------------------
data(shipley2009)

## ---- message = FALSE, results = "hide"----------------------------------
modelList <- list(
  phylolm (log(Egg.Mass) ~ log(M.Mass)+log(F.Mass)+log(Cl.size), data=shorebird$data,phy=shorebird$phy, model='lambda'),
  phylolm(log(F.Mass) ~ log(M.Mass), data=shorebird$data,phy=shorebird$phy, model='lambda')
)


sem.fit(modelList, shorebird)
sem.coefs(modelList)
sem.model.fits(modelList)
rsquared(modelList)