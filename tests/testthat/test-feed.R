feed <- get_feed()
set <- get_blogs_set(feed)

test_that("The feed is properly retrieved and formatted", {
  expect_type(feed, "character")
})

test_that("The feed is properly parsed as an xml_nodeset object", {
  expect_s3_class(set, "xml_nodeset")
})

test_that("The feed gets properly translated to a data frame", {
  df <- feed_as_df(set)
  expected_cols <- c("id", "title", "category")
  expect_true(all(expected_cols %in% colnames(df)))
})

test_that("Simplify id works properly", {
  id <- 'https://medium.com/p/simple-id'
  sid <- simplify_id(id)
  expect_equal(sid, 'simple-id')
})
