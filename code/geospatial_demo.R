
# install packages - only do this once!
install.packages("sf")
install.packages("tmap")

# load packages
library(tidyverse)
library(sf)
library(tmap)

options(scipen = 999)

##---------------------------------------------------------------
##                      Mapping with ggplot                     -
##---------------------------------------------------------------

# load cancer data and clean
cancer <- read_csv("data/cancer_by_state_2003_2022.csv") 

# load contiguous US states 

# join US states with cancer data

# plot cancer by state

# get fancy - add dots for NYC and Boston
ne_cities <- tibble::tribble( 
  ~city,    ~lat,     ~long,
  "NYC",    40.730610, -73.935242,
  "Boston", 42.361145, -71.057083
)

# zoom into Northeast and add dots



##---------------------------------------------------------------
##                    Mapping with Shapefiles                   -
##---------------------------------------------------------------
methods(class = "sf") 

# read in NYC borough shapefiles
nybb <- st_read("data/shapefiles/nybb")

# read patient counts data
num_pt <- read_csv("data/cases_by_borough.csv")

# join with nybb

# basic map

# map number of patients

# bubble maps

# read in NYC supermarket locations shapefile
nyc_supermarkets <- st_read("data/shapefiles/nyc_supermarkets")

# map point data

# join with nybb

# more features

