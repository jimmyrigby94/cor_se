# cor_se

Explore the relationship between sample size and precision of correlation estimates.

See a brief description of the app and its motivation [here](https://j-rigby.com/about_apps/cor_se.html).

## System Requirements
In addition to R and R Studio, this app depends on the following packages:

    1. shiny
    2. tidyverse
    3. plotly

Before running the app, ensure that these are installed on your machine. 

## How to Run
To run the app without downloading the repository, simply run the following code from your console.

```{r, eval=FALSE}
shiny::runGitHub("cor_se", username = "jimmyrigby94")
```

Alternatively, you can download the repository and run the following code.

```{r, eval=FALSE}
# First clone the repository with git. If you have cloned it into
# ~/shiny_example, first go to that directory, then use runApp().
setwd("~/shiny_example")
runApp()
```