# lfcgmR
The LFC Goal Machine (lfcgmR) is an interactive web application that describes the goalscoring performance of any Liverpool FC player in any era. 

## Try the app
Try the app at [lfcgmR](https://terrydolan.shinyapps.io/lfcgmR). 

## About
You can generate your own plots simply by selecting one or more players from the dropdown list on the Plot tab.

The app plots a player's top level league goals scored in a season against the age of the player at the mid-point of that season. You can therefore compare multiple players (up to 8) across different seasons and eras. You can compare, say: Mo Salah, Luis Suarez and Fernando Torres; or Steven Gerrard and Billy Liddell; or Kenny Dalglish and Kevin Keegan; or Roger Hunt, Ian Rush and Robbie Fowler. Or just admire Gordon Hodgson's goalscoring performance! Have a play with the app and enjoy :-).

The player dropdown list contains all of the LFC players who have scored a top level league goal, from 1894-95 to 2019-2020. The top level is the old 1st Division or the Premier League. That's 395 LFC players, from Abel Xavier to Yossi Benayoun. The player's age used in the plots is their age at the season mid-point, taken to be 1st January.

## Building blocks
The app is open source software, built using R, R Studio, shiny, ggplot2, dplyr, scales and stringr. The app is deployed on the R Studio platform. The R Studio source code is in this github repo.

## Notebook
The [lfcgmR notebook](http://nbviewer.ipython.org/github/terrydolan/lfcgmR/blob/master/lfcgmR.ipynb) generates and validates the required data (based on reference data from lfchistory.net) and prototypes the key parts of the R application. Python is used for the data preparation and analysis, and R is used for the interactive application and plotting. The application's core plotting function uses R's ggplot2.

The notebook contains the key algorithms, some interesting plots and describes how the lfcgmR app is built and deployed.

This remains a hybrid Python and R development. Python infrastructure (pandas, etc) is used to generate and validate the required data; and explore the core plotting function. The Python rpy2 library is used to allow run R commands in a python3 notebook.

## Data source
Special thanks to [lfchistory.net](https://www.lfchistory.net) who provided the LFC reference data.

## Licence

MIT. 

## Acknowledgements

Thanks to the providers of the tools and data.
  
## Last Updated
Terry Dolan, @lfcsorted

Last updated: October 2020
