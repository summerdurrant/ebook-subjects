# load packages
library(tidyverse)
library(readxl)

# import data
titles <- read_excel("ebook_subjects.xlsx", sheet = "Usage Data")

# unpivot lcsh
topical_lcsh <- titles %>%
  separate(lcsh_topical, into = c("lcsh.1", "lcsh.2", "lcsh.3", "lcsh.4", "lcsh.5", "lcsh.6"),
           sep = ";", extra = "drop", fill = "right") %>%
  pivot_longer(cols = c("lcsh.1", "lcsh.2", "lcsh.3", "lcsh.4", "lcsh.5", "lcsh.6"),
               names_to = "lcsh_order", values_to = "lcsh_topical", values_drop_na = TRUE) %>%
  mutate(lcsh_topical = str_remove(lcsh_topical, "\\.$"))

topical_lcsh_distinct <- topical_lcsh %>%
  distinct(lcsh_topical, title_id, .keep_all = TRUE)

write_csv(topical_lcsh_distinct, "topical_lcsh.csv")
