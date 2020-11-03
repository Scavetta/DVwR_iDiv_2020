# Coding exercises for Data Visualization
# iDiv, November 2020
# Rick Scavetta
# 03.11.2020

# Load packages
library(ggplot2)
library(RColorBrewer) # for color palettes
library(Hmisc)

# Using color ----
# Define colors using hex code, e.g.
myRed <- "#e41a1c" # RRGGBB

# Hexidecimal (base 16) counting
# 1-digit: 16, 0-9a-f (16^1)
# 2-digit: 256, 00-ff (16^2)

# Decimal (base 10) counting
# 1-digit numbers: 10 numbers: 0-9, i.e. 10^1
# 2-digit numbers: 100 numbers: 00-99, 10^2

"#FF0000" # pure red
"#000000" # No color - black
"#FFFFFF" # All color - white
"#FF00FF" # Purple

# easy plot:
munsell::plot_hex("#FF00FF")

# access color brewer
display.brewer.pal(4, "Set1")
# brewer.pal(4, "Set1")[2:4]
myCol <- brewer.pal(3, "Set2") # give the hex codes
myCol


# Coding challenges ----
# Layer 1: Data
iris

# 1 - Make base layer (data & aesthetics)
# Sepal Width vs Sepal Length (Y vs X, Y ~ X)
# Colored according to Species
p <- ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species))

# 2 - Add the geometries layer
# Create basic scatter plot
p +
  geom_point()
# This it mostly perfectly fine, but it doesn't
# guarantee there will be no overplotting,
# so always consider if it's the right choice.

# Causes for over-plotting:
# low-precision data (here)
# A lot of observations
# Integer data
# All points on one axis

# Adjust for overplotting: Jitter

# 1 - Use the position argument
# Convenient and inflexible
p +
  geom_point(position = "jitter")

# 2 - Use the geom_jitter()
# Convenient and somewhat flexible
p +
  geom_jitter()

# 3 - Use a position_*() function
# Full-featured and most flexible
posn_j <- position_jitter(seed = 136)

p +
  geom_point(position = posn_j,
             shape = 16,
             alpha = 0.65)

library(car)
str(Vocab)
g <- ggplot(Vocab, aes(education, vocabulary))
g

# Default
g +
  geom_point()

# Solutions:

g +
  geom_jitter(shape = ".",
              alpha = 0.2)

# Alternatively, just plot the number of observations
g +
  stat_sum()


# Modifying the plot ----
# 3 - Add linear models, without background
# 4 - Change the colors - use Dark2 from color brewer
# or use the myCol vector from above
# Recall: aesthetics == scales == axes

# map a group onto a specific color:
# use a named vector
myCol_named <- c(virginica = "#377EB8",   # blue
                 setosa = "#4DAF4A",      # green
                 versicolor = "#984EA3")  # purple
munsell::plot_hex(myCol_named)


# 5 - Remove non-data ink
# 6 - Re-position the legend to the upper left corner
# legend position is in units of npc

# 7 - Relabel the axes (names and units), add a title or caption
# Title: "The Iris Dataset, again!"
# Caption: "Anderson, 1931"

# 8 - Change the aspect ratio to 1:1
# 9 - Set limits on the x and y axes

p +
  geom_jitter(shape = 16, alpha = 0.65) +
  geom_smooth(method = "lm", se = FALSE) +
  coord_fixed(1,
              xlim = c(4,8),
              ylim = c(2, 5),
              expand = 0) +
  scale_color_manual(values = myCol_named) +
  labs(title = "The Iris Dataset, again!",
       caption = "Anderson, 1931",
       color = "Iris species",
       x = "Sepal Length (cm)",
       y = "Sepal Width (cm)") +
  theme_classic(base_size = 8) +
  theme(axis.text = element_text(color = "black"),
        legend.position = c(0.1, 0.9)) +
  NULL

# Saving the plot:
# Raster: png, jpg, gif, bmp, tif
# pixels and resolution
ggsave("myPlot.png", width = 6, height = 6, units = "cm")


# Vector: svg, pdf, ps, eps, il
# instructions to draw an image
ggsave("myPlot.pdf", width = 6, height = 6, units = "cm")


# Some extra examples ----

# specify a color vector:
p +
  geom_jitter(shape = 16, alpha = 0.65) +
  geom_smooth(method = "lm", se = FALSE) +
  scale_color_manual(values = myCol) +
  NULL

# specify brewer color:
p +
  geom_jitter(shape = 16, alpha = 0.65) +
  geom_smooth(method = "lm", se = FALSE) +
  scale_color_brewer(palette = "Dark2") +
  NULL


# Setting span with LOESS
p +
  geom_jitter(shape = 16, alpha = 0.65) +
  geom_smooth(span = 0.45, se = FALSE) +
  NULL
