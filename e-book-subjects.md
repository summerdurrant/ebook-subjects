E-Book Subject Analysis
================

``` r
# load libraries
library(tidyverse)
```

``` r
# import combine usage file
tr_books <- read_csv("usage_stats.csv", show_col_types = FALSE)
```

``` r
# create list of unique isbns
tr_books <- tr_books %>%
  mutate(isbn_norm = str_remove_all(isbn, "-"))

unique_isbn <- tr_books %>%
  select(isbn_norm) %>%
  distinct(isbn_norm)

n_distinct(unique_isbn)
```

    ## [1] 9665
