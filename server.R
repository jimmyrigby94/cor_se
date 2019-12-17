library(shiny)
library(plotly)
library(tidyverse)
source("ci_bound.R")
source("deriv_se.R")
source("residual_var.R")
source("se_r.R")
source("plot_se.R")
source("gen_se_data.R")
source("plot_deriv_r.R")
source("plot_ci.R")
source("plot_ci_width.R")

shinyServer(function(input, output) {
    
    generate_data<-reactive({
        gen_se_data(input$r, input$n_min, input$n_max, input$prop, input$ci_p)
    })

    output$se_plot <- renderPlotly(
        
        plot_se_r(generate_data(), input$r, input$n_min, input$n_max, input$prop, input$ci_p)
        
    )
    
    output$deriv_plot <- renderPlotly(
        
        plot_deriv_r(generate_data(), input$r, input$n_min, input$n_max, input$prop, input$ci_p)
        
    )
    
    output$ci_plot <- renderPlotly(
        
        plot_ci_r(generate_data(), input$r, input$n_min, input$n_max, input$prop, input$ci_p)
        
    )
    
    output$ci_width_plot <- renderPlotly(
        
        plot_ci_width_r(generate_data(), input$r, input$n_min, input$n_max, input$prop, input$ci_p)
        
    )

})
