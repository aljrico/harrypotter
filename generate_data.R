library(tidyverse)
library(data.table)

map <- list()

# Define colours
slytherin <- c("#C2C5C0", "#A6B39C", "#8BA27C", "#6A915F", "#4C7F46", "#316E31", "#1F5D25")
gryffindor <- c("#5C0000", "#890000", "#C50000", "#FB7E00", "#FFA700")
hufflepuff <- c("#000000", "#372E29", "#726255", "#F0C75E", "#ECB939")
ravenclaw <- c("#0D6585", "#089EC7", "#BA9368", "#735145", "#2B1C13")
luna_lovegood <- c("#10182C", "#316969", "#3198A0", "#7B0040", "#8C4154", "#CCD4BB")
draco_malfoy <- c("#000906", "#003C2E", "#45977A", "#4B7366", "#97946E", "#C9DFD2")
ron_weasley <- c("#FF6400", "#FFAA33", "#6C737E", "#3D3A57", "#61002E")
harry_potter <- c("#23231E", "#752520", "#96521B", "#AA8E4B", "#6E693F", "#92A48F")
hermione_granger <- c("#9A336F",  "#CE7877", "#BB7D8C", "#EEC6C4", "#EBDFAF")
#always <- c("#DBFECF", "#BAFFCF", "#77B2A4", "#4A8085", "#2D5157", "#5B696F", "#322934", "#0F0D1A")
mischief <- c("#E7E3AF", "#CCAB6F", "#7D5535", "#662F19", "#761919")
sprout <- c("#76653B", "#F2ED70", "#C0E05E", "#95C34E", "#7B9948")
newt_scamander <- c("#FFC700", "#CCA829", "#B3A36B", "#BEC8CC", "#6B9FB3", "#147399")

always <- c("#CAF2C2", "#98D9A8", "#69B6A3", "#428185", "#1E3C58", "#202B40", "#1E1E32")

options <- list(slytherin = slytherin,
								gryffindor = gryffindor,
								hufflepuff = hufflepuff,
								ravenclaw = ravenclaw,
								lunalovegood = luna_lovegood,
								dracomalfoy = draco_malfoy,
								ronweasley = ron_weasley,
								harrypotter = harry_potter,
								hermionegranger = hermione_granger,
								always = always,
								mischief = mischief,
								sprout = sprout,
								newtscamander = newt_scamander)



# Expand palette to accept contiuous scales or longer discrete scales
complete_palette <- function(option, n = 3e3){
	complete_col <- c()
	for(i in 1:(length(option)-1)){
		cols <- colorRampPalette(c(option[i], option[i+1]))
		complete_col <- c(complete_col, cols(n))
	}
	return(complete_col)
}

# Build DF map
make_map <- function(option){
	options[[option]] %>%
		complete_palette() %>%
		grDevices::col2rgb() %>%
		t() %>%
		as.data.frame() %>%
		dplyr::rename(V1 = red) %>%
		dplyr::rename(V2 = green) %>%
		dplyr::rename(V3 = blue) %>%
		dplyr::mutate(option = option)
}

for(h in names(options)){
	df <- make_map(h)
	map <- rbind(map,df)
}


hp.map <- map
save(hp.map, file = "data/hp.map.rda", ascii = FALSE, compress = 'xz')
usethis::use_data(hp.map, internal = TRUE, overwrite = TRUE)

