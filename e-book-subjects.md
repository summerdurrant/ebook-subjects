Ebook Subjects
================

``` r
# load libraries
library(tidyverse)
library(readxl)
```

``` r
# import and combine usage files
files <- dir(path = "./usage-stats", full.names = TRUE)
title_report <- files %>%
  map(read_excel, skip = 13) %>%
  reduce(rbind)
```
