install.packages("testthat")
library(testthat)
library(fars_summarize)

test_that("checking if the files are available", {
  testthat::expect_equal(list.files(system.file("extdata", package = "fars_summarize")),
                         c("accident_2013.csv.bz2",
                           "accident_2014.csv.bz2",
                           "accident_2015.csv.bz2"))
})
