library(ggplot2)
library(harrypotter)

# Histogram on a Continuous (Numeric) Variable
gg <- ggplot(mpg, aes(displ)) +
	geom_histogram(aes(fill=class),
									 binwidth = .1,
									 col="black",
									 size=.1) +  # change binwidth
	labs(title="Discrete Scales",
			 subtitle="Engine Displacement across Vehicle Classes") +
	geom_histogram(aes(fill=class),
									 bins=5,
									 col="black",
									 size=.1) +   # change number of bins
	labs(title="Histogram with Fixed Bins",
			 subtitle="Engine Displacement across Vehicle Classes") +
	scale_fill_hp(discrete=TRUE) +
	ylab("") +
	xlab("Display")

ggsave("examples/hufflepuff_histogram.png", gg, width = 300, height = 110, units = "mm", device = "png", dpi = "retina")
