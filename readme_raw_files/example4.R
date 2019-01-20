library(tidyverse)
devtools::install_github("aljrico/harrypotter")
library(harrypotter)
library(gridExtra)


# ronweasley_bar -----------------------------------------------------

gg <- ggplot(diamonds, aes(factor(color), fill=factor(cut))) +
	geom_bar(colour = "black") +
	scale_fill_hp_d(option = "ronweasley2", name = "Cut") +
	ylab("") +
	xlab("Colour") +
	coord_flip()

ggsave("examples/ronweasley_bar.png", gg, width = 300, height = 110, units = "mm", device = "png", dpi = "retina")



# lunalovegood_scatter ----------------------------------------------------


dsamp <- diamonds[sample(nrow(diamonds), 1000), ]
gg <- ggplot(dsamp, aes(carat, price)) +
	geom_point(aes(colour = clarity)) +
	scale_colour_hp(discrete = TRUE, option = "LunaLovegood", name = "Clarity") +
	xlab("Carat") +
	ylab("Price")

ggsave("examples/lunalovegood_scatter.png", gg, width = 300, height = 110, units = "mm", device = "png", dpi = "retina")



# sprout_bar --------------------------------------------------------------


gg <- ggplot(diamonds, aes(x = price, fill = cut)) +
	geom_histogram(position = "dodge", binwidth = 1000) +
	scale_x_continuous(limits = c(4000,12000)) +
	xlab("Price") +
	ylab("") +
	scale_fill_hp_d(option = "sprout",  name = "Cut")

ggsave("examples/sprout_bar.png", gg, width = 300, height = 110, units = "mm", device = "png", dpi = "retina")



# positive/negative -------------------------------------------------------

df <- data.frame(ID = c(1:10),Diff = c(-5:4))
df$colour <- ifelse(df$Diff < 0, "firebrick1","steelblue")
df$hjust <- ifelse(df$Diff > 0, 1.3, -0.3)
df$colour <- ifelse(df$Diff < 0, "negative","positive")
gg <- ggplot(df, aes(ID, Diff, fill = colour))+
	geom_bar(stat = "identity", position = "identity", colour = "black", size = 0.4) +
	scale_fill_hp_d(option = "newtscamander", direction = -1, name = "", labels = c("Negative", "Positive"))

ggsave("examples/newtscamander_posneg.png", gg, width = 300, height = 110, units = "mm", device = "png", dpi = "retina")



# mischief_tile -----------------------------------------------------------


gg1 <- ggplot(faithfuld) +
	geom_tile(aes(waiting, eruptions, fill = density)) +
	xlab("Waiting") +
	ylab("Eruptions") +
	scale_fill_hp(option = "Mischief", name = "Density") +
	theme_minimal() +
	ggtitle("Mischief")

gg2 <- ggplot(faithfuld) +
	geom_tile(aes(waiting, eruptions, fill = density)) +
	xlab("Waiting") +
	ylab("Eruptions") +
	scale_fill_hp(option = "Always", name = "Density") +
	theme_minimal() +
	ggtitle("Always")

gg <- grid.arrange(gg1,gg2, ncol = 2)

ggsave("examples/mischief_always_tile.png", gg, width = 300, height = 110, units = "mm", device = "png", dpi = "retina")


# hufflepuff_histogram ----------------------------------------------------

gg <- ggplot(mpg, aes(displ)) +
	geom_histogram(aes(fill = class),
								 binwidth = .1,
								 col = "black",
								 size = 0.1) +
	labs(title = "Discrete Scales",
			 subtitle = "Engine Displacement across Vehicle Classes") +
	geom_histogram(aes(fill = class),
								 bins = 5,
								 col = "black",
								 size = 0.1) +   # change number of bins
	labs(title="Histogram with Fixed Bins",
			 subtitle="Engine Displacement across Vehicle Classes") +
	scale_fill_hp(discrete=TRUE) +
	ylab("") +
	xlab("Display")

ggsave("examples/hufflepuff_histogram.png", gg, width = 300, height = 110, units = "mm", device = "png", dpi = "retina")




# gryffindor_volcano ------------------------------------------------------

pal1 <- hp(8, house = "Gryffindor") # Left Image
gg1 <- ggplotify::as.ggplot(~image(volcano, col = pal1))


pal2 <- hp(128, house = "Gryffindor") # Right Image
gg2 <- ggplotify::as.ggplot(~image(volcano, col = pal2))

gg <- grid.arrange(gg1,gg2, ncol = 2)

ggsave("examples/gryffindor_volcano.png", gg, width = 300, height = 110, units = "mm", device = "png", dpi = "retina")




