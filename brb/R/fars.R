#'Read FARS data
#'
#'This function reads a datafile from the Fatality Anaysis Reporting System containing information
#'on fatal injuries from traffic accidents. The file is in CSV format.
#'
#'@import readr
#'@import dplyr
#'
#'@param filename A string with the name of the file to be read
#'
#'@return If the file exists, the function returns a dataframe with the data from the .csv file
#'or an error message if it does not.
#'
#'@example fars_read("accident_2013_csv")
#'
#'@export
fars_read <- function(filename) {
  if(!file.exists(filename))
    stop("file '", filename, "' does not exist")
  data <- suppressMessages({
    readr::read_csv(filename, progress = FALSE)
  })
  dplyr::tbl_df(data)
}

#'Generate file name
#'
#'This function generates a name of the file using a particular year.
#'
#'@param year An integer or string which indicates the year
#'
#'@example
#'make_filename("2013")
#'
#'@export
make_filename <- function(year) {
  year <- as.integer(year)
  sprintf("accident_%d.csv.bz2", year)
}

#'Summarize data by month of the year.
#'
#'This function groups and summarizes the data by month of the year
#'based on input regarding the years to be included.
#'
#'@param years A vector with years to be used when summarizing.
#'
#'@return A data frame for number of accidents per year and month.
#'
#'@import dplyr
#'@import tidyr
#'
#'@example
#'fars_summarize_years(c(2013,2014,2015))
#'
#'@export
fars_summarize_years <- function(years) {
  dat_list <- fars_read_years(years)
  dplyr::bind_rows(dat_list) %>%
    dplyr::group_by(year, MONTH) %>%
    dplyr::summarize(n = n()) %>%
    tidyr::spread(year, n)
}


