# myRpackages
This respository stores custom R packages
- [DFbedtools](./DFbedtools)
- [parseIbed](./parseIbed)

## Install packages
```R
devtools::install_github("sckinta/myRpackages", ref = "master", subdir = "parseIbed")

devtools::install_github("sckinta/myRpackages", ref = "master", subdir = "DFbedtools")
```

## functions

### DFbedtools
overlap_df(df1, df2, df1_chr_col="chr", df1_start_col="start", df1_end_col="end", df1_0base=F, df2_chr_col="chr", df2_start_col="start", df2_end_col="end", df2_0base=F, minoverlap=0L)

pair2pair(df1, df2, df1_chr1_col="bait_chr", df1_start1_col="bait_start", df1_end1_col="bait_end", df1_chr2_col="oe_chr", df1_start2_col="oe_start", df1_end2_col="oe_end", df1_0base=F, df2_chr1_col="bait_chr", df2_start1_col="bait_start", df2_end1_col="bait_end", df2_chr2_col="oe_chr", df2_start2_col="oe_start", df2_end2_col="oe_end", df2_0base=F, minoverlap=0L)

### parseIbed
read_ibed_with_int_id(ibed, parse_b2b=NULL, max_score=F) # ibed can be df or file

read_washU_with_int_id(file)

summarise_from_ibed(ibed, baitmap) # ibed can be df or file

annotate_bedpe2gene(bedpe, prom_bed) # also work for ibed. `?annotate_bedpe2gene`

annotate_bedpe2geneOCR(bedpe, ocr_bed, prom_bed) # also work for ibed. `?annotate_bedpe2geneOCR`
