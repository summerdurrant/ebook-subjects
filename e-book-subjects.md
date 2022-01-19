E-Book Subject Analysis
================

``` r
# load libraries
library(tidyverse)
```

``` r
# import combine usage file
tr_books <- read_csv("usage_data.csv", show_col_types = FALSE)
```

``` r
# calculate missing isbns
count_missing_isbn <- sum(is.na(tr_books$isbn))
print(count_missing_isbn)
```

    ## [1] 266

``` r
# create list of unique isbns
tr_books <- tr_books %>%
  mutate(isbn_norm = str_remove_all(isbn, "-"))

unique_isbn <- tr_books %>%
  select(isbn_norm) %>%
  distinct(isbn_norm)

# calculate number of unique isbns and print output
count_unique_isbn <- n_distinct(unique_isbn)
print(count_unique_isbn)
```

    ## [1] 9665

``` r
# output cvs file with unique isbns
write_csv(unique_isbn, "unique_isbn.csv")
```
