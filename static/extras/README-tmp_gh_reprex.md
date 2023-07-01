``` r
library(tidyverse)
count(diamonds, colour)
#> Error in `count()`:
#> ! Must group by variables found in `.data`.
#> ✖ Column `colour` is not found.
#> Backtrace:
#>     ▆
#>  1. ├─dplyr::count(diamonds, colour)
#>  2. └─dplyr:::count.data.frame(diamonds, colour)
#>  3.   ├─dplyr::group_by(x, ..., .add = TRUE, .drop = .drop)
#>  4.   └─dplyr:::group_by.data.frame(x, ..., .add = TRUE, .drop = .drop)
#>  5.     └─dplyr::group_by_prepare(.data, ..., .add = .add, error_call = current_env())
#>  6.       └─rlang::abort(bullets, call = error_call)
```

<sup>Created on 2023-07-01 with [reprex v2.0.2](https://reprex.tidyverse.org)</sup>
