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
display.brewer.pal(3, "Set2")
myCol <- brewer.pal(3, "Set2") # give the hex codes

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



# To continue:
p +
  geom_jitter(shape = 16, alpha = 0.65)


