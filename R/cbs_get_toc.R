#' Retrieve a data.frame with requested cbs tables
#' 
#' `cbs_get_toc` by default a list of all tables and all columns will be retrieved.
#' You can restrict the query by supplying multiple filter statements or by specifying the
#' columns that should be returned.
#' 
#' @note `cbs_get_toc` will cache results, so subsequent calls will be much faster.
#' 
#' @param ... filter statement to select rows, e.g. Language="nl"
#' @param convert_dates convert the columns with date-time information into DateTime (default `TRUE`)
#' @param select `character` columns to be returned, by default all columns
#' will be returned.
#' @param verbose `logical` prints the calls to the webservice
#' @param cache `logical` should the result be cached?
#' @param include_ID `logical` column needed by OData but with no current use.
#' @param base_url optionally specify a different server. Useful for
#' third party data services implementing the same protocol.
#' @return `data.frame` with identifiers, titles and descriptions of tables
#' @importFrom whisker whisker.render
#' @importFrom jsonlite fromJSON
#' @export
#' @examples 
#' \dontrun{
#' 
#' # get list of english tables
#' tables_en <- cbs_get_toc(Language="en")
#'
#' # get list of dutch tables
#' tables_nl <- cbs_get_toc(Language="nl")
#' View(tables_nl)
#' }
cbs_get_toc <- function( ...
                       , convert_dates = TRUE
                       , select        = NULL
                       , verbose       = FALSE
                       , cache         = TRUE
                       , base_url      = getOption("cbsodataR.base_url", BASE_URL)
                       , include_ID    = FALSE
                       ){
  url <- whisker.render("{{BASEURL}}/{{CATALOG}}/Tables?$format=json"
                       , list( BASEURL = base_url
                             , CATALOG = CATALOG
                             )
                       )
  url <- paste0(url, get_query(..., select=select))
  
  tables <- resolve_resource(url, "Retrieving tables from", verbose = verbose, cache = cache)
  class(tables) <- c("tbl_df", "tbl", class(tables))
  if (!include_ID){
    tables <- tables[, names(tables) != "ID", drop = FALSE]
  }
  
  if (convert_dates){
    date_cols <- c("Updated","Modified", "MetaDataModified")
    date_cols <- date_cols[date_cols %in% names(tables)]
    tables[,date_cols] <- lapply(tables[,date_cols], as.POSIXct)
  }
  tables
}

# library(dplyr)
# tables <- get_table_list(Language="nl", select=c("ShortTitle","Summary"))
