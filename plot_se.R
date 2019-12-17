library(tidyverse)


# Plot the function as an interactive plot with pretty labels
# n_min = lowest sample size
# n_max = maximum sample size
# prop = proposed sample size
# ci_p = confidence interval precision (defaults to 95%)
plot_se_r<-function(data, r, n_min, n_max, prop, ci_p=.95){
  

# Solves for the critical p used to create the confidence intervals -------

  crit_p<-1-((1-ci_p)/2)

  # Using the simulated data, plots the standard error curve and applies the labels
  p<-data%>%
    ggplot(aes(x = n, y = se_r, text = text_se, group = 1))+
    geom_line()+
    labs(x = "Number of Observations", 
         y = "SE of Correlation",
         title = paste("Standard Error of the Correlation when r = ", r, "\n"))+
    geom_vline(xintercept = prop, lty = 3)+
    geom_text(label = paste0("Proposed Sample Size = ", prop),
              x = .8*n_max ,
              y = se_r(r, 3)*.9,
              hjust = "left")+
    geom_text(label = paste0("Standard Error: ", round(se_r(r, prop),2)),
              x = .8*n_max ,
              y = se_r(r, 3)*.85,
              hjust = "left")+
    theme(panel.grid = element_blank(),
          panel.background = element_blank(),
          axis.line.x = element_line(),
          axis.line.y = element_line())
  
  # Makes plot interactive and uses the hover labels
  plotly::ggplotly(p, tooltip = c("text"))
}
