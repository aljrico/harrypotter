library(tidyverse)
library(data.table)

map <- tibble()

# Movies ------------------------------------------------------------------

for(i in 1:8){
	filename <- paste0("data-raw/hp_", i, ".txt")
	df <- fread(filename) %>%
		dplyr::mutate(V1 = gsub(".*:","",V1) %>% as.numeric()) %>%
		dplyr::filter(!(V1 == 0 & V2 == 0 & V3 == 0)) %>%
		dplyr::mutate(movie = i) %>%
		# dplyr::group_by(V1, V2, V3, movie) %>%
		# dplyr::filter(row_number(V1) == 1) %>%
		# dplyr::arrange(V1 + V2 + V3) %>%
		data.table()

	map <- rbind(map, df)
}

# Houses ---------------------------------------------------------------

slytherin <- c("#C2C5C0", "#A6B39C", "#8BA27C", "#6A915F", "#4C7F46", "#316E31", "#1F5D25")
gryffindor <- c("#5C0000", "#890000", "#C50000", "#FB7E00", "#FFA700")
hufflepuff <- c("#000000", "#372E29", "#726255", "#F0C75E", "#ECB939")
ravenclaw <- c("#0D6585", "#089EC7", "#BA9368", "#735145", "#2B1C13")



complete_palette <- function(house, n = 100000){
	complete_col <- c()
	for(i in 1:(length(house)-1)){
		cols <- colorRampPalette(c(house[i], house[i+1]))
		complete_col <- c(complete_col, cols(n))
	}
	return(complete_col)
}



df <- grDevices::col2rgb(complete_palette(slytherin)) %>%
	t() %>%
	as.data.frame() %>%
	dplyr::rename(V1 = red) %>%
	dplyr::rename(V2 = green) %>%
	dplyr::rename(V3 = blue) %>%
	dplyr::mutate(movie = "slytherin")

map <- rbind(map, df)

df <- grDevices::col2rgb(complete_palette(gryffindor)) %>%
	t() %>%
	as.data.frame() %>%
	dplyr::rename(V1 = red) %>%
	dplyr::rename(V2 = green) %>%
	dplyr::rename(V3 = blue) %>%
	dplyr::mutate(movie = "gryffindor")

map <- rbind(map, df)

df <- grDevices::col2rgb(complete_palette(hufflepuff)) %>%
	t() %>%
	as.data.frame() %>%
	dplyr::rename(V1 = red) %>%
	dplyr::rename(V2 = green) %>%
	dplyr::rename(V3 = blue) %>%
	dplyr::mutate(movie = "hufflepuff")

map <- rbind(map, df)

df <- grDevices::col2rgb(complete_palette(ravenclaw)) %>%
	t() %>%
	as.data.frame() %>%
	dplyr::rename(V1 = red) %>%
	dplyr::rename(V2 = green) %>%
	dplyr::rename(V3 = blue) %>%
	dplyr::mutate(movie = "ravenclaw")

map <- rbind(map, df)


hp.map <- map
save(map, file = "data/hp.map")
devtools::use_data(hp.map, internal = TRUE, overwrite = TRUE)

