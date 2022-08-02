#' Get the online feed
#'
#' @param url The url containing the feed
#'
#' @return A string containing the feed
#' @export
#'
get_feed <- function(url='https://blog.esciencecenter.nl/feed') {
  # Read the url content
  lines <- readLines(url, warn = FALSE)
  # Reformat it as a string
  feed_str <-  paste0(paste0(lines, collapse = "\n"), "\n")
  # Return the content as a string
  return(feed_str)
}

#' Get blogs tree set
#'
#' Each blog is coded as a subtree
#'
#' @param source The rss feed content or location
#' @param query The xpath query
#'
#' @return An xml_nodeset object
#'
#' @importFrom xml2 read_xml xml_find_all
#' @export
#'
#' @examples
get_blogs_set <- function(source=get_feed(), query='.//channel/item') {
  source |> read_xml() |> xml_find_all(query) -> nodeSet
  return(nodeSet)
}

#' Get values from node
#'
#' @param node The node we are interested in
#' @param key The key corresponding to the value
#'
#' @return The value(s) corresponding to the key
#'
#' @import xml2 xml_find_all xml_text
#' @export
#'
#' @examples
get_values <- function(node, key) {
  node |> xml_find_all(key) |> xml_text() -> values
  return(values)
}

#' Convert a blogs set into a data frame
#'
#' @param blogs_set A blogs set object
#' @param collapse Collapse symbol for pasting lists of strings
#'
#' @return An R-friendly data frame
#' @export
#'
#' @examples
blogs_set_as_df <- function(blogs_set=get_blogs_set(), collapse=" ") {

  nblogs <- length(blogs_set) # Count blogs
  df <- data.frame() # Initialize data frame...
  for (i in seq(1, nblogs)) { # and populate it
    blog <- blogs_set[[i]]
    blog |> get_values('title') -> title
    blog |> get_values('guid') |> simplify_id()-> guid

    # Category returns a list. We turn it into a string
    blog |> get_values('category') |> paste(collapse = collapse) -> category

    df <- rbind(df, list(id = guid,
                         title = title,
                         category = category))
  }

  return(df)
}

# ========== Auxiliary functions ==========

#' Simplify medium id
#'
#' @param string The medium id, typically: https://medium.com/p/<simple id>
#'
#' @return A simplified id
#'
#' @examples
simplify_id <- function(string) {
  gsub('https://medium.com/p/', '', string)
}

#' Download the online feed and make a local copy
#'
#' @param url The url containing the feed
#' @param destfile The destination file
#'
#' @return Nothing, but downloads the file
#' @export
#'
#' @examples
download_feed <- function(url='https://blog.esciencecenter.nl/feed', destfile='data/temp.xml') {
  download.file(url = url, destfile = destfile)
}
