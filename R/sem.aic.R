sem.aic = function(
  
  modelList, data, corr.errors = NULL, add.vars = NULL, grouping.vars = NULL, grouping.fun = mean,
  adjust.p = FALSE, basis.set = NULL, pvalues.df = NULL, model.control = NULL, .progressBar = TRUE
  
  ) {
  
  if(is.null(basis.set)) basis.set = suppressWarnings(sem.basis.set(modelList, corr.errors, add.vars))
  
  if(is.null(pvalues.df)) pvalues.df = suppressMessages(suppressWarnings(sem.missing.paths(
    
    modelList, data, conditional = FALSE, corr.errors, add.vars, grouping.vars,
    grouping.fun, adjust.p, basis.set, model.control, .progressBar
    
  ) ) )
  
  fisher.c = sem.fisher.c(
    
    modelList, data, corr.errors, add.vars, grouping.vars, grouping.fun, 
    adjust.p, basis.set, pvalues.df, model.control, .progressBar
    
  )
    
  # Calculate likelihood degrees of freedom  
  K = do.call(sum, lapply(modelList, function(i) logLik(i)[[2]]-2))
  
  # Calculate AIC
  AIC = unname(fisher.c[1] + 2 * K)
  
  # Calculate AICc
  n.obs = min(sapply(modelList, function(x) {
    
    if(class(x) == "rq") 
      
      length(na.omit(residuals(x))) else
        
        nobs(x)
    
  } ) )
  
  AICc = unname(fisher.c[1] + 2 * K * (n.obs/(n.obs - K - 1)))
  
  # Return output in a data.frame
  data.frame(
    AIC = round(AIC, 3),
    AICc = round(AICc, 3), 
    K = round(K, 1), 
    n = round(n.obs, 1) )

}
