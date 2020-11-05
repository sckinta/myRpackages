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

9. check

do this often
```
devtools::check() 
```
three types : error, warning and notes  
fix problem accordingly  

10. set global variable put into R/globals.R (optional)
when there is warning like "no visible binding for global variable",
add following script (example) to R/globals.R

```
utils::globalVariables(
        c(
                "bait_chr", "bait_start", "bait_end","bait_name",
                "otherEnd_chr", "otherEnd_start", "otherEnd_end","otherEnd_name",
                "N_reads", "score","int_id"
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

