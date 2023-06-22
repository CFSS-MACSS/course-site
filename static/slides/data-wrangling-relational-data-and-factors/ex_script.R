## practice

# load libraries 
library(tidyverse)
library(nycflights13)

#start working with data
data(flights)
theme_set(theme_minimal())

#load up some tribbles
x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  3, "x3"
)
y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2",
  4, "y3"
)

# inner_join example
(z <- x %>% 
  inner_join(y, by = "key"))

# outer_join example: left_join
# notice here we didn't pipe
left_join(x, y, by = "key")

# outer_join example: right_join
x %>% 
  right_join(y, by = "key")

# outer_join example: full_join
x %>% 
  full_join(y, by = "key")

### dealing with duplicate keys
xd <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  2, "x3",
  1, "x4"
)
y_1 <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2"
)

# join them when xd has duplicate keys
left_join(xd, y_1, by = "key")

# join when x and y have duplicate keys
yd <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2",
  2, "y3",
  3, "y4"
)
left_join(xd, yd, by = "key")


##***
##*Working through examples
##****

(plane_ages <- planes %>%
    mutate(age = 2013 - year) %>%
    select(tailnum, age))


(gg1 <- flights %>%
  inner_join(y = plane_ages) %>%
  ggplot(mapping = aes(x = age, y = dep_delay)) +
  geom_point() +
  geom_jitter())


(gg2 <- flights %>%
  inner_join(y = plane_ages) %>%
  group_by(age) %>%
  summarise(delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(mapping = aes(x = age, y = delay)) +
  geom_point() +
  geom_line())


###
flights %>%
  left_join(y = airports, by = c(dest = "faa")) %>%
  left_join(y = airports, by = c(origin = "faa"))


####
airports_lite <- airports %>%
  select(faa, lat, lon)

flights %>%
  left_join(y = airports_lite, by = c(dest = "faa")) %>%
  left_join(y = airports_lite, by = c(origin = "faa"), suffix = c(".dest", ".origin"))
