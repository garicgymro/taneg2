require(tidyverse)
require(stringdist)
require(readr)
require(purrr)


files <- list.files(path = ".", pattern = "\\.csv$", full.names = TRUE)


check_results <- map_dfr(files, function(f) {
  testData <- read_csv(f, show_col_types = FALSE)
  n_production <- length(which(testData$task == "production"))
  tibble(
    file = basename(f),
    n_production = n_production,
    passes = !(n_production < 20)
  )
})

check_results


combined_data <- map_dfr(files, read_csv)


write_csv(combined_data, "combined_output.csv")


word_lev <- function(s1, s2) {
  w1 <- strsplit(s1, " ")[[1]]
  w2 <- strsplit(s2, " ")[[1]]
  
  # build a shared vocabulary mapping each unique word to one character
  vocab <- unique(c(w1, w2))
  codes <- setNames(sapply(seq_along(vocab), function(i) intToUtf8(0x2400 + i)), vocab)
  
  # recode each word sequence into a single string of mapped characters
  s1_recoded <- paste(codes[w1], collapse = "")
  s2_recoded <- paste(codes[w2], collapse = "")
  
  stringdist(s1_recoded, s2_recoded, method = "lv")
}

combined_data <- combined_data %>%
  mutate(score = map2_dbl(correct_response, response_label, word_lev))

#testProduction %>% select(correct_response,response_label,score)