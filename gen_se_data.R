gen_se_data<-function(r, n_min, n_max, prop, ci_p=.95){
  
  crit_p<-1-((1-ci_p)/2)
  
  data.frame(n = n_min:n_max)%>%
    rowwise()%>%
    mutate(se_r = se_r(r, n), 
           upper = ci_bound(r, crit_p, n), 
           lower = ci_bound(r, crit_p, n, FALSE), 
           deriv = deriv_se(r, n))%>%
    ungroup()%>%
    mutate(text_se = paste0("Number of Observations: ", n,
                         "<br>Standard Error of Correlation: ", round(se_r, 2)),
           text_ci = paste0("Number of Observations: ", n,
                            "<br>CI: [", round(lower, 2), ", ", round(upper, 2), "]"),
           text_deriv = paste0("Number of Observations: ", n,
                               "<br>Derivative WRT n: ", round(deriv, 7)),
           text_width = paste0("Number of Observations: ", n,
                               "<br>Width:", round(abs(upper - lower), 2)),
           ci_dif = abs(upper-lower))
}