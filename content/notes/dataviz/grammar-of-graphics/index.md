---
title: "The Grammar of Graphics"
date: 2023-06-14
type: book
toc: true
draft: false
aliases: ["/dataviz_grammar-of-graphics.html", "/notes/grammar-of-graphics"]
categories: ["dataviz"]
weight: 22
---



This page is drawn from *A Layered Grammar of Graphics* by Hadley Wickham. I encourage you to read the original article in conjunction with this summary (see assigned readings in the Syllabus).


```r
library(tidyverse)
library(knitr)
library(palmerpenguins)
```

Google defines a **grammar** as "the whole system and structure of a language or of languages in general, usually taken as consisting of syntax and morphology (including inflections) and sometimes also phonology and semantics".[^google] Others consider a grammar to be "the fundamental principles or rules of an art or science".[^hadley] Applied to visualizations, a **grammar of graphics** is a grammar used to describe and create a wide range of statistical graphics.[^wilkinson]

[`ggplot2`](https://cran.r-project.org/web/packages/ggplot2/index.html), is one of the most widely used graphics packages for R. It implements the **layered grammar of graphics** approach: all graphics in ggplot2 are built using a coherent system for describing and building graphs.

Notice [`ggplot2`](https://cran.r-project.org/web/packages/ggplot2/index.html)is part of the [`tidyverse`](https://www.tidyverse.org/) a collection of R packages designed for data science that share the same grammar and data structures.

Whenever you want to check how to translate something into ggplot2 code, the best place to start is [the ggplot2 documentation](https://ggplot2.tidyverse.org/reference/).

# Main components

* Layer
    * Data (data)
    * Mapping (mapping)
    * Statistical transformation (stat)
    * Geometric object (geom)
    * Position adjustment (position)
* Coordinate system (coord)
* Faceting (facet)
* Scale

Before we explain each of them, let's review the code template shown in the reading for today, [Chapter 3](https://r4ds.had.co.nz/data-visualisation.html#data-visualisation) from the R for Data Science book:


```r
ggplot(data = <DATA>) + 
  <GEOM_FUNCTION>(
     mapping = aes(<MAPPINGS>),
     stat = <STAT>, 
     position = <POSITION>
  ) +
  <COORDINATE_FUNCTION> +
  <FACET_FUNCTION>
```

This template takes seven parameters, i.e. the bracketed words, which compose the grammar of graphics. Notice this template is a useful starting point, but this is not the only way this code can be written (read section "Defaults" below for more).

Chapter 3 shows how to fill this template using the `mpg` dataset as an example, which holds observations collected by the US Environmental Protection Agency on 38 models of car:


```r
ggplot(data = mpg) + 
  geom_point(
     mapping = aes(x = displ, y = hwy, color = class),
     stat = "identity", 
     position = "identity"
  ) +
  coord_cartesian() +
  facet_wrap(~ class, nrow = 2) 
```

The variable `displ` is a car’s engine size, in litres; `hwy` is a car’s fuel efficiency on the highway; `class` is a categorical variable that classifies cars into groups such as compact, midsize, and SUV.  


## Layer

**Layers** are used to create the objects on a plot. A layer is defined by five basic parts:

1. Data (data)
1. Mapping (mapping)
1. Statistical transformation (stat)
1. Geometric object (geom)
1. Position adjustment (position)

Layers are typically related to one another and share many common features. In the above example, we only have one layer, but multiple layers can be built using the same underlying data. For example, we can use `geom_point()` to build a scatterplot and use `geom_smooth()` to overlay it with a smoothed regression line to summarize the relationship between two variables:

<img src="{{< blogdown/postref >}}index_files/figure-html/layers-1.png" width="672" />


## Data and Mapping

**Data** defines the source of the information to be visualized, but is independent from the other elements. So a layered graphic can be built which utilizes different data sources while keeping the other components the same.

Let's illustrate how this works using the `penguins` dataset in the [`palmerpenguins`](https://allisonhorst.github.io/palmerpenguins/) package.[^penguins]


```r
head(x = penguins) %>%
  kable(caption = "Dataset of penguins")
```



Table: Table 1: Dataset of penguins

|species |island    | bill_length_mm| bill_depth_mm| flipper_length_mm| body_mass_g|sex    | year|
|:-------|:---------|--------------:|-------------:|-----------------:|-----------:|:------|----:|
|Adelie  |Torgersen |           39.1|          18.7|               181|        3750|male   | 2007|
|Adelie  |Torgersen |           39.5|          17.4|               186|        3800|female | 2007|
|Adelie  |Torgersen |           40.3|          18.0|               195|        3250|female | 2007|
|Adelie  |Torgersen |             NA|            NA|                NA|          NA|NA     | 2007|
|Adelie  |Torgersen |           36.7|          19.3|               193|        3450|female | 2007|
|Adelie  |Torgersen |           39.3|          20.6|               190|        3650|male   | 2007|

**Mapping** defines how the variables are applied to the plot. So if we were graphing information from `penguins`, we might map a penguin's flipper length to the $x$ position and body mass to the $y$ position.


```r
penguins %>%
  select(flipper_length_mm, body_mass_g) %>%
  rename(
    x = flipper_length_mm,
    y = body_mass_g
  )
```

```
## # A tibble: 344 x 2
##        x     y
##    <int> <int>
##  1   181  3750
##  2   186  3800
##  3   195  3250
##  4    NA    NA
##  5   193  3450
##  6   190  3650
##  7   181  3625
##  8   195  4675
##  9   193  3475
## 10   190  4250
## # ... with 334 more rows
```

## Statistical transformation

A **statistical transformation** (*stat*) transforms the data, by summarizing them in some way. For instance, in a bar graph you typically are not trying to graph the raw data. Instead, you might summarize the data by graphing the total number of observations within a set of categories. Or if you have a dataset with many observations, you might transform the data into a smoothing line which summarizes the overall pattern of the relationship between variables by calculating the mean of $y$ conditional on $x$.

A stat is a function that takes in a dataset as the input and returns a dataset as the output; a stat can add new variables to the original dataset, or create an entirely new dataset. So instead of graphing this data in its raw form:


```r
penguins %>%
  select(island)
```

```
## # A tibble: 344 x 1
##    island   
##    <fct>    
##  1 Torgersen
##  2 Torgersen
##  3 Torgersen
##  4 Torgersen
##  5 Torgersen
##  6 Torgersen
##  7 Torgersen
##  8 Torgersen
##  9 Torgersen
## 10 Torgersen
## # ... with 334 more rows
```

You would transform it to:


```r
penguins %>%
  count(island)
```

```
## # A tibble: 3 x 2
##   island        n
##   <fct>     <int>
## 1 Biscoe      168
## 2 Dream       124
## 3 Torgersen    52
```

This is what the geometry `geom_bar()` does automatically when plotting a bar chart. It first transforms the data with the `count` stats and then uses the transformed data to build the plot. The default stats for `geom_bar()` is in fact `stat_count()`.

Sometimes you don't need to make a statistical transformation. For example, in a scatterplot you use the raw values for the $x$ and $y$ variables to map onto the graph. In these situations, the statistical transformation is an *identity* transformation: the stat simply passes in the original dataset and exports the exact same dataset.


## Geometric objects

**Geometric objects** (*geoms*) control the type of plot you create.  For
example, a point geom produces a scatterplot, a line geom produces a line plot, etc. Geoms are classified by their dimensions:

* 0 dimensions - point, text
* 1 dimension - path, line
* 2 dimensions - polygon, interval

Each geom can only display certain **aesthetics** or visual attributes of the geom. For example, a `geom_point()` has position, color, shape, and size aesthetics.


```r
ggplot(data = penguins, mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)) +
  geom_point() +
  ggtitle("A point geom with position and color aesthetics")
```

<img src="{{< blogdown/postref >}}index_files/figure-html/geom_point-1.png" width="672" />

* Position defines where each point is drawn on the plot (x and y)
* Color defines the color of each point. Here the color is determined by the species of the penguins (observation)

Notice we can write the same code slighty differently, as follows:


```r
ggplot() +
  geom_point(data = penguins, mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)) +
  ggtitle("A point geom with position and color aesthetics")
```

<img src="{{< blogdown/postref >}}index_files/figure-html/geom_point_rewritten-1.png" width="672" />

Take a look at the [`geom_point() documentation](https://ggplot2.tidyverse.org/reference/geom_point.html) for more info. 

Similarly, a `bar_geom()` has its own aesthetics: position, height, width, and fill color.


```r
ggplot(data = penguins, aes(x = island)) +
  geom_bar() +
  ggtitle("A bar geom with position and height aesthetics")
```

<img src="{{< blogdown/postref >}}index_files/figure-html/geom_bar-1.png" width="672" />

* Position determines the starting location (origin) of each bar
* Height determines how tall to draw the bar. Here the height is based on the number of observations in the dataset for each island.


## Position adjustment

Sometimes with dense data we need to adjust the position of elements on the plot, otherwise data points might obscure one another. Bar plots frequently **stack** or **dodge** the bars to avoid overlap:


```r
count(x = penguins, species, island) %>%
  ggplot(mapping = aes(x = island, y = n, fill = species)) +
  geom_bar(stat = "identity") +
  ggtitle(label = "A stacked bar chart")
```

<img src="{{< blogdown/postref >}}index_files/figure-html/position_dodge-1.png" width="672" />

```r
count(x = penguins, species, island) %>%
  ggplot(mapping = aes(x = island, y = n, fill = species)) +
  geom_bar(stat = "identity", position = "dodge") +
  ggtitle(label = "A dodged bar chart")
```

<img src="{{< blogdown/postref >}}index_files/figure-html/position_dodge-2.png" width="672" />

Sometimes scatterplots with few unique $x$ and $y$ values are **jittered** (random noise is added) to reduce overplotting.


```r
ggplot(data = penguins, mapping = aes(x = island, y = body_mass_g)) +
  geom_point() +
  ggtitle("A point geom with obscured data points")
```

<img src="{{< blogdown/postref >}}index_files/figure-html/position-1.png" width="672" />

```r
ggplot(data = penguins, mapping = aes(x = island, y = body_mass_g)) +
  geom_jitter() +
  ggtitle("A point geom with jittered data points")
```

<img src="{{< blogdown/postref >}}index_files/figure-html/position-2.png" width="672" />


## Coordinate system

A **coordinate system** (*coord*) maps the position of objects onto the plane of the plot, and controls how the axes and grid lines are drawn. Plots typically use two coordinates ($x, y$), but could use any number of coordinates. Most plots are drawn using the [**Cartesian coordinate system**](https://en.wikipedia.org/wiki/Cartesian_coordinate_system):


```r
x1 <- c(1, 10)
y1 <- c(1, 5)
p <- qplot(x = x1, y = y1, geom = "blank", xlab = NULL, ylab = NULL) +
  theme_bw()
p +
  ggtitle(label = "Cartesian coordinate system")
```

<img src="{{< blogdown/postref >}}index_files/figure-html/coord_cart-1.png" width="672" />

This system requires a fixed and equal spacing between values on the axes. That is, the graph draws the same distance between 1 and 2 as it does between 5 and 6. The graph could be drawn using a [**semi-log coordinate system**](https://en.wikipedia.org/wiki/Semi-log_plot) which logarithmically compresses the distance on an axis:


```r
p +
  coord_trans(y = "log10") +
  ggtitle(label = "Semi-log coordinate system")
```

<img src="{{< blogdown/postref >}}index_files/figure-html/coord_semi_log-1.png" width="672" />

Or could even be drawn using [**polar coordinates**](https://en.wikipedia.org/wiki/Polar_coordinate_system):


```r
p +
  coord_polar() +
  ggtitle(label = "Polar coordinate system")
```

<img src="{{< blogdown/postref >}}index_files/figure-html/coord_polar-1.png" width="672" />

## Faceting

**Faceting** can be used to split the data up into subsets of the entire dataset. This is a powerful tool when investigating whether patterns are the same or different across conditions, and allows the subsets to be visualized on the same plot (known as **conditioned** or **trellis** plots). The faceting specification describes which variables should be used to split up the data, and how they should be arranged.


```r
ggplot(data = penguins, mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point() +
  facet_wrap(facets = vars(species))
```

<img src="{{< blogdown/postref >}}index_files/figure-html/facet-1.png" width="672" />

## Scale

A **scale** controls how variables are mapped to aesthetic attributes, so we need one scale for every aesthetic property employed in a layer. For example, this graph defines a scale for color:


```r
ggplot(data = penguins, mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)) +
  geom_point() +
  guides(color = guide_legend(override.aes = list(size = 4)))
```

<img src="{{< blogdown/postref >}}index_files/figure-html/scale_color-1.png" width="672" />

Note that the scale is consistent - every point for an Adèlie penguin is drawn in red, whereas Chinstrap penguins are drawn in green. The scale can be changed to use a different color palette:


```r
ggplot(data = penguins, mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)) +
  geom_point() +
  guides(color = guide_legend(override.aes = list(size = 4))) +
  scale_color_brewer(palette = "Dark2")
```

<img src="{{< blogdown/postref >}}index_files/figure-html/scale_color_palette-1.png" width="672" />

Now we are using a different palette, but the scale is still consistent: all Adèlie penguins utilize the same color, whereas Chinstrap penguins use a new color **but each Chinstrap penguin still uses the same, consistent color**.

# Defaults

Rather than explicitly declaring each component of the grammar of graphics (which will use more code and introduces opportunities for errors), **we can establish defaults, and simplify our code**. In fact, the grammar of graphics in ggplot2 comes with a hierarchy of defaults. Let's see a couple of examples:

**Example 1**: you want to generate a scatterplot of cars' engine size (`displ`) and cars' fuel efficiency on the highway (`hwy`). Notice that this short code:


```r
ggplot(data = mpg, 
       aes(x = displ, y = hwy)) +
  geom_point()
```

Is equivalent to this unnecessary extended code:


```r
ggplot() +
  layer(
    data = mpg, 
    mapping = aes(x = displ, y = hwy),
    geom = "point", 
    stat = "identity", 
    position = "identity"
  ) +
  scale_y_continuous() +
  scale_x_continuous() +
  coord_cartesian()
```


**Example 2**: you want to generate a scatterplot visualizing the relationship between penguins flipper length and body mass. With no defaults, the code to generate this graph is:


```r
ggplot() +
  layer(
    data = penguins, 
    mapping = aes(x = flipper_length_mm, y = body_mass_g),
    geom = "point", stat = "identity", position = "identity"
  ) +
  scale_x_continuous() +
  scale_y_continuous() +
  coord_cartesian()
```

<img src="{{< blogdown/postref >}}index_files/figure-html/default-1.png" width="672" />

The above code:

* Creates a new plot object (`ggplot`)
* Adds a layer (`layer`)
    * Specifies the data (`penguins`)
    * Maps flipper length to the $x$ position and body mass to the $y$ position (`mapping`)
    * Uses the point geometric transformation (`geom = "point"`)
    * Implements an identity transformation and position (`stat = "identity"` and `position = "identity"`)
* Establishes two continuous position scales (`scale_x_continuous` and `scale_y_continuous`)
* Declares a cartesian coordinate system (`coord_cartesian`)

How can we simplify this using defaults?

1. We only need to specify one geom and stat, since each geom has a default stat.
1. Cartesian coordinate systems are most commonly used, so it is the default.
1. Default scales can be added based on the aesthetic and type of variables.
    * Continuous values are transformed with a linear scaling.
    * Discrete values are mapped to integers.
    * Scales for aesthetics such as color, fill, and size can also be intelligently defaulted.

Using these defaults, we can rewrite the above code as:


```r
ggplot() +
  geom_point(data = penguins, mapping = aes(x = flipper_length_mm, y = body_mass_g))
```

<img src="{{< blogdown/postref >}}index_files/figure-html/default2-1.png" width="672" />

This generates the exact same plot, but uses fewer lines of code. Because multiple layers can use the same components (data, mapping, etc.), we can also specify that information directly in the `ggplot()` function rather than in the `layer()` function:


```r
ggplot(data = penguins, mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point()
```

<img src="{{< blogdown/postref >}}index_files/figure-html/default3-1.png" width="672" />

Moreover, **all function arguments in R use specific ordering**, so we can omit the explicit call to `data` and `mapping`:


```r
ggplot(penguins, aes(flipper_length_mm, body_mass_g)) +
  geom_point()
```

<img src="{{< blogdown/postref >}}index_files/figure-html/default4-1.png" width="672" />

With this specification, we can build the graphic up with additional layers, without modifying the original code:


```r
ggplot(penguins, aes(flipper_length_mm, body_mass_g)) +
  geom_point() +
  geom_smooth()
```

<img src="{{< blogdown/postref >}}index_files/figure-html/default5-1.png" width="672" />

Because we called `aes(flipper_length_mm, body_mass_g)` within the `ggplot()` function, it is automatically passed along to both `geom_point()` and `geom_smooth()`. If we fail to do this, we get an error:


```r
ggplot(penguins) +
  geom_point(aes(flipper_length_mm, body_mass_g)) +
  geom_smooth()
```

```
## Error in `check_required_aesthetics()`:
## ! stat_smooth requires the following missing aesthetics: x and y
```

## 


<!--
## Session Info



```r
sessioninfo::session_info()
```

```
## - Session info ---------------------------------------------------------------
##  setting  value
##  version  R version 4.1.3 (2022-03-10)
##  os       Windows 10 x64 (build 19044)
##  system   x86_64, mingw32
##  ui       RTerm
##  language (EN)
##  collate  English_United States.1252
##  ctype    English_United States.1252
##  tz       America/Chicago
##  date     2022-10-05
##  pandoc   2.17.1.1 @ C:/Program Files/RStudio/bin/quarto/bin/ (via rmarkdown)
## 
## - Packages -------------------------------------------------------------------
##  package        * version date (UTC) lib source
##  assertthat       0.2.1   2019-03-21 [1] CRAN (R 4.1.3)
##  backports        1.4.1   2021-12-13 [1] CRAN (R 4.1.2)
##  blogdown         1.11    2022-08-09 [1] CRAN (R 4.1.3)
##  bookdown         0.28    2022-08-09 [1] CRAN (R 4.1.3)
##  broom            1.0.1   2022-08-29 [1] CRAN (R 4.1.3)
##  bslib            0.4.0   2022-07-16 [1] CRAN (R 4.1.3)
##  cachem           1.0.6   2021-08-19 [1] CRAN (R 4.1.3)
##  cellranger       1.1.0   2016-07-27 [1] CRAN (R 4.1.3)
##  cli              3.3.0   2022-04-25 [1] CRAN (R 4.1.3)
##  colorspace       2.0-3   2022-02-21 [1] CRAN (R 4.1.3)
##  crayon           1.5.1   2022-03-26 [1] CRAN (R 4.1.3)
##  DBI              1.1.3   2022-06-18 [1] CRAN (R 4.1.3)
##  dbplyr           2.2.1   2022-06-27 [1] CRAN (R 4.1.3)
##  digest           0.6.29  2021-12-01 [1] CRAN (R 4.1.3)
##  dplyr          * 1.0.9   2022-04-28 [1] CRAN (R 4.1.3)
##  ellipsis         0.3.2   2021-04-29 [1] CRAN (R 4.1.3)
##  evaluate         0.16    2022-08-09 [1] CRAN (R 4.1.3)
##  fansi            1.0.3   2022-03-24 [1] CRAN (R 4.1.3)
##  fastmap          1.1.0   2021-01-25 [1] CRAN (R 4.1.3)
##  forcats        * 0.5.2   2022-08-19 [1] CRAN (R 4.1.3)
##  fs               1.5.2   2021-12-08 [1] CRAN (R 4.1.3)
##  gargle           1.2.0   2021-07-02 [1] CRAN (R 4.1.3)
##  generics         0.1.3   2022-07-05 [1] CRAN (R 4.1.3)
##  ggplot2        * 3.3.6   2022-05-03 [1] CRAN (R 4.1.3)
##  glue             1.6.2   2022-02-24 [1] CRAN (R 4.1.3)
##  googledrive      2.0.0   2021-07-08 [1] CRAN (R 4.1.3)
##  googlesheets4    1.0.1   2022-08-13 [1] CRAN (R 4.1.3)
##  gtable           0.3.1   2022-09-01 [1] CRAN (R 4.1.3)
##  haven            2.5.1   2022-08-22 [1] CRAN (R 4.1.3)
##  here             1.0.1   2020-12-13 [1] CRAN (R 4.1.3)
##  hms              1.1.2   2022-08-19 [1] CRAN (R 4.1.3)
##  htmltools        0.5.2   2021-08-25 [1] CRAN (R 4.1.3)
##  httr             1.4.4   2022-08-17 [1] CRAN (R 4.1.3)
##  jquerylib        0.1.4   2021-04-26 [1] CRAN (R 4.1.3)
##  jsonlite         1.8.0   2022-02-22 [1] CRAN (R 4.1.3)
##  knitr          * 1.40    2022-08-24 [1] CRAN (R 4.1.3)
##  lifecycle        1.0.1   2021-09-24 [1] CRAN (R 4.1.3)
##  lubridate        1.8.0   2021-10-07 [1] CRAN (R 4.1.3)
##  magrittr         2.0.3   2022-03-30 [1] CRAN (R 4.1.3)
##  modelr           0.1.9   2022-08-19 [1] CRAN (R 4.1.3)
##  munsell          0.5.0   2018-06-12 [1] CRAN (R 4.1.3)
##  palmerpenguins * 0.1.1   2022-08-15 [1] CRAN (R 4.1.3)
##  pillar           1.8.1   2022-08-19 [1] CRAN (R 4.1.3)
##  pkgconfig        2.0.3   2019-09-22 [1] CRAN (R 4.1.3)
##  purrr          * 0.3.4   2020-04-17 [1] CRAN (R 4.1.3)
##  R6               2.5.1   2021-08-19 [1] CRAN (R 4.1.3)
##  readr          * 2.1.2   2022-01-30 [1] CRAN (R 4.1.3)
##  readxl           1.4.1   2022-08-17 [1] CRAN (R 4.1.3)
##  reprex           2.0.2   2022-08-17 [1] CRAN (R 4.1.3)
##  rlang            1.0.4   2022-07-12 [1] CRAN (R 4.1.3)
##  rmarkdown        2.16    2022-08-24 [1] CRAN (R 4.1.3)
##  rprojroot        2.0.3   2022-04-02 [1] CRAN (R 4.1.3)
##  rstudioapi       0.14    2022-08-22 [1] CRAN (R 4.1.3)
##  rvest            1.0.3   2022-08-19 [1] CRAN (R 4.1.3)
##  sass             0.4.2   2022-07-16 [1] CRAN (R 4.1.3)
##  scales           1.2.1   2022-08-20 [1] CRAN (R 4.1.3)
##  sessioninfo      1.2.2   2021-12-06 [1] CRAN (R 4.1.3)
##  stringi          1.7.6   2021-11-29 [1] CRAN (R 4.1.2)
##  stringr        * 1.4.1   2022-08-20 [1] CRAN (R 4.1.3)
##  tibble         * 3.1.8   2022-07-22 [1] CRAN (R 4.1.3)
##  tidyr          * 1.2.0   2022-02-01 [1] CRAN (R 4.1.3)
##  tidyselect       1.1.2   2022-02-21 [1] CRAN (R 4.1.3)
##  tidyverse      * 1.3.2   2022-07-18 [1] CRAN (R 4.1.3)
##  tzdb             0.3.0   2022-03-28 [1] CRAN (R 4.1.3)
##  utf8             1.2.2   2021-07-24 [1] CRAN (R 4.1.3)
##  vctrs            0.4.1   2022-04-13 [1] CRAN (R 4.1.3)
##  withr            2.5.0   2022-03-03 [1] CRAN (R 4.1.3)
##  xfun             0.30    2022-03-02 [1] CRAN (R 4.1.3)
##  xml2             1.3.3   2021-11-30 [1] CRAN (R 4.1.3)
##  yaml             2.3.5   2022-02-21 [1] CRAN (R 4.1.2)
## 
##  [1] C:/Users/Sabrina Nardin/Documents/R/win-library/4.1
##  [2] C:/Program Files/R/R-4.1.3/library
## 
## ------------------------------------------------------------------------------
```
-->

## Acknowledgments

[^google]: [Google](https://www.google.com/search?q=grammar).
[^hadley]: [Wickham, Hadley. (2010) "A Layered Grammar of Graphics". *Journal of Computational and Graphical Statistics*, 19(1).](https://www.tandfonline.com/doi/pdf/10.1198/jcgs.2009.07098).
[^wilkinson]: [Wilkinson, Leland. (2005). *The Grammar of Graphics*.](https://newcatalog.library.cornell.edu/catalog/15414882).
[^penguins]: Run `?penguins` in the console to get more information about this dataset.


* This page is derived in part from ["UBC STAT 545A and 547M"](http://stat545.com), licensed under the [CC BY-NC 3.0 Creative Commons License](https://creativecommons.org/licenses/by-nc/3.0/).

* This page has been developed starting from Benjamin Soltoff’s “Computing for the Social Sciences” course materials, licensed under the CC BY-NC 4.0 Creative Commons License.
