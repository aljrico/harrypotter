library(tidyverse)
library(data.table)
library(RcppRoll)


map <- tibble()
for(i in 1:8){

	filename <- paste0("data/hp_", i, ".txt")
	df <- fread(filename) %>%
		dplyr::mutate(V1 = gsub(".*:","",V1) %>% as.numeric()) %>%
		dplyr::filter(!(V1 == 0 & V2 == 0 & V3 == 0)) %>%
		dplyr::mutate(movie = i) %>%
		data.table()

	map <- rbind(map, df)
}

save(map, file = "data/hp.map")



scale_colour_hp <- function(..., discrete = FALSE, movie = 1) {

	filename <- paste0("data/hp_", movie, ".txt")

	df <- fread(filename) %>%
		dplyr::mutate(V1 = gsub(".*:","",V1)) %>%
		dplyr::mutate(hex = rgb(r = V1, g = V2, b = V3, maxColorValue = 255)) %>%
		data.table()

	colours <- df[["hex"]]

	if (discrete) {
		discrete_scale("colour", paste0("Harry Potter: ", movie ), palette = colours, ...)
	} else {
		scale_color_gradientn(colours = colours)
	}
}