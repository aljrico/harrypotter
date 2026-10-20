# One colour ramp per option, built on first use. Filtering the 246k-row map and fitting the
# spline is the slow part of hp(), and ggplot calls it on every scale build.
ramps <- new.env(parent = emptyenv())

hp_ramp <- function(option) {
	if (is.null(ramps[[option]])) {
		map <- hp.map[hp.map$option == option, ]
		if (nrow(map) == 0) {
			stop("Unknown option '", option, "'. See names(hp_palettes) for the available ones.")
		}
		map_cols <- grDevices::rgb(map$V1, map$V2, map$V3, maxColorValue = 255)
		ramps[[option]] <- grDevices::colorRamp(map_cols, space = "Lab", interpolate = "spline")
	}
	ramps[[option]]
}

# `house` was renamed to `option` in 2.1.0. Warn so callers move over before it is removed.
house_option <- function(option, house) {
	if (is.null(house)) return(option)
	warning("`house` is deprecated, use `option` instead.", call. = FALSE)
	house
}

#' Harry Potter Colour Map.
#'
#' This function creates a vector of \code{n} equally spaced colors along the
#' 'HP colour map' of your selection
#'
#' @param n The number of colors (\eqn{\ge 1}) to be in the palette.
#'
#' @param alpha	The alpha transparency, a number in `[0,1]`, see argument alpha in
#' \code{\link[grDevices]{hsv}}.
#'
#' @param begin The (corrected) hue in `[0,1]` at which the hp colormap begins.
#'
#' @param end The (corrected) hue in `[0,1]` at which the hp colormap ends.
#'
#' @param direction Sets the order of colors in the scale. If 1, the default, colors
#' are ordered from darkest to lightest. If -1, the order of colors is reversed.
#'
#' @param option A character string indicating the colourmap to use. Case, spaces and
#' underscores are ignored. See \code{names(hp_palettes)} for the available options.
#'
#' @param house Deprecated. Use 'option' instead.
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
#' Semi-transparent colors (\eqn{0 < alpha < 1}) are supported only on some
#' devices: see \code{\link[grDevices]{rgb}}.
#'
#' @examples
#' library(ggplot2)
#' library(hexbin)
#'
#' dat <- data.frame(x = rnorm(1e4), y = rnorm(1e4))
#' ggplot(dat, aes(x = x, y = y)) +
#'   geom_hex() +
#'   coord_fixed() +
#'   scale_fill_gradientn(colours = hp(128, option = 'Always'))
#'
#' pal <- hp(256, option = "Ravenclaw")
#' image(volcano, col = pal)
#'
#' @rdname hp
#' @export
hp <- function(n, alpha = 1, begin = 0, end = 1, direction = 1, option = 'Always', house = NULL) {

	option <- house_option(option, house)
	option <- gsub("[ _]", "", tolower(option))

	if (begin < 0 | begin > 1 | end < 0 | end > 1) {
		stop("begin and end must be in `[0,1]`")
	}

	if (abs(direction) != 1) {
		stop("direction must be 1 or -1")
	}

	stops <- seq(begin, end, length.out = n)
	if (direction == -1) stops <- rev(stops)

	cols <- hp_ramp(option)(stops) / 255
	grDevices::rgb(cols[, 1], cols[, 2], cols[, 3], alpha = alpha)
}

#' @rdname hp
#' @export
hp_pal <- function(alpha = 1, begin = 0, end = 1, direction = 1, option = 'Always', house = NULL) {
	option <- house_option(option, house)
	function(n) {
		hp(n, alpha, begin, end, direction, option)
	}
}

#' @rdname hp
#' @export
harrypotter <- hp

#' Harry Potter colour scales
#'
#' Uses the Harry Potter color scale.
#'
#' For \code{discrete == FALSE} (the default) all other arguments are as to
#' \link[ggplot2]{scale_fill_gradientn} or \link[ggplot2]{scale_color_gradientn}.
#' Otherwise the function will return a \code{discrete_scale} with the plot-computed
#' number of colors.
#'
#' @param ... parameters to \code{discrete_scale} or \code{scale_fill_gradientn}
#'
#' @param alpha pass through parameter to \code{hp}
#'
#' @param begin The (corrected) hue in `[0,1]` at which the hp colormap begins.
#'
#' @param end The (corrected) hue in `[0,1]` at which the hp colormap ends.
#'
#' @param direction Sets the order of colors in the scale. If 1, the default, colors
#' are as output by \code{hp_pal}. If -1, the order of colors is reversed.
#'
#' @param discrete generate a discrete palette? (default: \code{FALSE} - generate continuous palette)
#'
#' @param option A character string indicating the colourmap to use.
#' See \code{names(hp_palettes)} for the available options.
#'
#' @param house Deprecated. Use 'option' instead.
#'
#' @param aesthetics Character string or vector of character strings listing the name(s) of
#' the aesthetic(s) that this scale works with.
#'
#' @author Alejandro Jiménez Rico \email{aljrico@@gmail.com}
#'
#' @examples
#' library(ggplot2)
#'
#' ggplot(mtcars, aes(factor(cyl), fill=factor(vs))) +
#' geom_bar() +
#' scale_fill_hp(discrete = TRUE, option = "Ravenclaw")
#'
#' ggplot(mtcars, aes(factor(gear), fill=factor(carb))) +
#' geom_bar() +
#' scale_fill_hp(discrete = TRUE, option = "Slytherin")
#'
#' ggplot(mtcars, aes(x = mpg, y = disp, colour = hp)) +
#' geom_point(size = 2) +
#' scale_colour_hp(option = "Gryffindor")
#'
#' @name scale_hp
NULL

#' @rdname scale_hp
#' @export
scale_colour_hp <- function(option = 'Always', ..., alpha = 1, begin = 0, end = 1, direction = 1,
														discrete = FALSE, house = NULL) {
	option <- house_option(option, house)
	if (discrete) {
		scale_colour_hp_d(option, ..., alpha = alpha, begin = begin, end = end, direction = direction)
	} else {
		ggplot2::scale_colour_gradientn(colours = hp(256, alpha, begin, end, direction, option), ...)
	}
}

#' @rdname scale_hp
#' @export
scale_color_hp <- scale_colour_hp

#' @rdname scale_hp
#' @export
scale_fill_hp <- function(option = 'Always', ..., alpha = 1, begin = 0, end = 1, direction = 1,
													discrete = FALSE, house = NULL) {
	option <- house_option(option, house)
	if (discrete) {
		scale_fill_hp_d(option, ..., alpha = alpha, begin = begin, end = end, direction = direction)
	} else {
		ggplot2::scale_fill_gradientn(colours = hp(256, alpha, begin, end, direction, option), ...)
	}
}

#' @rdname scale_hp
#' @export
scale_colour_hp_d <- function(option = 'Always', ..., alpha = 1, begin = 0, end = 1,
															direction = 1, aesthetics = "colour") {
	ggplot2::discrete_scale(aesthetics, palette = hp_pal(alpha, begin, end, direction, option), ...)
}

#' @rdname scale_hp
#' @export
scale_color_hp_d <- scale_colour_hp_d

#' @rdname scale_hp
#' @export
scale_fill_hp_d <- function(option = 'Always', ..., alpha = 1, begin = 0, end = 1,
														direction = 1, aesthetics = "fill") {
	scale_colour_hp_d(option, ..., alpha = alpha, begin = begin, end = end,
										direction = direction, aesthetics = aesthetics)
}
