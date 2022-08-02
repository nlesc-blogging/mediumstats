#' Update labels' archive
#'
#' #' Medium's statistics engine doesn't export labels.
#' We read them from our rss feed.
#'
#' Unfortunately, the rss only stores the last blogposts.
#' So we use this archive to keep track of older blogposts' labels.
#'
#' @param inspect Use TRUE for debugging. It will return the value instead of saving it
#'
#' @return Nothing. Updates the labels_archive file
#' @export
#'
update_labels_archive <- function() {

  # Read labels from last time the file was generated
  past <- labels_archive
  # Read current labels
  current <- blogs_set_as_df()

  # Merge all information
  updated <- unique(rbind(current, past))
  rownames(updated) <- NULL

  # Update the file only if needed
  if(nrow(updated) != nrow(past)) {
    labels_archive <- updated
    save(labels_archive, file = 'data/labels_archive.rda')
  } else {
    print("Labels archive is already up-to-date. Exiting.")
  }

}
