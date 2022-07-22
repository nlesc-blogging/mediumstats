# mediumstats

## Motivation

We want to retrieve some statistics from our Medium blog.
Unfortunately, this is not very straightforward.
We wrote an R package that helps us composing a ready-for-analysis data frame.

## Architecture

- The publication tags are read from [the rss feed](https://blog.esciencecenter.nl/feed).
- The statistics are downloaded as a CSV using [Medium stats grabber](https://chrome.google.com/webstore/detail/medium-stats-grabber/gdomhiacoiloiecaholjiegdaklelpig?hl=en).
- Both tables are merged using the Medium ID as index.
