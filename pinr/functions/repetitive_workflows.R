# Custom functions are helpful for everyone. For instance, it might be helpful to point out that 
# even plotting tends to have repetitive elements, where all plots in a report need to follow a 
# shared style guide, or when we want to limit printing unnecessary grid lines. We can do these 
# things in ggplot, but they take multiple lines of code, and some parameters may be hard to 
# remember.

# Define the theme elements for all plots in our company
company_theme <- function(plot) {
  plot +
    theme_bw() +
    theme(
      plot.title.position = "plot",
      axis.title.y = element_text(angle = 0)) +
    scale_fill_brewer(palette = "Dark2")
}

# Drop Y-axis grid lines when unneeded
drop_grid_y <- function(plot) {
  plot +
    theme(
      panel.grid.major.y = element_blank(),
      panel.grid.minor.y = element_blank())
}

# Drop X-axis grid lines when unneeded
drop_grid_x <- function(plot) {
  plot +
    theme(
      panel.grid.major.x = element_blank(),
      panel.grid.minor.x = element_blank())
}

# Save a plot
library(palmerpenguins)
penguin_plot <- penguins |> 
  ggplot(aes(y = species, fill = species)) +
  geom_bar()

# Use our custom functions
penguin_plot |> 
  company_theme() |> 
  drop_grid_y()
