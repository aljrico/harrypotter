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

slytherin <- c("#C2C5C0", "#A6B39C", "#BBA27C", "#6A915F", "#4C7F46", "#316E31", "#1F5D25")
gryffindor <- c("#5C0000", "#890000", "#C50000", "#FB7E00", "#FFA700")
hufflepuff <- c("#ECB939", "#F0C75E", "#726255", "#372E29", "#000000")
ravenclaw <- c("#0D6585", "#089EC7", "#BA9368", "#735145", "#2B1C13")

df <- grDevices::col2rgb(slytherin) %>%
	t() %>%
	as.data.frame() %>%
	dplyr::rename(V1 = red) %>%
	dplyr::rename(V2 = green) %>%
	dplyr::rename(V3 = blue) %>%
	dplyr::mutate(movie = "slytherin")

map <- rbind(map, df)

df <- grDevices::col2rgb(gryffindor) %>%
	t() %>%
	as.data.frame() %>%
	dplyr::rename(V1 = red) %>%
	dplyr::rename(V2 = green) %>%
	dplyr::rename(V3 = blue) %>%
	dplyr::mutate(movie = "gryffindor")

map <- rbind(map, df)

df <- grDevices::col2rgb(hufflepuff) %>%
	t() %>%
	as.data.frame() %>%
	dplyr::rename(V1 = red) %>%
	dplyr::rename(V2 = green) %>%
	dplyr::rename(V3 = blue) %>%
	dplyr::mutate(movie = "hufflepuff")

map <- rbind(map, df)

df <- grDevices::col2rgb(ravenclaw) %>%
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

