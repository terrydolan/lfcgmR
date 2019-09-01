library(shiny)
library(ggplot2)
library(dplyr)
library(scales)

# create the dflfcgm dataframe
dflfcgm <- read.csv('data/lfc_scorers_tl_pos_age.csv', header=TRUE)

# Change log
# v1, February 2016, original
# v2, August 2019, enhance to ensure pretty printing of x and y axis
ggplot_age_vs_lgoals <- function(df, players) {
  # Return ggplot of League Goals vs Age for given players in dataframe.
  #
  #  Given the low number of points, ggplot's geom_smooth uses
  #  the loess method with default span.
  
  TITLE <- 'LFCGMR League Goals vs Age'
  XLABEL <- 'Age at Midpoint of Season'
  YLABEL <- 'League Goals per Season'
  EXEMPLAR_PLAYERS <- c('Ian Rush', 'Kenny Dalglish', 'Roger Hunt', 'David Johnson', 
                        'Harry Chambers', 'John Toshack', 'John Barnes', 'Kevin Keegan')
  EXEMPLAR_TITLE <- 'LFCGMR Example Plot, The Champions: League Goals vs Age

This plot shows the goalscoring performance over their Liverpool career of 
arguably the most important 8 players, those who scored most goals in the 
18 title winning seasons
'
  
  # if players vector is empty then set the default exemplar options
  if (length(players) == 0) {
    players <- EXEMPLAR_PLAYERS
    title <- EXEMPLAR_TITLE
  } else {
    title <- TITLE
  }
  
  # create dataframes to plot...
  # filter those players with only 2 points and those with more than 2
  this_df <- df[df$player %in% players, ]
  this_dfeq2 <- this_df %>% group_by(player) %>% filter(n()==2)
  this_dfgt2 <- this_df %>% group_by(player) %>% filter(n()>2) 
  
  # produce the plot and return it
  this_plot <- ggplot(this_df, aes(x=age, y=league, color=player, shape=player)) + 
    geom_point(size=2) + 
    geom_line(data=this_dfeq2, size=0.5) +
    geom_smooth(data=this_dfgt2, se=FALSE, size=0.8) + 
    xlab(XLABEL) + 
    ylab(YLABEL) + 
    ggtitle(title) + 
    scale_shape_manual(values=0:length(players)) +
    theme(legend.text=element_text(size=10)) + 
    scale_y_continuous(breaks = function(x) unique(floor(pretty(seq(0, (max(x) + 1) * 1.1))))) + 
    ylim(c(0, max(this_df$league)+1)) + 
    scale_x_continuous(breaks = pretty_breaks())
  return (this_plot)
}

shinyServer(function(input, output) {
  
  # output a plot of the selected players in dataframe dflfcgm
  output$plot <- renderPlot({
    players <- input$player_input
    print(players)
    
    # if players is empty (NULL) then set the players to the empty vecor
    if (is.null(players)) {
      print('all player selections empty, so set players to empty vector')
      players <- c()
    }
    
    # plot the age vs league goals for selected players
    plt <- ggplot_age_vs_lgoals(dflfcgm, players)
    print(plt)
  })
  
  # output the 'table' of selected players in dataframe
  output$table <- renderDataTable({
    EXEMPLAR_PLAYERS <- c('Ian Rush', 'Kenny Dalglish', 'Roger Hunt', 'David Johnson', 
                          'Harry Chambers', 'John Toshack', 'John Barnes', 'Kevin Keegan')
    
    players <- input$player_input
    
    # if players is empty (NULL) then set the players to the EXEMPLAR_PLAYERS
    if (is.null(players)) {
      players <- EXEMPLAR_PLAYERS
    }
    
    # rename dataframe columns to more friendly names for display
    names(dflfcgm)[names(dflfcgm) == 'season'] <- 'Season'
    names(dflfcgm)[names(dflfcgm) == 'player'] <- 'Player'
    names(dflfcgm)[names(dflfcgm) == 'league'] <- 'League Goals'
    names(dflfcgm)[names(dflfcgm) == 'position'] <- 'Position'
    names(dflfcgm)[names(dflfcgm) == 'age'] <- 'Age'    
    
    # show the dataframe with players filter
    dflfcgm[dflfcgm$Player %in% players, ]
  })
    
  # output the 'about' for app
  output$about <- renderText({  
    readLines("about.html")  
  })
    
})
