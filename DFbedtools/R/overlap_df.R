#' Overlap two data frame containing coordinates
#'
#' @param df1 data.frame 1, required
#' @param df2 data.frame 2, required
#' @param df1_chr_col chr column name data.frame 1, default="chr"
#' @param df1_start_col start column name data.frame 1, default="start"
#' @param df1_end_col end column name data.frame 1, default="end"
#' @param df1_0base whether data.frame 1 start is 0-based, default=F
#' @param df2_chr_col chr column name data.frame 2, default="chr"
#' @param df2_start_col start column name data.frame 2, default="start"
#' @param df2_end_col end column name data.frame 2, default="end"
#' @param df2_0base whether data.frame 2 start is 0-based, default=F
#' @param minoverlap minimum overlap length, default=0L
#'
#' @return a list of data.frame, constituting overlap_df1 and overlap_df2
#' @importFrom GenomicRanges makeGRangesFromDataFrame findOverlaps
#' @export
#'
#' @examples
#' df1 = data.frame(chr=c("chr1","chr1"), start=c(2345,12345), end=c(12345,23456))
#' df2 = data.frame(chr=c("chr1","chr2"), start=c(2245,1245), end=c(2345,2456))
#' overlap_df(df1, df2)

overlap_df <- function(df1, df2, df1_chr_col="chr", df1_start_col="start", df1_end_col="end", df1_0base=F, df2_chr_col="chr", df2_start_col="start", df2_end_col="end", df2_0base=F, minoverlap=0L){
        df1_gr = makeGRangesFromDataFrame(
                df1, keep.extra.columns=T, ignore.strand=FALSE, seqinfo=NULL,
                seqnames.field=df1_chr_col, start.field=df1_start_col, end.field=df1_end_col, strand.field="strand", starts.in.df.are.0based=df1_0base
        )
        df2_gr = makeGRangesFromDataFrame(
                df2, keep.extra.columns=T, ignore.strand=FALSE, seqinfo=NULL,
                seqnames.field=df2_chr_col, start.field=df2_start_col, end.field=df2_end_col, strand.field="strand", starts.in.df.are.0based=df2_0base
        )
        overlap = GenomicRanges::findOverlaps(df1_gr, df2_gr, minoverlap=minoverlap)
        overlap_df1 = df1[overlap@from,]
        overlap_df2 = df2[overlap@to,]
        list(
                overlap_df1= overlap_df1,
                overlap_df2= overlap_df2
        )
}
