library(shiny)

# create the character vector of players for the player input choices
dflfcgm_dd <- read.csv('data/lfcgm_app_dropdown.csv', header=TRUE)
PLAYER_CHOICES <- levels(dflfcgm_dd$player)
PLAYER_MAX = 8
PLAYER_PROMPT <- paste('Select up to', PLAYER_MAX, 'LFC players to compare:')
PLAYER_PLACEHOLDER = 'Select Player'

shinyUI(pageWithSidebar(
  headerPanel('The LFC Goal Machine'),
  sidebarPanel(
    selectizeInput(
      inputId='player_input', label=PLAYER_PROMPT, 
      choices=PLAYER_CHOICES, multiple=TRUE, 
      options=list(maxItems=PLAYER_MAX, placeholder=PLAYER_PLACEHOLDER)
    ),
    em('lfcgmR version:', lfcgmR_version)
  ),
  
  mainPanel(
    tabsetPanel(type = "tabs", 
                tabPanel("Plot", plotOutput("plot")), 
                tabPanel("Table", dataTableOutput("table")), 
                tabPanel("About", fluidPage(htmlOutput('about')))
    )
  )
))