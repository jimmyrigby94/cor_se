# Solves for the derivative of the se of the correlation (r) with respect to the sample size (n)
deriv_se<-function(r, n){
  -sqrt(1 - r^2)/(2*(n-2)^(3/2))
}
