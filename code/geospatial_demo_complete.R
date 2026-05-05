
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

# load contiguous US states from {maps}
us_states <- ggplot2::map_data("state") |>
  mutate(state = stringr::str_to_title(region))

# join US states with cancer data
state_cancer_map <- us_states |>
  inner_join(cancer, by = "state")

# plot cancer by state
ggplot(state_cancer_map, aes(x = long, y = lat)) +
  # add polygon
  geom_polygon(aes(group = group, fill = count)) +
  labs(fill = "Number of Cancer Patients") +
  coord_map() + # CRS remove distortion
  theme_void() # remove background

# get fancy - add dots for NYC and Boston
ne_cities <- tibble::tribble( 
  ~city,    ~lat,     ~long,
  "NYC",    40.730610, -73.935242,
  "Boston", 42.361145, -71.057083
)

# zoom into Northeast and add dots
state_cancer_map |>
  filter(geo_region == "Northeast") |>
  ggplot(aes(x = long, y = lat)) +
  geom_polygon(aes(group = group, fill = count)) +
  geom_point(
    data = ne_cities, mapping = aes(x = long, y = lat), 
    color = "red", size = 3
  ) +
  labs(fill = "Number of Cancer Patients") +
  coord_map() +
  theme_void()


##---------------------------------------------------------------
##                    Mapping with Shapefiles                   -
##---------------------------------------------------------------
# package provides support for "simple features"
# a standardized way to encode spatial vector data
methods(class = "sf") 

# read in NYC borough shapefiles
nybb <- st_read("data/shapefiles/nybb")
class(nybb)
head(nybb)

# read patient counts data
num_pt <- read_csv("data/cases_by_borough.csv")

# join with nybb
nybb <- nybb |>
  inner_join(num_pt, by = c("BoroName" = "borough"))

head(nybb)

# basic map
tm_shape(nybb) + 
  tm_polygons()

tm_shape(nybb) +
  tm_polygons(fill = "BoroName")

# map number of patients
tm_shape(nybb) +
  tm_polygons(
    fill = "num_patients",
    fill.scale = tm_scale_intervals(
      breaks = c(0, 25000, 50000, 75000, 100000)
    ),
    fill.legend = tm_legend(title = "Number of Patients")
  )

# bubble maps
tm_shape(nybb) +
  tm_polygons(
    fill = "population",
    fill.legend = tm_legend(title = "Population")
  ) +
  tm_symbols(
    size = "num_patients",
    size.legend = tm_legend(
      title = "Number of Patients"
    )
  ) 

# read in NYC supermarket locations shapefile
nyc_supermarkets <- st_read("data/shapefiles/nyc_supermarkets")
names(nyc_supermarkets)
head(nyc_supermarkets)

# map point data
tm_shape(nyc_supermarkets) + 
  tm_symbols(col = "black", size = .1, shape = 1)

# join with NYBB
tm_shape(nybb) +
  tm_polygons(fill = "BoroName") + 
  tm_shape(nyc_supermarkets) + 
  tm_symbols(col = "black", size = .1, shape = 1)

# more features
tm_shape(nybb) + 
  tm_polygons(
    fill = "BoroName",
    fill.legend = tm_legend(title = "")
  ) + 
  tm_shape(nyc_supermarkets) + 
  tm_symbols(col = "black", size = .1, shape = 1) +
  tm_compass(
    position = c("right", "top"),
    text.color = "grey",
    color.dark = "grey",
    size = 1
  ) +
  tm_scalebar(
    position = c("center", "bottom"),
    text.color = "grey",
    color.dark = "grey"
  ) +
  tm_legend(
    position = c("left", "top"),
    just = "right"
  ) + 
  tm_credits(
    text = "NYC OpenData, 2023", 
    position = c("right", "bottom"),
    size = 0.5
  )

