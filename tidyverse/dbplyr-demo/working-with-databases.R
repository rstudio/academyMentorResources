library(tidyverse)
library(DBI)
# install.packages("RSQLite")

# Create connection
con <- dbConnect(RSQLite::SQLite(), "test.sqlite")
# Copy over some data as an example
covid <- read_csv("data/covid.csv")
dbWriteTable(con, "covid", covid, overwrite = TRUE)

# List tables
dbListTables(con)

covid_db <- tbl(con, "covid")

covid_db

# covid_db is *not* the full dataset
object.size(covid) # 1006640 bytes
object.size(covid_db) # 7808 bytes

# Create an example query
query <- covid_db |>
  filter_out(is.na(state)) |>
  group_by(state) |>
  summarize(
    total_deaths = sum(deaths, na.rm = TRUE),
    total_cases = sum(cases, na.rm = TRUE)
  ) |>
  ungroup() |>
  arrange(desc(total_deaths))

# Show database translation
query |> show_query()

# Collect data into memory
covid_summary <- query |> collect()
covid_summary

### Part 2: an actual databricks connection

## NOTE: your databricks connection might look different!
con2 <- dbConnect(
  odbc::databricks(),
  HTTPPath = "/sql/1.0/warehouses/5304127283422c5a",
  timeout = 10
)
## where the `httpPath` can be found in a Databricks dashboard

# This driver opens a connection in the connections pane of RStudio (not all
# drivers for dbConnect() do this)
dbListTables(con2)

# Use Id() helper to open table nested in a catalog
nyctaxi_trips <- tbl(con2, Id("samples", "nyctaxi", "trips"))
nyctaxi_trips
