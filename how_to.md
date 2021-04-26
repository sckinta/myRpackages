# How-to
Notes from [Shannon Pileggi's R package development tutorial](https://www.pipinghotdata.com/posts/2020-10-25-your-first-r-package-in-1-hour/#tool-kit)

1. load package development required package

```R
library(usethis)
library(devtools)
```
2. create new package Rproject

```R
dir.create("/Users/suc1/ShareFile/Personal Folders/Analysis/myRpackages/<packageName>")
usethis::create_package("/Users/suc1/ShareFile/Personal Folders/Analysis/myRpackages/<packageName>")
```

3. ADD license to DESCRIPTION and Edit DESCRIPTION

```R
usethis::use_mit_license("Chun Su")
```
open DESCRIPTION and edit package description


4. specify use pipe and package you may need for functions
This is global package added to `imports` in `DESCRIPTION`

```R
usethis::use_pipe() # most regular one
usethis::use_package("dplyr")
usethis::use_package("tidyr")
usethis::use_package("readr")
usethis::use_package("rlang")
usethis::use_package("vroom")
usethis::use_dev_package("DFbedtools", type = "Imports", remote = "sckinta/myRpackages")
```

5 - create function
This create script with given function name i R/
```
usethis::use_r("<function_name>")
```
open R/<function_name>.R and write your function in file

6 - insert Roxygen skeleton and fill in spots
- insert Roxygen skeleton
  - step 1: put mouse inside of function(){|}
  - step 2: insert Roxygen
    - option 1: Menu -> Code -> Insert Roxygen Skeleton
    - option 2: `Cntrl + Alt + Shift + R`
- fill spots to declare dependency (`import`)
  - Title
  - General Description (one gap line away from title)
  - `@param` description
  - `@return` description
  - package/function dependencies (depends on how often you used functions from apackages)
    - option 1: `@import pkg1 pkg2 pkg3`
    - option 2: `@importFrom pkg4 func1`
    - option 3: use `pkg::func` in {}.
    - *option 2 and option 3 just use one for a given function*
    - *packages imported in option 1 don't need option 2&3*

The two types of dependencies that need to be specified are
  - package dependencies (global in DESCRIPTION, see step 4)
  - dependencies on functions within packages (for each function `@import` or `@importFrom`)

7. write document

automatic write documentation, which create man/ and NAMESPACE. *Do not edit man/ and NAMESPACE*
```
devtools::document()
```

8. test document correct or not

```
devtools::load_all()
?<function_name>
```

9. [add data](https://r-pkgs.org/data.html) (optional)
There are 3 types of data
- data loaded automatically when `library(pkg)`
  - save in `R/sysdata.rda`
    - can be mutltiple objects.
    - generate by `usethis::use_data(x, y, z, internal = TRUE)`
- data load by `data(DATASET)`
  - save in `data/*.rda`
    - can only be single object per .rda file
    - generate by `usethis::use_data(mtcars, overwrite = TRUE)`
    - need to create document for data `usethis::use_r("mtcars-data.R")`. [example](https://github.com/kbroman/qtlcharts/blob/master/R/grav-data.R) 
       - to insert Roxygen2 comments, create a dummy function data <- function(){}
       - then put curser at {|}, then Menu -> Code -> Insert Roxygen Skeleton, then remove dummy function
       - required Roxygen2 elements: @docType data; @usage data(ibed)
       - in \\@examples: we can use \\donttest{<R_code>} to make sure that examples wont test
    - better save the data generation source code in `data-raw/DATASET.R`. 
      - to initate `data-raw/DATASET.R, type `usethis::use_data_raw()`
      - put below example in `data-raw/DATASET.R`
        ```R
        dir.create("data")
        bedpe <- vroom::vroom(
        file.path("inst/extdata/mustache_ICE_loops.1000.bedpe"),
        col_names=c("chr_a","start_a","end_a","chr_b","start_b","end_b","val1","val2"))

        ibed <- vroom::vroom(file.path("inst/extdata/chicagoResults.ibed"))


        baitmap <- vroom::vroom(
        file.path("inst/extdata/chicago_1frag.baitmap"),
        col_names=c("chr","start","end","id","anno")
        )

        usethis::use_data(bedpe, ibed, baitmap, overwrite = TRUE)
        ```
- raw data
  - save in `inst/extdata/*`
  - after package installation, access those raw data by `system.file("extdata", "chicagoResults.ibed", package = "parseIbed")`

10. check

do this often
```
devtools::check() 
```
three types : error, warning and notes  
fix problem accordingly  

11. set global variable put into R/globals.R (optional)

when there is warning like "no visible binding for global variable",
add following script (example) to R/globals.R

```
utils::globalVariables(
        c(
                "bait_chr", "bait_start", "bait_end","bait_name",
                "otherEnd_chr", "otherEnd_start", "otherEnd_end","otherEnd_name",
                "N_reads", "score","int_id", "anno_a", "anno_b", "chr", "chr_a", "chr_b", "end", "end_a", "end_b", "ocr_a", "ocr_b", "pro_anno", "start", "start_a", "start_b"
        )
)
```

# other tips

- break from a function

```R
stop("your message")
stopifnot(x > 10)
```
- checking dependencies in R code ... WARNING
'::' or ':::' import not declared from: ‘glue’

Solution: add package "glue" to DESCRIPTION

- Roxygen to prevent running example

```R
#' # annotate ibed file on one side
#'
#' \donttest{data(ibed)
#' data(prom_bed)
#' annotate_bedpe2gene(
#' ibed %>% mutate_at(vars(ends_with("_start")), function(x){x=x-1}),
#' prom_bed, gene_side="bait",
#' bedpe_chr_a="bait_chr", bedpe_start_a="bait_start", bedpe_end_a="bait_end",
#' bedpe_chr_b="otherEnd_chr", bedpe_start_b="otherEnd_start", bedpe_end_b="otherEnd_end"
#' )
#' }
```
