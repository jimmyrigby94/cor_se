# Solves for the residual variance given correlation (r)
residual_var<-function(r){
  sqrt(1-r^2)
}