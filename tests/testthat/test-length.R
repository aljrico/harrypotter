context("test-length")

test_that("hp returns correct number of colors", {
	expect_equal(length(hp(10)), 10)
})