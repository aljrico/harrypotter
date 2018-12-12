library(ggplot2)
library(harrypotter)

# Histogram on a Continuous (Numeric) Variable
g <- ggplot(mpg, aes(displ))

g + geom_histogram(aes(fill=class),
									 binwidth = .1,
									 col="black",
									 size=.1) +  # change binwidth
	labs(title="Discrete Scales",
			 subtitle="Engine Displacement across Vehicle Classes")

g + geom_histogram(aes(fill=class),
									 bins=5,
									 col="black",
									 size=.1) +   # change number of bins
	labs(title="Histogram with Fixed Bins",
			 subtitle="Engine Displacement across Vehicle Classes") +
	scale_fill_hp(discrete=TRUE) +
	ylab("") +
	xlab("Display")
