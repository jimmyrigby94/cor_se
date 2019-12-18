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
source("n_deriv_solver.R")

shinyServer(function(input, output) {
    

# Handling when update button is pushed using eventReactive() -------------
    
    gen_data_event<- eventReactive(input$plot, {
        gen_se_data(input$r, input$n_min, input$n_max, input$prop, input$ci_p)
    }, ignoreNULL = FALSE
    )

    solution_event<-eventReactive(input$plot, {
        n_deriv_solver(input$r, target = input$threshold)
    }, ignoreNULL = FALSE
    )
    
    
    se_plot_event<-eventReactive(input$plot, {
        plot_se_r(generate_data(), input$r, input$n_min, input$n_max, input$prop, input$ci_p, input$opt, solution())
    }, ignoreNULL = FALSE
    )
    
    deriv_plot_event<-eventReactive(input$plot, {
        plot_deriv_r(generate_data(), input$r, input$n_min, input$n_max, input$prop, input$ci_p, input$opt, solution())
    }, ignoreNULL = FALSE
    )
    
    ci_plot_event<-eventReactive(input$plot, {
        plot_ci_r(generate_data(), input$r, input$n_min, input$n_max, input$prop, input$ci_p, input$opt, solution())
    }, ignoreNULL = FALSE
    )
    
    ci_width_plot_event<-eventReactive(input$plot, {
        plot_ci_width_r(generate_data(), input$r, input$n_min, input$n_max, input$prop, input$ci_p, input$opt, solution())
    }, ignoreNULL = FALSE
    )


# Defining Reactive events and data ---------------------------------------
    
    
    generate_data<-reactive({
        gen_data_event()
    })
    
    solution<-reactive({
        solution_event()
    })


# Plotting Output ---------------------------------------------------------

    output$se_plot <- renderPlotly(
        se_plot_event()
        
    )
    
    output$deriv_plot <- renderPlotly(
        deriv_plot_event()
        
    )
    
    output$ci_plot <- renderPlotly(
        ci_plot_event()
        
    )
    
    output$ci_width_plot <- renderPlotly(
        
        ci_width_plot_event()
    )
    

})
