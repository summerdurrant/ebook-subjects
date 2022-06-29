# load libraries
library(tidyverse)
library(readxl)
library(tidytext)

# import data
ebook_subjects <- read_excel("ebook_subjects.xlsx", sheet = "Usage Data")

# extract unigrams
unigrams <- ebook_subjects %>%
  unnest_tokens(word, title, drop = FALSE) %>%
  anti_join(stop_words) %>%
  drop_na(word)

write_csv(unigrams, "title_unigrams.csv")

unigrams_count <- unigrams %>%
  count(word, sort = TRUE)

# extract bigrams

bigrams <- ebook_subjects %>%
  unnest_tokens(bigram, title, drop = FALSE, token = "ngrams", n = 2) %>%
  separate(bigram, c("word1", "word2"), sep = " ") %>%
  filter(!word1 %in% stop_words$word,
         !word2 %in% stop_words$word) %>%
  drop_na(word1, word2) %>%
  unite(word1, word2, col = "bigram", sep = " ")

write_csv(bigrams, "title_bigrams.csv")

bigrams_count <- bigrams %>%
  count(bigram, sort = TRUE)

# extract trigrams

trigrams <- ebook_subjects %>%
  unnest_tokens(trigram, title, drop = FALSE, token = "ngrams", n = 3) %>%
  separate(trigram, c("word1", "word2", "word3"), sep = " ") %>%
  filter(!word1 %in% stop_words$word,
         !word2 %in% stop_words$word,
         !word3 %in% stop_words$word) %>%
  drop_na(word1, word2, word3) %>%
  unite(word1, word2, word3, col = "trigram", sep = " ")

write_csv(trigrams, "title_trigrams.csv")

trigrams_count <- trigrams %>%
  count(trigram, sort = TRUE)
