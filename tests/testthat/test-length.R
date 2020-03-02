context("test-length")

test_that("hp returns correct number of colors", {
	expect_equal(length(hp(1)), 1)
	expect_equal(length(hp(10)), 10)
	expect_equal(length(hp(1e2)), 1e2)
	expect_equal(length(hp(1e3)), 1e3)
})