\name{phylolmSEM-package}

\alias{phylolmSEM-package}

\alias{phylolmSEM}

\docType{package}

\title{
Phynegetic piecewise Structural Equation Modeling
}

\description{
Implements Phynegetic piecewise structural equation modeling in R, complete with goodness-of-fit tests and retrieval of model coefficients. Compared with traditional variance-covariance based SEM, piecewise SEM allows for fitting of models to different distributions and/or incorporates hierarchical/nested random structures.

Supported model classes include: `lm`, `rq`, `glm`, `glm.nb`, `gls`, `phylolm`, `merMod`, `merModLmerTest`, `lme`, `glmmPQL`, `glmmadmb`, and `glmmTMB`.
}

\details{

\tabular{ll}{
Package: \tab PhylolmSEM\cr
Type: \tab Package\cr
Version: \tab 0.0.1\cr
Date: \tab 2023-7-22\cr
Depends: \tab R (4.2), ggm, lavaan, nlme, pbkrtest,phylolm\cr
Suggests: \tab MASS, lme4\cr
License: \tab MIT\cr
}

The primary functions in the package are \code{\link{sem.fit}} which performs goodness-of-fit tests, and \code{\link{sem.coefs}} which returns path coefficients (standardized, if specified) and standard errors.
}

\author{
 Wuchao Gao <sichuangwc@gmail.com>
}

\references{
Shipley, Bill. "A new inferential test for path models based on directed acyclic graphs." Structural Equation Modeling 7.2 (2000): 206-218.

Shipley, Bill. Cause and correlation in biology: a user's guide to path analysis, structural equations and causal inference. Cambridge University Press, 2002.

Shipley, Bill. "Confirmatory path analysis in a generalized multilevel context." Ecology 90.2 (2009): 363-368.

Shipley, Bill. "The AIC model selection method applied to path analytic models compared using a d-separation test." Ecology 94.3 (2013): 560-564.
}

\keyword{ package }

\examples{
#install.packages
library(caper)
library(phylolm)
library(phylolmSEM)


# Load example data
data(shorebird)

# comparative dataset for example
shorebird <- comparative.data(shorebird.tree, shorebird.data, Species, vcv=TRUE, vcv.dim=3)



# Create list of models 
shorebird <- comparative.data(shorebird.tree, shorebird.data, Species, vcv=TRUE, vcv.dim=3)
modelList <- list(
  phylolm (log(Egg.Mass) ~ log(M.Mass)+log(F.Mass)+log(Cl.size), data=shorebird$data,phy=shorebird$phy, model='lambda'),
  phylolm(log(F.Mass) ~ log(M.Mass), data=shorebird$data,phy=shorebird$phy, model='lambda')
)
# Get goodness-of-fit and AIC
sem.fit(modelList, shorebird)
# Extract path coefficients
sem.coefs(modelList)
#Extract R square
sem.model.fits(modelList)
  }
}