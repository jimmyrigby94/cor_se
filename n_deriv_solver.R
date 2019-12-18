n_deriv_solver<-Vectorize(function(r, target){
  ceiling((-sqrt(1-r^2)/(2*target))^(2/3)+2) 
})
