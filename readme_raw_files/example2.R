library(tidyverse)
library(raster)
library(rgeos)
library(gtable)
library(grid)
library(readxl)
library(magrittr)
library(harrypotter)
library(geojsonio)

theme_map <- function(...) {
	theme_minimal() +
		theme(
			text = element_text(family = "Ubuntu Regular", color = "#22211d"),
			axis.line = element_blank(),
			axis.text.x = element_blank(),
			axis.text.y = element_blank(),
			axis.ticks = element_blank(),
			axis.title.x = element_blank(),
			axis.title.y = element_blank(),
			# panel.grid.minor = element_line(color = "#ebebe5", size = 0.2),
			panel.grid.major = element_line(color = "#ebebe5", size = 0.2),
			panel.grid.minor = element_blank(),
			plot.background = element_rect(fill = "#f5f5f2", color = NA),
			panel.background = element_rect(fill = "#f5f5f2", color = NA),
			legend.background = element_rect(fill = "#f5f5f2", color = NA),
			panel.border = element_blank(),
			...
		)
}

data <- read.csv("https://github.com/grssnbchr/thematic-maps-ggplot2/blob/master/input/avg_age_15.csv", stringsAsFactors = F)

gde_15 <- readOGR("https://github.com/grssnbchr/thematic-maps-ggplot2/blob/master/input/geodata/gde-1-1-15.shp", layer = "gde-1-1-15")

