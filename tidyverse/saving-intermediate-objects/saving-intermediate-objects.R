# Setup ----
library(tidyverse)

# Create some example R objects to save out

# data frame
covid <- read_csv("data/covid.csv")
covid_summary <- covid |>
  group_by(state) |>
  summarize(
    total_deaths = sum(deaths, na.rm = TRUE),
    total_cases = sum(cases, na.rm = TRUE)
  )

# vector
n_missing_state <- covid |> filter(is.na(state)) |> nrow()
n_missing_state

# plot
p <-
  ggplot(covid_summary, aes(x = total_cases, y = total_deaths, label = state)) +
  geom_text()
p

# .Rdata ----

# save() saves one or more objects, save.image() saves everything in the global
# environment to a single .RData file

save(covid_summary, n_missing_state, p, file = "test.Rdata")
save.image()

# load() to load .Rdata files

p <- 123 # will get overwritten when we load "test.Rdata"

load("test.Rdata")

# pros:
# - Can save any kind of R object
# - Can save multiple objects in one file
#
# cons:
# - You don't decide what they are called when read in
# - Will overwrite anything you already have in your environment with one of these names
# - Only works with R

# .rds ----

# write_rds() and read_rds()

write_rds(covid_summary, "covid_summary.rds")

x <- read_rds("covid_summary.rds")

# pros:
# - Can save any kind of R object
# - Reading doesn't overwrite objects unless you want it to
#
# cons:
# - Only works with R
#

# Tabular data formats ----

## CSV ----
write_csv(covid_summary, "covid_summary.csv")
x <- read_csv("covid_summary.csv")

# pros:
# - Plain text
# - Highly inter-compatible
#
# cons:
# - Doesn't know about data types
# - Can be inefficient for large data

## Parquet ----
# install.packages("nanoparquet")
nanoparquet::write_parquet(covid_summary, "covid_summary.parquet")
x <- nanoparquet::read_parquet("covid_summary.parquet")

#' pros:
#' - Compatible across platforms and programming languages
#' - Often more performant than CSV for large data
#' - Contains data schema
#'
#' cons:
#' - Only works for tabular data
#' - Not as commonly used as CSV
