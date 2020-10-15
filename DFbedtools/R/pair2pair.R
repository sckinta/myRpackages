#' pair-end coordinate data.frame intersect (pairToPair)
#'
#' Both ends need to be overlaped with each other
#'
#' @param df1 data.frame 1, required. contains two coordinates
#' @param df2 data.frame 2, required. contains two coordinates
#' @param df1_chr1_col data.frame 1 coordinate 1 chromosome column name, default = "bait_chr"
#' @param df1_start1_col data.frame 1 coordinate 1 start column name, default = "bait_start"
#' @param df1_end1_col data.frame 1 coordinate 1 end column name, default = "bait_end"
#' @param df1_chr2_col data.frame 1 coordinate 2 chromosome column name, default = "oe_chr"
#' @param df1_start2_col data.frame 1 coordinate 2 start column name, default = "oe_start"
#' @param df1_end2_col data.frame 1 coordinate 2 end column name, default = "oe_end"
#' @param df1_0base whether data.frame 1 start is 0-based, default = F
#' @param df2_chr1_col data.frame 2 coordinate 1 chromosome column name, default = "bait_chr"
#' @param df2_start1_col data.frame 2 coordinate 1 start column name, default = "bait_start"
#' @param df2_end1_col data.frame 2 coordinate 1 end column name, default = "bait_end"
#' @param df2_chr2_col data.frame 2 coordinate 2 chromosome column name, default = "oe_chr"
#' @param df2_start2_col data.frame 2 coordinate 2 start column name, default = "oe_start"
#' @param df2_end2_col data.frame 2 coordinate 2 start column name, default = "oe_start"
#' @param df2_0base whether data.frame 2 start is 0-based, default = F
#' @param minoverlap minimum overlap length, default=0L
#'
#' @return a list of data.frame, constituting overlap_df1 and overlap_df2
#' @importFrom dplyr left_join mutate select semi_join bind_cols row_number
#' @export
#'
#' @examples
#' df1 = data.frame(
#' bait_chr=c("chr1","chr1"), bait_start=c(2345,12345), bait_end=c(12345,23456),
#'  oe_chr=c("chr1","chr1"), oe_start=c(2345,12345), oe_end=c(12345,23456)
#'  )
#' df2 = data.frame(
#' bait_chr=c("chr1","chr2"), bait_start=c(2245,1245), bait_end=c(2345,2456),
#' oe_chr=c("chr1","chr1"), oe_start=c(2345,12345), oe_end=c(12345,23456)
#' )
#' pair2pair(df1, df2)
pair2pair <- function(df1, df2, df1_chr1_col="bait_chr", df1_start1_col="bait_start", df1_end1_col="bait_end", df1_chr2_col="oe_chr", df1_start2_col="oe_start", df1_end2_col="oe_end", df1_0base=F, df2_chr1_col="bait_chr", df2_start1_col="bait_start", df2_end1_col="bait_end", df2_chr2_col="oe_chr", df2_start2_col="oe_start", df2_end2_col="oe_end", df2_0base=F, minoverlap=0L){
        rowId <- NULL # force "global variable" local
        bait_overlap = overlap_df(df1, df2,
                                  df1_chr_col=df1_chr1_col, df1_start_col=df1_start1_col, df1_end_col=df1_end1_col, df1_0base=F, df2_chr_col=df2_chr1_col, df2_start_col=df2_start1_col, df2_end_col=df2_end1_col, df2_0base=F,
                                  minoverlap=0L
        )

        oe_overlap = overlap_df(df1, df2,
                                df1_chr_col=df1_chr2_col, df1_start_col=df1_start2_col, df1_end_col=df1_end2_col, df1_0base=F, df2_chr_col=df2_chr2_col, df2_start_col=df2_start2_col, df2_end_col=df2_end2_col, df2_0base=F,
                                minoverlap=0L
        )

        bait_overlap_id = bind_cols(
                left_join(
                        bait_overlap[["overlap_df1"]],
                        df1 %>% mutate(rowId=dplyr::row_number())
                ) %>% select(queryId=rowId),
                left_join(
                        bait_overlap[["overlap_df2"]],
                        df2 %>% mutate(rowId=dplyr::row_number())
                ) %>% select(subjectId=rowId)
        )

        oe_overlap_id = bind_cols(
                left_join(
                        oe_overlap[["overlap_df1"]],
                        df1 %>% mutate(rowId=row_number())
                ) %>% select(queryId=rowId),
                left_join(
                        oe_overlap[["overlap_df2"]],
                        df2 %>% mutate(rowId=row_number())
                ) %>% select(subjectId=rowId)
        )

        pair_overlap_id = semi_join(bait_overlap_id, oe_overlap_id)

        list(
                overlap_df1 = df1[pair_overlap_id$queryId,],
                overlap_df2 = df2[pair_overlap_id$subjectId,]
        )

}
