# Solves for a single bound of a confidence interval using fisher's R to z
# r = correlation
# crit_p = precision of confidence interval
# n = sample size
# upper = upper confidence bound?
ci_bound<-function(r, crit_p, n, upper = TRUE){
  
  zprime<-.5*log((1+r)/(1-r))
  
  if(upper){
    bound<-zprime+qnorm(crit_p)*1/sqrt(n-3)
  }else{
    bound<-zprime-qnorm(crit_p)*1/sqrt(n-3)
  }
  
  tanh(bound)
}