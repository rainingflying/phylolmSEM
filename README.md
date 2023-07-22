# Piecewise Structural Equation Modeling

  Implementation of phygenetic piecewise structural equation modeling (SEM) in R, including estimation of path coefficients and goodness-of-fit statistics. 
  


Version: 0.0.1 (2023-07-22)

Author: wuchao Gao <sichuangwc@gmail.com>

Supported model classes include: 

  `lm`, `glm`, `rq`, `glm.nb`, `gls`, `phylolm`, `merMod`, `merModLmerTest`, `lme`, `glmmPQL`, `glmmadmb`, and `glmmTMB`.
  
###WARNING

***Some tests of directed separation are non-symmetrical -- the partial slope of a ~ b is not the same as b ~ a -- when the variables are non-linear (i.e., are transformed via a link function when fit to a non-normal distribution). We are currently investigating the phenomenon, but in the interim, the latest version of the package returns the lowest P-value. This the more conservative route. Stay tuned for more updates...***

***This is only a problem if you are fitting generalized linear models!!***

##Examples

###Load package

```
# Install dev version from GitHub
# library(devtools)
# install_github("rainingflying/phylolmSEM")

library(phylolmSEM)
```

###Load data from Shipley 2009

```
data(shipley2009)
```
The data is alternately hosted in Ecological Archives E090-028-S1 (DOI: 10.1890/08-1034.1).

###Create model set


The model corresponds to the following hypothesis (Fig. 2, Shipley 2009);

![Shipley 2009 Fig. 2](https://raw.githubusercontent.com/jslefche/jslefche.github.io/master/img/shipley_2009.jpg)

Models are constructed using a mix of the `nlme` and `lmerTest` packages, as in the supplements of Shipley 2009. 

```
# Load required libraries for phylogenetic generalized least squares
library(phylolm)
library(caper)


# Load example data
data(shipley2009)

# Create list of models corresponding to SEM
modelList <- list(
  phylolm (log(Egg.Mass) ~ log(M.Mass)+log(F.Mass)+log(Cl.size), data=shorebird$data,phy=shorebird$phy, model='lambda'),
  phylolm(log(F.Mass) ~ log(M.Mass), data=shorebird$data,phy=shorebird$phy, model='lambda')
)
```

###Run Shipley tests

`sem.fit` returns a list of the following:
(1) the missing paths (omitting conditional variables), the estimate, standard error, degrees of freedom, and associated p-values;
(2) the Fisher's C statistic, degrees of freedom, and p-value for the model (derived from a Chi-squared distribution);
(3) the AIC, AICc (corrected for small sample size), the likelihood degrees of freedom, and the model degrees of freedom.

The argument `add.vars` allows you to specify a vector of additional variables whose causal independence you also wish to test. This is useful if you are comparing nested models. Default is `NULL`.

The argument `adjust.p` allows you to adjust the p-values returned by the function based on the the total degrees of freedom for the model (see supplementary material, Shipley 2013). Default is `FALSE` (uses the d.f. reported in the summary table).


```
sem.fit(modelList, shorebird)
sem.coefs(modelList)
sem.model.fits(modelList)
rsquared(modelList)
```
