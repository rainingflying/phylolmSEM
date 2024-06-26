# Phynegetic piecewise Structural Equation Modeling

  Implementation of phygenetic piecewise structural equation modeling (SEM) in R, including estimation of path coefficients and goodness-of-fit statistics. 
  


Version: 0.0.1 (2023-07-22)

Author: wuchao Gao <sichuangwc@gmail.com>

Supported model classes are `phylolm`(PGLS: Phylogenetic Generalised Least Squares）
  
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
library(caper)
```
The data is alternately hosted in Ecological Archives E090-028-S1 (DOI: 10.1890/08-1034.1).

###Create model set
```
# Load required libraries for phylogenetic generalized least squares
library(phylolm)
# Load example data
data(shorebird)
shorebird <- comparative.data(shorebird.tree, shorebird.data, Species, vcv=TRUE, vcv.dim=3)

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
# Get goodness-of-fit and AIC
sem.fit(modelList, shorebird)
# Extract path coefficients
sem.coefs(modelList)
#Extract R square
sem.model.fits(modelList)

```
