[![Build Status](https://github.com/nlesc-blogging/mediumstats/workflows/R-CMD-check/badge.svg?branch=main)](https://github.com/nlesc-blogging/mediumstats/actions)
[![codecov](https://codecov.io/gh/nlesc-blogging/mediumstats/graph/badge.svg)](https://codecov.io/gh/nlesc-blogging/mediumstats)
[![codecov](https://lifecycle.r-lib.org/articles/figures/lifecycle-experimental.svg)](https://lifecycle.r-lib.org/articles/stages.html)

# mediumstats

## Motivation

We want to retrieve some statistics from our Medium blog.
Unfortunately, this is not very straightforward.
We wrote an R package that helps us composing a ready-for-analysis data frame.

## Architecture

- The publication labels are read from [the rss feed](https://blog.esciencecenter.nl/feed).
  - This feed only contains the latest 10 blogposts.
  - Since August 1 2022, we store this information in the file `labels_archive.rda`.
- The statistics are downloaded as a CSV using [Medium stats grabber](https://chrome.google.com/webstore/detail/medium-stats-grabber/gdomhiacoiloiecaholjiegdaklelpig?hl=en).
- Both tables are merged using the Medium ID as index.
