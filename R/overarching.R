#' Merge labels and statistics dataframes
#'
#' @param labels The labels dataframe
#' @param stats The statistics dataframe
#'
#' @return A dataframe combining both labels and statistics
#'
#' @importFrom dplyr mutate
#' @importFrom lubridate as_datetime
#' @export
#'
#' @examples
merge_labels_and_stats <- function(labels, stats) {
  merge(labels, stats, by = c('id', 'title', 'pubDate'), all = TRUE) |>
  mutate(pubDate = as_datetime(pubDate)) |>
  arrange(desc(pubDate)) -> data

  return(data)
}

#' Filter by category
#'
#' @param data A dataframe containing category strings
#' @param prompt The desired category
#'
#' @return The filtered dataframe
#' @export
#'
#' @examples
filter_by_category <- function(data, prompt) {

  # Auxiliary predicate function
  #
  # Returns TRUE if the prompt exists in the list of categories
  predicate <- function(categories_str, prompt) {
    categories <- strsplit(categories_str, " ")[[1]]
    return(prompt %in% categories)
  }

  # Apply to all rows
  selector <- unlist(lapply(data$category, function(x) predicate(x, prompt)))

  return(data[selector, ])
}
