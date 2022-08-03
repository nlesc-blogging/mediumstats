#' Get statistics from Medium Statistics Grabber file
#'
#' @param loc File location
#'
#' @return
#' @export
#'
#' @examples
get_msg_stats <- function(loc = 'data/msg.csv') {
  read_and_clean_csv(loc, '|', 'mediumID')
}

#' Get statistics from Medium Enhanced Statistics file
#'
#' @param loc File location
#'
#' @return
#' @importFrom dplyr mutate
#' @importFrom lubridate as_datetime
#' @export
#'
#' @examples
get_mes_stats <- function(loc = 'data/mes.csv') {
  raw <- read_and_clean_csv(loc, ';', 'postId')
  tid <- mutate(raw, pubDate = as_datetime(firstPublishedAt / 1000))
  tid <- select(tid, -c('firstPublishedAt'))
  return(tid)
}

# ========== Auxiliary functions ==========

#' Auxiliary function
#'
#' This function reads a csv and modifies its id column name
#'
#' @param loc File location
#' @param sep Separator
#' @param old_id Old id
#' @param new_id New id
#'
#' @importFrom utils read.csv
#'
#' @return
#'
read_and_clean_csv <- function(loc, sep, old_id, new_id='id') {
  data <- read.csv(loc, sep = sep)
  names(data)[names(data) == old_id] <- new_id # Rename index column

  return(data)
}
