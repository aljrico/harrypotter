#' Original 'Harry Potter' colour map
#'
#' A dataset containing the colour palettes of each house of Hogwarts school.
#'
#'
#'@format A data frame containing all the colours used in the palette:
#'\itemize{
#'   \item V1: Red value
#'   \item V2: Green value
#'   \item V3: Blue value
#'   \item house: Refers to the house of Hogwarts. It is intended to be a general option for choosing the specific colour palette.
#'}
"hp.map"




#' Harry Potter Colour Map.
#'
#' This function creates a vector of \code{n} equally spaced colors along the
#' 'HP colour map' created by an average calculated for all the colours present in every frame of the pictures.
#'
#' @param n The number of colors (\eqn{\ge 1}) to be in the palette.
#'
#' @param alpha	The alpha transparency, a number in [0,1], see argument alpha in
#' \code{\link[grDevices]{hsv}}.
#'
#' @param begin The (corrected) hue in [0,1] at which the hp colormap begins.
#'
#' @param end The (corrected) hue in [0,1] at which the hp colormap ends.
#'
#' @param direction Sets the order of colors in the scale. If 1, the default, colors
#' are ordered from darkest to lightest. If -1, the order of colors is reversed.
#'
#' @param house A character string indicating the colourmap from a house to use.
#' Four houses are available: "Gryffindor", "Slytherin", "Ravenclaw" and "Hufflepuff".
#'
#' @return \code{hp} returns a character vector, \code{cv}, of color hex
#' codes. This can be used either to create a user-defined color palette for
#' subsequent graphics by \code{palette(cv)}, a \code{col =} specification in
#' graphics functions or in \code{par}.
#'
#' @author Alejandro Jiménez Rico \email{aljrico@@gmail.com}, \href{https://aljrico.github.io}{Personal Blog}
#'
#' @details
#'
#' \if{html}{Here are the color scales:
#'
#'   \out{<div style="text-align: center">}\figure{hogwarts_scales.png}{houses: style="width:750px;max-width:90\%;"}\out{</div>}
#'
#'   }
#' \if{latex}{Here are the color scales:
#'
#'   \out{\begin{center}}\figure{hogwarts_scales.png}\out{\end{center}}
#'   }
#'
#'
#' Semi-transparent colors (\eqn{0 < alpha < 1}) are supported only on some
#' devices: see \code{\link[grDevices]{rgb}}.
#'
#' @examples
#' library(ggplot2)
#' library(hexbin)
#'
#' dat <- data.frame(x = rnorm(10000), y = rnorm(10000))
#'
#' ggplot(dat, aes(x = x, y = y)) +
#'   geom_hex() + coord_fixed() +
#'   scale_fill_gradientn(colours = hp(256, house = "Hufflepuff"))
#'
#' # using code from RColorBrewer to demo the palette
#' n = 200
#' image(
#'   1:n, 1, as.matrix(1:n),
#'   col = hp(n, house = "Slytherin"),
#'   xlab = "hp n", ylab = "", xaxt = "n", yaxt = "n", bty = "n"
#' )
#'

#' @rdname hp
#'
#' @return  \code{hpMap} returns a \code{n} lines data frame containing the
#' red (\code{R}), green (\code{G}), blue (\code{B}) and alpha (\code{alpha})
#' channels of \code{n} equally spaced colors along the 'Harry Potter' colour map.
#' \code{n = 256} by default.
#'
hpMap <- function(n = 256, alpha = 1, begin = 0, end = 1, direction = 1, house = "hufflepuff") {

	house <- tolower(house)

	if (begin < 0 | begin > 1 | end < 0 | end > 1) {
		stop("begin and end must be in [0,1]")
	}

	if (abs(direction) != 1) {
		stop("direction must be 1 or -1")
	}

	if (direction == -1) {
		tmp <- begin
		begin <- end
		end <- tmp
	}

	colnames(hp.map) <- c("R", "G", "B", "house")

	map <- hp.map[hp.map$house == house, ]

	map_cols <- grDevices::rgb(map$R, map$G, map$B, maxColorValue = 255)
	fn_cols <- grDevices::colorRamp(map_cols, space = "Lab", interpolate = "spline")
	cols <- fn_cols(seq(begin, end, length.out = n)) / 255
	data.frame(R = cols[, 1], G = cols[, 2], B = cols[, 3], alpha = alpha)
}

#' @rdname hp
#' @export
#'
hp <- function(n, alpha = 1, begin = 0, end = 1, direction = 1, house = "hufflepuff") {

	house <- tolower(house)

	if (begin < 0 | begin > 1 | end < 0 | end > 1) {
		stop("begin and end must be in [0,1]")
	}

	if (abs(direction) != 1) {
		stop("direction must be 1 or -1")
	}

	if (direction == -1) {
		tmp <- begin
		begin <- end
		end <- tmp
	}

	colnames(hp.map) <- c("R", "G", "B", "house")

	map <- hp.map[hp.map$house == house, ]

	map_cols <- grDevices::rgb(map$R, map$G, map$B, maxColorValue = 255)
	fn_cols <- grDevices::colorRamp(map_cols, space = "Lab", interpolate = "spline")
	cols <- fn_cols(seq(begin, end, length.out = n)) / 255
	grDevices::rgb(cols[, 1], cols[, 2], cols[, 3], alpha = alpha)
}



#' @rdname hp
#'
#' @export
hp_pal <- function(alpha = 1, begin = 0, end = 1, direction = 1, house = "hufflepuff") {

	house <- tolower(house)

	function(n) {
		hp(n, alpha, begin, end, direction, house)
	}
}


#' @rdname scale_hp
#'
#' @importFrom ggplot2 scale_fill_gradientn scale_color_gradientn discrete_scale
#'
#' @export
scale_color_hp <- function(..., alpha = 1, begin = 0, end = 1, direction = 1,
																discrete = FALSE, house = "hufflepuff") {

	house <- tolower(house)

	if (discrete) {
		discrete_scale("colour", "hp", hp_pal(alpha, begin, end, direction, house), ...)
	} else {
		scale_color_gradientn(colours = hp(256, alpha, begin, end, direction, house), ...)
	}
}

#' @rdname scale_hp
#' @aliases scale_color_hp
#' @export
scale_colour_hp <- scale_color_hp

#' Harry Potter colour scales
#'
#' Uses the Harry Potter color scale.
#'
#' For \code{discrete == FALSE} (the default) all other arguments are as to
#' \link[ggplot2]{scale_fill_gradientn} or \link[ggplot2]{scale_color_gradientn}.
#' Otherwise the function will return a \code{discrete_scale} with the plot-computed
#' number of colors.
#'
#'
#' @param ... parameters to \code{discrete_scale} or \code{scale_fill_gradientn}
#'
#' @param alpha pass through parameter to \code{hp}
#'
#' @param begin The (corrected) hue in [0,1] at which the hp colormap begins.
#'
#' @param end The (corrected) hue in [0,1] at which the hp colormap ends.
#'
#' @param direction Sets the order of colors in the scale. If 1, the default, colors
#' are as output by \code{hp_pal}. If -1, the order of colors is reversed.
#'
#' @param discrete generate a discrete palette? (default: \code{FALSE} - generate continuous palette)
#'
#' @param house A character string indicating the colourmap from a house to use.
#' Four houses are available: "Gryffindor", "Slytherin", "Ravenclaw" and "Hufflepuff".
#'
#' @rdname scale_hp
#'
#' @author Alejandro Jiménez Rico \email{aljrico@@gmail.com}
#'
#' @importFrom ggplot2 scale_fill_gradientn scale_color_gradientn discrete_scale
#'
#' @importFrom gridExtra grid.arrange
#'
#' @examples
#' library(ggplot2)
#'
#' # ripped from the pages of ggplot2
#' ggplot(mtcars, aes(wt, mpg)) +
#'   geom_point(size=4, aes(colour = factor(cyl))) +
#'     scale_color_hp(discrete=TRUE, house = "Gryffindor") +
#'     theme_bw()
#'
#' # ripped from the pages of ggplot2
#' dsub <- subset(diamonds, x > 5 & x < 6 & y > 5 & y < 6)
#' dsub$diff <- with(dsub, sqrt(abs(x-y))* sign(x-y))
#' ggplot(dsub, aes(x, y, colour=diff)) +
#'   geom_point() +
#'   scale_colour_hp(house = "Ravenclaw") +
#'   theme_bw()
#'
#'
#' # from the main hp example
#' dat <- data.frame(x = rnorm(10000), y = rnorm(10000))
#'
#' ggplot(dat, aes(x = x, y = y)) +
#'   geom_hex() +
#'   coord_fixed() +
#'   scale_fill_hp(house = "Hufflepuff") +
#'   theme_bw()
#'
#'
#' @export
scale_fill_hp <- function(..., alpha = 1, begin = 0, end = 1, direction = 1,
															 discrete = FALSE, house = "hufflepuff") {

	house <- tolower(house)

	if (discrete) {
		discrete_scale("fill", "hp", hp_pal(alpha, begin, end, direction, house), ...)
	} else {
		scale_fill_gradientn(colours = hp(256, alpha, begin, end, direction, house), ...)
	}
}
