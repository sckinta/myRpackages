## code to prepare `DATASET` dataset goes here

bedpe <- vroom::vroom(
        file.path("inst/extdata/mustache_ICE_loops.1000.bedpe"),
        col_names=c("chr_a","start_a","end_a","chr_b","start_b","end_b","val1","val2")
)

ibed <- vroom::vroom(file.path("inst/extdata/chicagoResults.ibed"))


baitmap <- vroom::vroom(
        file.path("inst/extdata/chicago_1frag.baitmap"),
        col_names=c("chr","start","end","id","anno")
)

usethis::use_data(bedpe, ibed, baitmap, overwrite = TRUE)
