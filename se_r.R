# Solve for standard error of correlation (r) given the sample size (n)
#

se_r<-function(r, n){
  residual_var(r)/sqrt(n-2)
}