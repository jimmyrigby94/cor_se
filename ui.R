library(shiny)
library(plotly)
library(shinydashboard)

ui<-dashboardPage(
    dashboardHeader(title = "Incremental Benefits of Larger N",
                    titleWidth = "350"),
    dashboardSidebar(
        sliderInput("r",
                    "Correlation",
                    min = -1,
                    max = 1,
                    value = .5,
                    step = .001),
        sliderInput("n_min",
                    "Minimum # Observations",
                    min = 3,
                    max = 1000,
                    value = 3,
                    step = 1),
        sliderInput("n_max",
                    "Maximum # Observations",
                    min = 4,
                    max = 1000,
                    value = 365,
                    step = 1),
        sliderInput("prop",
                    "Proposed Sample Size",
                    min = 3,
                    max = 1000,
                    value = 30,
                    step = 1),
        sliderInput("ci_p",
                    "Confidence Interval P",
                    min = .001,
                    max = .999,
                    value = .95,
                    step = .001)
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
                background = "black",
                collapsible = TRUE
                ), 
            box(title = "How much does one more observation reduce SE?",
                plotlyOutput("deriv_plot"),
                background = "black",
                collapsible = TRUE
                )
            ),
        fluidRow(
            box(title = "How is the CI related to n?",
                plotlyOutput("ci_plot"),
                background = "black",
                collapsible = TRUE
                ),
            box(title = "How does the width of the CI shrink as n gets larger?",
              plotlyOutput("ci_width_plot"),
              background = "black",
              collapsible = TRUE
            )
            )
        
    )
)


# Define UI for application that draws a histogram
shinyUI(ui)
