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
