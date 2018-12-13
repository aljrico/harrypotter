library(geojsonio)
spdf <- geojson_read("https://raw.githubusercontent.com/gregoiredavid/france-geojson/master/communes.geojson",  what = "sp")

# Since it is a bit to much data, I select only a subset of it:
spdf = spdf[ substr(spdf@data$code,1,2)  %in% c("06", "83", "13", "30", "34", "11", "66") , ]

# I need to fortify the data AND keep trace of the commune code! (Takes 2 minutes)
library(broom)
spdf_fortified <- tidy(spdf, region = "code")

# Now I can plot this shape easily as described before:
ggplot() +
	geom_polygon(data = spdf_fortified, aes( x = long, y = lat, group = group)) +
	theme_void() +
	coord_map()


# read data
data=read.table("https://www.r-graph-gallery.com/wp-content/uploads/2017/12/data_on_french_states.csv", header=T, sep=";")
head(data)

# Distribution of the number of restaurant?
data %>% ggplot( aes(x=nb_equip)) + geom_histogram(bins=20, fill='skyblue', color='white') + scale_x_log10()

# Make the merge
spdf_fortified = spdf_fortified %>%
	left_join(. , data, by=c("id"="depcom"))

# Note that if the number of restaurant is NA, it is in fact 0
spdf_fortified$nb_equip[ is.na(spdf_fortified$nb_equip)] = 0.001

ggplot() +
	geom_polygon(data = spdf_fortified, aes(fill = nb_equip, x = long, y = lat, group = group)) +
	theme_void() +
	coord_map()

library(viridis)
p <- ggplot() +
	geom_polygon(data = spdf_fortified, aes(fill = nb_equip, x = long, y = lat, group = group) , size=0, alpha=0.9) +
	theme_void() +
	scale_fill_hp(house = "slytherin", trans = "log", breaks=c(1,5,10,20,50,100), name="Number of restaurant", guide = guide_legend( keyheight = unit(3, units = "mm"), keywidth=unit(12, units = "mm"), label.position = "bottom", title.position = 'top', nrow=1) ) +
	labs(
		title = "South of France Restaurant concentration",
		subtitle = "Number of restaurant per city district"
	) +
	theme(
		text = element_text(color = "#22211d"),
		plot.background = element_rect(fill = "#f5f5f2", color = NA),
		panel.background = element_rect(fill = "#f5f5f2", color = NA),
		legend.background = element_rect(fill = "#f5f5f2", color = NA),

		plot.title = element_text(size= 22, hjust=0.01, color = "#4e4d47", margin = margin(b = -0.1, t = 0.4, l = 2, unit = "cm")),
		plot.subtitle = element_text(size= 17, hjust=0.01, color = "#4e4d47", margin = margin(b = -0.1, t = 0.43, l = 2, unit = "cm"))

		legend.position = c(1.7, 0.99)
	) +
	coord_map()
p

