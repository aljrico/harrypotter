library(tidyverse)
devtools::install_github("aljrico/harrypotter")
library(harrypotter)
library(gridExtra)

gg <- ggplot(diamonds, aes(carat, stat(count), fill = cut)) +
	geom_density(position = "fill") +
	xlab("") +
	ylab("")
gg1 <- gg +
	scale_fill_hp(discrete = TRUE, option = "Gryffindor", name = "") +
	ggtitle("Gryffindor")

gg2 <- gg +
	scale_fill_hp(discrete = TRUE, option = "Slytherin", name = "") +
	ggtitle("Slytherin")

gg3 <-gg +
	scale_fill_hp(discrete = TRUE, option = "Hufflepuff", name = "") +
	ggtitle("Hufflepuff")

gg4 <- gg +
	scale_fill_hp(discrete = TRUE, option = "Ravenclaw", name = "") +
	ggtitle("Ravenclaw")

gg <- grid.arrange(gg1,gg2,gg3,gg4)
ggsave("examples/scales_houses.png", gg, width = 300, height = 110, units = "mm", device = "png", dpi = "retina")

