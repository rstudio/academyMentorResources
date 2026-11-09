library(tidyverse)
# What the heck does `~` mean in R?

# Used to separate left- and right-hand sides of a formula
?`~`

# Some examples that make increasingly less sense

# 1. In modeling

# E.g. fitting an ANOVA model
covid <- readr::read_csv("data/covid.csv")
covid_months_regions <- covid |>
  mutate(
    month = month(date), # From `lubridate`,
    region = recode_values(state, from = state.abb, to = state.region),
    .after = date
  ) |>
  drop_na(region)

model <- lm(deaths ~ region * month, data = covid_months_regions)
# LHS is response, RHS is predictors.
car::Anova(model)

# region, month, and their interaction are statistically significant. Caveat:
# need to check model assumptions!

# You'll see this in other statistical test functions like `glm()`, `t.test()`,
# etc.

# 2. In ggplot2 (superseded)

# An "old" way of using `facet_wrap()` and `facet_grid()` uses the "formula interface"

covid_months_regions |>
  ggplot(aes(x = cases, y = deaths)) +
  geom_point(alpha = 0.3) +
  # facet_grid(region ~ month) # LHS = vertical, RHS = horizontal—kind of like response ~ predictor
  facet_grid(vars(region), vars(month)) # "new" version

covid_months_regions |>
  ggplot(aes(x = cases, y = deaths)) +
  geom_point(alpha = 0.4) +
  # facet_wrap(~ month) # right-handed only
  facet_wrap(vars(month)) # "new" version

# 3. In `case_when()`
# LHS = determines which values match the case, RHS = replacement value
covid_months_regions |>
  mutate(
    region2 = case_when(
      region == "Northeast" ~ "NE",
      region == "South" ~ "S",
      region == "North Central" ~ "NC",
      region == "West" ~ "W"
    )
  )

# 4. "Anonymous" functions in the tidyverse (you probably haven't seen this yet)

# Outdated way of writing "anonymous" functions in the tidyverse (only).

# An anonymous function is one that you create without giving it a name.
# Usually passed as an argument to a function.

# Not documented, but you can use this in `fct_reorder()`. Here's a contrived
# example where we reorder by the median square-root number of deaths. All of
# these are equivalent!

covid_seasons_regions |>
  group_by(region) |>
  summarize(deaths = sum(deaths, na.rm = TRUE)) |>
  mutate(
    region = fct_reorder(
      region,
      deaths,
      .fun = ~ median(sqrt(.x))
      # .fun = \(x) median(sqrt(x))
      # .fun = \(blah) median(sqrt(blah))
      # .fun = function(blah) median(sqrt(blah))
    )
  ) |>
  ggplot(aes(x = region, y = deaths)) +
  geom_col()
