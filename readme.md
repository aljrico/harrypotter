# Harry Potter Colour Palette

Use the color scales in this package to make plots that make use of the palette extracted from the *Harry Potter* movie franchise.
The colours have been extracted taking the average of every frame from every movie of the Harry Potter film series.
You can install this package **harrypotter** from this repository. 


Introduction
============

The [**harrypotter**](http:://github.com/aljrico/harrypotter) package brings to R colour scales extracted by [Alejandro Jimenez Rico](https://github.com/aljrico) from the [**Harry Potter** film series](https://en.wikipedia.org/wiki/Harry_Potter_(film_series))


Installation & Usage
=====

### Install

Just copy and execute this bunch of code and you'll have the last version of the package installed:

``` r
library(devtools)
devtools::install_github("aljrico/harrypotter")
```
Load the packages using

``` r
library(harrypotter)
```

### ggplot

The package contains colour scale functions for **ggplot** plots: `scale_color_hp()` and `scale_fill_hp()`. You can use the other scales with the `movie` or `house` argument in the `ggplot` scales. 

Here is a made up example using the colours from the house of *Hufflepuff*:

``` r
library(ggplot2)
ggplot(data.frame(x = rnorm(10000), y = rnorm(10000)), aes(x = x, y = y)) +
  geom_hex() + coord_fixed() +
  scale_fill_hp(house = "hufflepuff") + theme_bw()
```

<img src="readme_raw_files/figure-markdown_github/tldr_ggplot-1.png" width="672" />



Here the scale from the house *Gryffindor* is used for a cloropleth map of U.S. unemployment:

``` r
unemp <- read.csv("http://datasets.flowingdata.com/unemployment09.csv",
                  header = FALSE, stringsAsFactors = FALSE)
names(unemp) <- c("id", "state_fips", "county_fips", "name", "year",
                  "?", "?", "?", "rate")
unemp$county <- tolower(gsub(" County, [A-Z]{2}", "", unemp$name))
unemp$county <- gsub("^(.*) parish, ..$","\\1", unemp$county)
unemp$state <- gsub("^.*([A-Z]{2}).*$", "\\1", unemp$name)

county_df <- map_data("county", projection = "albers", parameters = c(39, 45))

names(county_df) <- c("long", "lat", "group", "order", "state_name", "county")
county_df$state <- state.abb[match(county_df$state_name, tolower(state.name))]
county_df$state_name <- NULL

state_df <- map_data("state", projection = "albers", parameters = c(39, 45))

choropleth <- merge(county_df, unemp, by = c("state", "county"))
choropleth <- choropleth[order(choropleth$order), ]

ggplot(choropleth, aes(long, lat, group = group)) +
  geom_polygon(aes(fill = rate), colour = alpha("white", 1 / 2), size = 0.2) +
  geom_polygon(data = state_df, colour = "white", fill = NA) +
  coord_fixed() +
  theme_minimal() +
  ggtitle("US unemployment rate by county") +
  theme(axis.line = element_blank(), axis.text = element_blank(),
        axis.ticks = element_blank(), axis.title = element_blank()) +
  scale_fill_hp(house = "gryffindor")
```

<img src="readme_raw_files/figure-markdown_github/ggplot2-1.png" width="672" />

The ggplot functions also can be used for discrete scales with the argument `discrete=TRUE`.

``` r
p <- ggplot(mtcars, aes(wt, mpg))
p + geom_point(size=4, aes(colour = factor(carb))) +
    scale_color_hp(discrete=TRUE, movie = 1) +
    theme_bw()
```

<img src="readme_raw_files/figure-markdown_github/discrete-1.png" width="672" />


### Base R

The `hp()` function produces the Harry Potter colour scales. You can choose which one the other colour scale options using the `movie` or `house` parameter.

For base R plots, you can use the `hp()` function to generate the palette, and add it to the base plot. 

``` r
x <- y <- seq(-8*pi, 8*pi, len = 40)
r <- sqrt(outer(x^2, y^2, "+"))
filled.contour(cos(r^2)*exp(-r/(2*pi)), 
               axes=FALSE,
               color.palette=hp,
               asp=1)
```

<img src="readme_files/figure-markdown_github/tldr_base-1.png" width="672" />


The Colour Scales
=================

The package contains many colour scales, divided in two categories: **Movies** and **Houses**.

### Movies

One for each movie of the franchise.

<img src="readme_raw_files/figure-markdown_github/show_scales-1.png" width="672" />

### Houses

One for each house of Hogwarts.

<img src="readme_raw_files/figure-markdown_github/show_scales2-1.png" width="672" />


