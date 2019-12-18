library(tidyverse)


# Plot the function as an interactive plot with pretty labels
# n_min = lowest sample size
# n_max = maximum sample size
# prop = proposed sample size
# ci_p = confidence interval precision (defaults to 95%)
plot_deriv_r<-function(data, r, n_min, n_max, prop, ci_p=.95, opt, thresh){
  
  
  # Solves for the critical p used to create the confidence intervals -------
  
  crit_p<-1-((1-ci_p)/2)
  
  # Using the simulated data, plots the standard error curve and applies the labels
  p<-data%>%
    ggplot(aes(x = n, y = deriv, text = text_deriv, group = 1))+
    geom_line()+
    labs(x = "Number of Observations", 
         y = "Derivative of SE With Respect to n",
         title = "Derivative of SE With Respect to n")+
    geom_vline(xintercept = prop, lty = 3)+
    geom_text(label = paste0("Proposed Sample Size = ", prop),
              x = .8*n_max ,
              y = min(data$deriv)*.85,
              hjust = "left")+
    geom_text(label = paste0("Derivative: ", round(deriv_se(r, prop),7)),
              x = .8*n_max ,
              y = min(data$deriv)*.9,
              hjust = "left")+
    theme(panel.grid = element_blank(),
          panel.background = element_blank(),
          axis.line.x = element_line(),
          axis.line.y = element_line())
  
  if(opt){
    p<-p+
      geom_point(data = NULL, aes(x = thresh, 
                                  y = deriv_se(r, thresh),
                                  text = data$text_deriv[data$n == thresh]))
  }
    
  
  # Makes plot interactive and uses the hover labels
  plotly::ggplotly(p, tooltip = c("text"))
}
