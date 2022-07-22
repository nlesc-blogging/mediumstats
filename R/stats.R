#' Auxiliary function
#'
#' @param loc
#' @param sep
#' @param old_id
#' @param new_id
#'
#' @return
#'
read_and_clean_csv <- function(loc, sep, old_id, new_id='id') {
  data <- read.csv(loc, sep = sep)
  names(data)[names(data) == old_id] <- new_id # Rename index column

  return(data)
}

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
#' @export
#'
#' @examples
get_mes_stats <- function(loc = 'data/mes.csv') {
  read_and_clean_csv(loc, ';', 'postId')
}
