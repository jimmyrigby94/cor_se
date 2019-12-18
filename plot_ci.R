library(tidyverse)


# Plot the function as an interactive plot with pretty labels
# n_min = lowest sample size
# n_max = maximum sample size
# prop = proposed sample size
# ci_p = confidence interval precision (defaults to 95%)
plot_ci_r<-function(data, r, n_min, n_max, prop, ci_p=.95, opt, thresh){
  
  # Solves for the critical p used to create the confidence intervals -------
  
  crit_p<-1-((1-ci_p)/2)
  
  # Using the simulated data, plots the standard error curve and applies the labels
  p<-data%>%
    ggplot(aes(x = n, y = upper, text = text_ci, group = 1))+
    geom_line()+
    geom_line(aes(y = lower))+
    labs(x = "Number of Observations", 
         y = paste0(ci_p*100,  "% CI"),
         title = paste("Confidence Interval of the Correlation \nGenerated Using Fisher's Transformation"))+
    geom_vline(xintercept = prop, lty = 3)+
    geom_text(label = paste0("Proposed Sample Size = ", prop),
              x = .8*n_max ,
              y = ifelse(r<.55, max(data$upper)*.9, min(data$lower)*.8),
              hjust = "left")+
    geom_text(label = paste0("Confidence Interval: ", 
                             ci_p*100, 
                             "% [", 
                             round(ci_bound(r, crit_p, prop, FALSE),2), 
                             ", ",
                             round(ci_bound(r, crit_p, prop, TRUE),2),
                             "]"),
              x = .8*n_max ,
              y = ifelse(r<.55, max(data$upper)*.8, min(data$lower)*.9),
              hjust = "left")+
    theme(panel.grid = element_blank(),
          panel.background = element_blank(),
          axis.line.x = element_line(),
          axis.line.y = element_line())
  
  if(opt){
    p<-p+
      geom_point(data = NULL, aes(x = thresh, 
                                  y = (ci_bound(r, crit_p, thresh, FALSE)),
                                  text = data$text_width[data$n == thresh]))+
      geom_point(data = NULL, aes(x = thresh, 
                                  y = (ci_bound(r, crit_p, thresh, TRUE)),
                                  text = data$text_ci[data$n == thresh]))
  }

  
  # Makes plot interactive and uses the hover labels
  plotly::ggplotly(p, tooltip = c("text"))
}