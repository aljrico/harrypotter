#' Original 'hp'and 'cividis' color map
#'
#' A dataset containing the original RGB values of the default Matplotlib color
#'  map ('hp') and the color vision deficiencies optimized color map
#'  'cividis'.
#'  Sources: \url{https://github.com/BIDS/colormap/blob/master/movie_d.py} and
#'  \url{https://github.com/pnnl/cmaputil/blob/master/colormaps/cividis.txt}.
#'
#' @format A data frame with 1280 rows and 4 variables:
#' \itemize{
#'   \item R: Red value
#'   \item G: Green value
#'   \item B: Blue value
#'   \item opt: The colormap "movie" (A: magma; B: inferno; C: plasma;
#'   D: hp; E: cividis)
#' }
#'
#'@export
load("data/hp.map")
hp.map <- map

#' Matplotlib 'hp' and 'cividis' color map
#'
#' This function creates a vector of \code{n} equally spaced colors along the
#' Matplolib 'hp' color map created by \href{https://github.com/stefanv}{Stéfan van der Walt}
#' and \href{https://github.com/njsmith}{Nathaniel Smith}. This color map is
#' designed in such a way that it will analytically be perfectly perceptually-uniform,
#' both in regular form and also when converted to black-and-white. It is also
#' designed to be perceived by readers with the most common form of color blindness.
#'
#' A corrected version of 'hp', 'cividis', was developed by
#' \href{https://github.com/jamienunez}{Jamie R. Nuñez} and
#' \href{https://github.com/smcolby}{Sean M. Colby}. It is optimal for viewing by
#' those with color vision deficiency. 'cividis' is designed to be perfectly
#' perceptually-uniform, both in regular form and also when converted to
#' black-and-white, and can be perceived by readers with all forms of color
#' blindness.
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
#' @param movie A character string indicating the colormap movie to use. Five
#' movies are available: "magma" (or "A"), "inferno" (or "B"), "plasma" (or "C"),
#' "hp" (or 1, the default movie) and "cividis" (or "E").
#'
#' @return \code{hp} returns a character vector, \code{cv}, of color hex
#' codes. This can be used either to create a user-defined color palette for
#' subsequent graphics by \code{palette(cv)}, a \code{col =} specification in
#' graphics functions or in \code{par}.
#'
#' @author Simon Garnier: \email{garnier@@njit.edu}, \href{https://twitter.com/sjmgarnier}{@@sjmgarnier}
#'
#' @details
#'
#' \if{html}{Here are the color scales:
#'
#'   \out{<div style="text-align: center">}\figure{hp-scales.png}{movies: style="width:750px;max-width:90\%;"}\out{</div>}
#'
#'   }
#' \if{latex}{Here are the color scales:
#'
#'   \out{\begin{center}}\figure{hp-scales.png}\out{\end{center}}
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
#'   scale_fill_gradientn(colours = hp(256, movie = 1))
#'
#' # using code from RColorBrewer to demo the palette
#' n = 200
#' image(
#'   1:n, 1, as.matrix(1:n),
#'   col = hp(n, movie = 1),
#'   xlab = "hp n", ylab = "", xaxt = "n", yaxt = "n", bty = "n"
#' )
#' @export
#'
hp <- function(n, alpha = 1, begin = 0, end = 1, direction = 1, movie = 1) {
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

	load("data/hp.map")
	hp.map <- map
	colnames(hp.map) <- c("R", "G", "B", "movie")

	map <- hp.map[hp.map$movie == movie, ]
	map_cols <- grDevices::rgb(map$R, map$G, map$B, maxColorValue = 255)
	fn_cols <- grDevices::colorRamp(map_cols, space = "Lab", interpolate = "spline")
	cols <- fn_cols(seq(begin, end, length.out = n)) / 255
	grDevices::rgb(cols[, 1], cols[, 2], cols[, 3], alpha = alpha)
}


#' @rdname hp
#'
#' @return  \code{hpMap} returns a \code{n} lines data frame containing the
#' red (\code{R}), green (\code{G}), blue (\code{B}) and alpha (\code{alpha})
#' channels of \code{n} equally spaced colors along the 'hp' color map.
#' \code{n = 256} by default, which corresponds to the data from the original
#' 'hp' color map in Matplotlib.
#'
hpMap <- function(n = 256, alpha = 1, begin = 0, end = 1, direction = 1, movie = 1) { # nocov start
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

	load("data/hp.map")
	hp.map <- map

	map <- hp.map[hp.map$movie == movie, ]
	map_cols <- grDevices::rgb(map$R, map$G, map$B)
	fn_cols <- grDevices::colorRamp(map_cols, space = "Lab", interpolate = "spline")
	cols <- fn_cols(seq(begin, end, length.out = n)) / 255
	data.frame(R = cols[, 1], G = cols[, 2], B = cols[, 3], alpha = alpha)
} # nocov end

#' @export
hp_pal <- function(alpha = 1, begin = 0, end = 1, direction = 1, movie= 1) {
	function(n) {
		harrypotter::hp(n, alpha, begin, end, direction, movie)
	}
}


#' @rdname scale_hp
#'
#' @importFrom ggplot2 scale_fill_gradientn scale_color_gradientn discrete_scale
#'
#' @export
scale_color_hp <- function(..., alpha = 1, begin = 0, end = 1, direction = 1,
																discrete = FALSE, movie = 1) {
	if (discrete) {
		discrete_scale("colour", "hp", hp_pal(alpha, begin, end, direction, movie), ...)
	} else {
		scale_color_gradientn(colours = harrypotter::hp(256, alpha, begin, end, direction, movie), ...)
	}
}

#' @rdname scale_hp
#' @aliases scale_color_hp
#' @export
scale_colour_hp <- scale_color_hp

#' hp color scales
#'
#' Uses the hp color scale.
#'
#' For \code{discrete == FALSE} (the default) all other arguments are as to
#' \link[ggplot2]{scale_fill_gradientn} or \link[ggplot2]{scale_color_gradientn}.
#' Otherwise the function will return a \code{discrete_scale} with the plot-computed
#' number of colors.
#'
#' See \link[harrypotter]{hp} for more information on the color scale.
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
#' are as output by \link[hp]{hp_pal}. If -1, the order of colors is reversed.
#'
#' @param discrete generate a discrete palette? (default: \code{FALSE} - generate continuous palette)
#'
#' @param movie A character string indicating the colormap from which movie to use.
#'
#' @rdname scale_hp
#'
#' @author Noam Ross \email{noam.ross@@gmail.com} / \href{https://twitter.com/noamross}{@@noamross} (continuous version),
#'         Bob Rudis \email{bob@@rud.is} / \href{https://twitter.com/hrbrmstr}{@@hrbrmstr} (combined version)
#'
#' @importFrom ggplot2 scale_fill_gradientn scale_color_gradientn discrete_scale
#'
#' @importFrom gridExtra grid.arrange
#'
#' @examples
#' library(ggplot2)
#'
#' # ripped from the pages of ggplot2
#' p <- ggplot(mtcars, aes(wt, mpg))
#' p + geom_point(size=4, aes(colour = factor(cyl))) +
#'     scale_color_hp(discrete=TRUE) +
#'     theme_bw()
#'
#' # ripped from the pages of ggplot2
#' dsub <- subset(diamonds, x > 5 & x < 6 & y > 5 & y < 6)
#' dsub$diff <- with(dsub, sqrt(abs(x-y))* sign(x-y))
#' d <- ggplot(dsub, aes(x, y, colour=diff)) + geom_point()
#' d + scale_color_hp() + theme_bw()
#'
#'
#' # from the main hp example
#' dat <- data.frame(x = rnorm(10000), y = rnorm(10000))
#'
#' ggplot(dat, aes(x = x, y = y)) +
#'   geom_hex() + coord_fixed() +
#'   scale_fill_hp() + theme_bw()
#'
#' library(ggplot2)
#' library(MASS)
#' library(gridExtra)
#'
#' data("geyser", package="MASS")
#'
#' ggplot(geyser, aes(x = duration, y = waiting)) +
#'   xlim(0.5, 6) + ylim(40, 110) +
#'   stat_density2d(aes(fill = ..level..), geom="polygon") +
#'   theme_bw() +
#'   theme(panel.grid=element_blank()) -> gg
#'
#' grid.arrange(
#'   gg + scale_fill_hp(movie="A") + labs(x="Virdis A", y=NULL),
#'   gg + scale_fill_hp(movie="B") + labs(x="Virdis B", y=NULL),
#'   gg + scale_fill_hp(movie="C") + labs(x="Virdis C", y=NULL),
#'   gg + scale_fill_hp(movie=1) + labs(x="Virdis D", y=NULL),
#'   gg + scale_fill_hp(movie="E") + labs(x="Virdis E", y=NULL),
#'   ncol=3, nrow=2
#' )
#'
#' @export
scale_fill_hp <- function(..., alpha = 1, begin = 0, end = 1, direction = 1,
															 discrete = FALSE, movie = 1) {
	if (discrete) {
		discrete_scale("fill", "hp", hp_pal(alpha, begin, end, direction, movie), ...)
	} else {
		scale_fill_gradientn(colours = harrypotter::hp(256, alpha, begin, end, direction, movie), ...)
	}

}
