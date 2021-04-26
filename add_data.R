# https://r-pkgs.org/data.html

## extdata - raw data
dir.create("inst")
dir.create("inst/extdata")

# Files not of a type allowed in a ‘data’ directory:
#         ‘chicagoResults.ibed’ ‘chicago_1frag.baitmap’
# ‘mustache_ICE_loops.1000.bedpe’
# Please use e.g. ‘inst/extdata’ for non-R data files

# to write in @example
# \donttest{
#' read_ibed_with_int_id(
#' system.file("extdata", "chicagoResults.ibed", package = "parseIbed"),
#' parse_b2b="only bi-direction"
#' )
#' }
#'
#'
## example 1 - each .rda containing a single object (with the same name as the file)
dir.create('data')
bedpe <- vroom::vroom(
        file.path("inst/extdata/mustache_ICE_loops.1000.bedpe"),
        col_names=c("chr_a","start_a","end_a","chr_b","start_b","end_b","val1","val2")
        )

ibed <- vroom::vroom(file.path("inst/extdata/chicagoResults.ibed"))


baitmap <- vroom::vroom(
        file.path("inst/extdata/chicago_1frag.baitmap"),
        col_names=c("chr","start","end","id","anno")
)


# if those data is required for function run,it will write into R/sysdata.rda which
# do not need to be documented
usethis::use_data(bedpe,ibed,baitmap, internal=T, overwrite = TRUE)

# if those data is just internal do not want to load into package while load package,
# but instead, add in using data(example), then
# save(bedpe, ibed, baitmap, file=file.path("data/example.rda"))
usethis::use_r("bedpe-data.R")
# to insert Roxygen2 comments, create a dummy data <- function(){}
# then put curser at {|}, then Menu -> Code -> Insert Roxygen Skeleton
# in @examples: we can use \donttest{<R_code>} to make sure that examples wont test
# certain lines
usethis::use_data(bedpe, overwrite = TRUE)
# use_data() before devtools::document()

usethis::use_r("ibed-data.R")
usethis::use_data(ibed, overwrite = TRUE)

usethis::use_r("baitmap-data.R")
usethis::use_data(baitmap, overwrite = TRUE)

# usually we want to put above code in data-raw/DATASET.R, to initate
# data-raw/DATASET.R, run
usethis::use_data_raw()

## example 2
prom_bed <- vroom::vroom(
        file.path("inst/extdata/prom_bed.txt")
)

# save(prom_bed, file=file.path("data/prom_bed.rda"))


usethis::use_r("prom_bed-data.R")
usethis::use_data(prom_bed, overwrite = TRUE)


