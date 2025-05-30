## Topics 

### Filter data
- `filter-data/filter-data_covid_glawley.qmd`
  - Subset data for specific values. Uses `filter()`; first with `|`, then with `%in%`.

### Plot data
- `plot-data/adjust-dates_covid_glawley.qmd`
    - Short example of how to adjust date breaks using `scale_x_date()`. Also shows how to angle axis text using `theme()`.
- `plot-data/plots-intro_covid_glawley.qmd`
    - Follow up to the intro ggplot2 tutorials in the course. Uses `geom_line()`, `theme_minimal()`, `facet_wrap()`, and `labs()`.
- `plot-data/drop-legend_covid_glawley.qmd`
    - Two ways to remove a legend. Uses `guides()`.

### Mutate data
- `mutate-data/ifelse-casewhen_covid_glawley.qmd`
    - Recode column values; first using `if_else()`, then using `case_when()`.

### Tidy data
- `tidy-data/tidy_covid_glawley.qmd`
    - Create the same plot with both untidy and tidy data. Uses `pivot_longer()` and some functions from the scales package.
- `tidy-data/tidy_policies_glawley.qmd`
    - Create the same plot with both untidy and tidy data. Uses `pivot_longer()`.

### Join data
- `join-data/mismatched-keys_jmclawson.qmd`
    - Check for mismatched keys three different ways. Uses `anti_join()`, `setdiff()`, and `left_join(unmatched = "error")`.

### Other packages
- `other-packages/purrr_covid_glawley.qmd`
    - Quick intro to `purrr::map()`.
- `other-packages/gt_covid_glawley.qmd`
    - An extended example of how to create a customized `gt()` table.

### Quarto
- `quarto/quarto-v-rmarkdown_jmclawson.md`
    - Comparison helping to answer the question "Should I switch from R Markdown to Quarto?"

Other topics to include:
- R intro/overview
- Summarize data
- Create + select columns
- Quarto
- Data types
- EDA | data analysis/stats
- Showcase results (visualize, tables, etc)
- Quarto, Connect : communicating results
- Working with dates

## File naming format
- Currently using: `tutorial-name_dataset_name.qmd`
- Omit dataset if no external dataset is used
- Name is first initial + last name or github username (or something else)

