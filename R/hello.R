# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

library(tidyverse)
library(data.table)
library(RcppRoll)

a <- rnorm(1e4)
b <- rnorm(1e4) + 2*rexp(1e4)

filename <- "data/hp_3.txt"


df <- fread(filename) %>%
	dplyr::mutate(V1 = gsub(".*:","",V1) %>% as.numeric()) %>%
	dplyr::filter(!(V1 == 0 & V2 == 0 & V3 == 0)) %>%
	dplyr::mutate(movie = i) %>%
	data.table()


rgb2hex <- function(r,g,b) rgb(r, g, b, maxColorValue = 255)


# Sharp ---------------------------------------------------------------------
df <- df %>%
	dplyr::filter(!(V1 == 0 & V2 == 0 & V3 == 0)) %>%
	dplyr::mutate(hex = rgb2hex(V1,V2,V3))

colours <- df[["hex"]]

cbind(a,b) %>% as_tibble() %>%
	ggplot() +
	geom_point(aes(y = a, x = b, colour = b)) +
	scale_colour_gradientn(colors=colours)



# Smooth Mean ------------------------------------------------------------------
nv1 = roll_mean(df$V1, n = length(df$V1)/2e2)
nv2 = roll_mean(df$V2, n = length(df$V2)/2e2)
nv3 = roll_mean(df$V3, n = length(df$V3)/2e2)

df2 <- cbind(V1 = nv1, V2 = nv2, V3 = nv3) %>% as.matrix() %>% as_tibble

df2 <- df2 %>%
	dplyr::filter(!(V1 == 0 & V2 == 0 & V3 == 0)) %>%
	dplyr::mutate(hex = rgb2hex(V1,V2,V3))

colours <- df2[["hex"]]

cbind(a,b) %>% as_tibble() %>%
	ggplot() +
	geom_point(aes(y = a, x = b, colour = b)) +
	scale_colour_gradientn(colors=colours)


# Smooth Median -----------------------------------------------------------
nv1 = roll_median(df$V1, n = length(df$V1)/2e2)
nv2 = roll_median(df$V2, n = length(df$V2)/2e2)
nv3 = roll_median(df$V3, n = length(df$V3)/2e2)

df3 <- cbind(V1 = nv1, V2 = nv2, V3 = nv3) %>% as.matrix() %>% as_tibble

df3 <- df3 %>%
	dplyr::filter(!(V1 == 0 & V2 == 0 & V3 == 0)) %>%
	dplyr::mutate(hex = rgb2hex(V1,V2,V3))

colours <- df3[["hex"]]

cbind(a,b) %>% as_tibble() %>%
	ggplot() +
	geom_point(aes(y = a, x = b, colour = b)) +
	scale_colour_gradientn(colors=colours)


# Smooth Max -----------------------------------------------------------
nv1 = roll_max(df$V1, n = length(df$V1)/5e1)
nv2 = roll_max(df$V2, n = length(df$V2)/5e1)
nv3 = roll_max(df$V3, n = length(df$V3)/5e1)

df4 <- cbind(V1 = nv1, V2 = nv2, V3 = nv3) %>% as.matrix() %>% as_tibble

df4 <- df4 %>%
	dplyr::filter(!(V1 == 0 & V2 == 0 & V3 == 0)) %>%
	dplyr::mutate(hex = rgb2hex(V1,V2,V3))

colours <- df4[["hex"]]

cbind(a,b) %>% as_tibble() %>%
	ggplot() +
	geom_point(aes(y = a, x = b, colour = b)) +
	scale_colour_gradientn(colors=colours)

# Smooth Min -----------------------------------------------------------
nv1 = roll_min(df$V1, n = length(df$V1)/5e1)*2
nv2 = roll_min(df$V2, n = length(df$V2)/5e1)*2
nv3 = roll_min(df$V3, n = length(df$V3)/5e1)*2

df5 <- cbind(V1 = nv1, V2 = nv2, V3 = nv3) %>% as.matrix() %>% as_tibble

df5 <- df5 %>%
	dplyr::filter(!(V1 == 0 & V2 == 0 & V3 == 0)) %>%
	dplyr::mutate(hex = rgb2hex(V1,V2,V3))

colours <- df5[["hex"]]

cbind(a,b) %>% as_tibble() %>%
	ggplot() +
	geom_point(aes(y = a, x = b, colour = b)) +
	scale_colour_gradientn(colors=colours)
