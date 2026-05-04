# You Should Probably Map That: Introduction to Geospatial Analysis in R

## 1. Overview

This repository contains slides, data, and code used in the R/Medicine 2026 conference presentation. The demo will cover how to first use {ggplot} to make maps, then use {sf} and {tmap} to map shapefiles. 

## 2. Folder Structure

Things are organized as following:

* `code`: code for the demo
* `data`: datasets used for the demo
* `presentation`: materials presented during the lecture portion

## 3. Data Sources

* `cancer_by_state_2003_2022.csv` is from the [CDC U.S. Cancer Statistics](https://www.cdc.gov/united-states-cancer-statistics/publications/uscs-highlights.html) surveillance system.
* `cases_by_borough.csv` is population data from [NYC Open Data](https://opendata.cityofnewyork.us/) and a random count of "patients" 
* `nybb` is the shapefile for NYC borough boundaries from [NYC Open Data](https://opendata.cityofnewyork.us/)
* `nyc_supermarkets` is the shapefile for NYC supermarket locations from from [NYC Open Data](https://opendata.cityofnewyork.us/)

## 4. Requirements

You will need to have R downloaded and the following packages installed:

* `{tidyverse}`
* `{sf}`
* `{tmap}`


