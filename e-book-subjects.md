Ebook Subjects
================

``` r
# load libraries
library(tidyverse)
```

``` r
# import and combine monthly usage files
files <- dir(path = "./usage-stats", full.names = TRUE)
headers <- c("title", "publisher", "publisher_id", "platform", "doi", 
                "proprietary_id", "isbn", "print_issn", "online_issn", "uri", 
                "data_type", "section_type", "yop", "access_type", 
                "access_method","metric_type", "total")

tr <- files %>%
  map(read_csv, skip = 14, col_select = 1:17, col_names = headers, 
      col_type = "cccccccccccciccci") %>%
  reduce(bind_rows)
```

``` r
# filter title report to only include books
tr_books <- tr %>%
  filter(data_type == "Book")
  
tr_books_metrics <- tr_books %>%  
  filter(metric_type %in% c("Unique_Title_Requests", "No_License", "Limit_Exceeded"))

tr_books_metrics %>%
  group_by(metric_type) %>%
  summarize(sum(total), n())
```

    ## # A tibble: 3 x 3
    ##   metric_type           `sum(total)` `n()`
    ##   <chr>                        <int> <int>
    ## 1 Limit_Exceeded                 958    65
    ## 2 No_License                    4143  2376
    ## 3 Unique_Title_Requests        28184  6519
