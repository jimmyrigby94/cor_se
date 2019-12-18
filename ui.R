library(shiny)
library(plotly)
library(shinydashboard)

ui<-dashboardPage(
  dashboardHeader(title = "Incremental Benefits of Larger N",
                  titleWidth = "350"),
    dashboardSidebar(
        numericInput("r",
                    "Correlation",
                    min = -1,
                    max = 1,
                    value = .5,
                    step = .001),
        numericInput("n_min",
                    "Minimum # Observations",
                    min = 3,
                    max = 1000,
                    value = 3,
                    step = 1),
        numericInput("n_max",
                    "Maximum # Observations",
                    min = 4,
                    max = 1000,
                    value = 365,
                    step = 1),
        numericInput("prop",
                    "Proposed Sample Size",
                    min = 3,
                    max = 1000,
                    value = 30,
                    step = 1),
        numericInput("ci_p",
                    "Confidence Interval P",
                    min = .001,
                    max = .999,
                    value = .95,
                    step = .001),
        checkboxInput("opt",
                      "Select Sample Size Based on Derivative of SE?",
                      value = FALSE),
        conditionalPanel("input.opt==true", 
                         numericInput("threshold", 
                                      label = "Threshold for Derivative", 
                                      value = -.0015, 
                                      min = -.1, 
                                      max = -.0000001, 
                                      step = .0000001)
                         ),
        actionButton("plot", "Update Plots")
        
    ),
    dashboardBody(
        tags$head(tags$style(HTML('
        .skin-blue .main-header .logo {
          background-color: #3c8dbc;
        }
        .skin-blue .main-header .logo:hover {
          background-color: #3c8dbc;
        }
      '))),
        
        fluidRow(
            box(title = "How is n related to SE?",
                plotlyOutput("se_plot"),
                collapsible = TRUE
                ), 
            box(title = "How much does one more observation reduce SE?",
                plotlyOutput("deriv_plot"),
                collapsible = TRUE
                )
            ),
        fluidRow(
            box(title = "How is the CI related to n?",
                plotlyOutput("ci_plot"),
                collapsible = TRUE
                ),
            box(title = "How does the width of the CI shrink as n gets larger?",
              plotlyOutput("ci_width_plot"),
              collapsible = TRUE
            )
            )
        
    )
)


# Define UI for application that draws a histogram
shinyUI(ui)
