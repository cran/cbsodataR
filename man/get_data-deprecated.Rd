% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get-data.R
\name{get_data-deprecated}
\alias{get_data-deprecated}
\alias{get_data}
\title{Get data from Statistics Netherlands (CBS)}
\usage{
get_data(
  id,
  ...,
  recode = TRUE,
  use_column_title = recode,
  dir = tempdir(),
  base_url = getOption("cbsodataR.base_url", BASE_URL)
)
}
\arguments{
\item{id}{Identifier of table, can be found in \code{\link[=cbs_get_datasets]{cbs_get_datasets()}}}

\item{...}{optional filter statements, see details.}

\item{recode}{recodes all codes in the code columns with their \code{Title} as found
in the metadata}

\item{use_column_title}{not used.}

\item{dir}{Directory where the table should be downloaded. Defaults to temporary
directory}

\item{base_url}{optionally specify a different server. Useful for
third party data services implementing the same protocol.}
}
\value{
\code{data.frame} with the requested data. Note that a csv copy of
the data is stored in \code{dir}.
}
\description{
This method is deprecated in favor of \code{\link[=cbs_get_data]{cbs_get_data()}}
}
\details{
To reduce the download time, optionaly the data can be filtered on category values:
for large tables (> 100k records) this is a wise thing to do.

The filter is specified with (see examples below):
\itemize{
\item \verb{<column_name> = <values>} in which \verb{<values>} is a character vector.
Rows with values that are not part of the character vector are not returned.
\strong{Note that the values have to be values from the \verb{$Key} column of the corresponding meta data. These may contain trailing spaces...}
\item \verb{<column_name> = has_substring(x)} in which x is a character vector. Rows with values that
do not have a substring that is in x are not returned. Useful substrings are
"JJ", "KW", "MM" for Periods (years, quarters, months) and "PV", "CR" and "GM"
for Regions (provinces, corops, municipalities).
\item \verb{<column_name> = eq(<values>) | has_substring(x)}, which combines the two statements above.
}

By default the columns will be converted to their type (\code{typed=TRUE}).
CBS uses multiple types of missing (unknown, surpressed, not measured, missing): users
wanting all these nuances can use \code{typed=FALSE} which results in character columns.
}
\note{
All data are downloaded using \code{\link[=cbs_download_table]{cbs_download_table()}}
}
\section{Copyright use}{

The content of CBS opendata is subject to Creative Commons Attribution (CC BY 4.0).
This means that the re-use of the content is permitted, provided Statistics
Netherlands is cited as the source. For more information see:
\url{https://www.cbs.nl/en-gb/about-us/website/copyright}
}

\examples{
\dontrun{
cbs_get_data( id      = "7196ENG"      # table id
            , Periods = "2000MM03"     # March 2000
            , CPI     = "000000"       # Category code for total 
            )

# useful substrings:
## Periods: "JJ": years, "KW": quarters, "MM", months
## Regions: "NL", "PV": provinces, "GM": municipalities
  
cbs_get_data( id      = "7196ENG"      # table id
            , Periods = has_substring("JJ")     # all years
            , CPI     = "000000"       # Category code for total 
            )

cbs_get_data( id      = "7196ENG"      # table id
            , Periods = c("2000MM03","2001MM12")     # March 2000 and Dec 2001
            , CPI     = "000000"       # Category code for total 
            )

# combine either this
cbs_get_data( id      = "7196ENG"      # table id
            , Periods = has_substring("JJ") | "2000MM01" # all years and Jan 2001
            , CPI     = "000000"       # Category code for total 
            )

# or this: note the "eq" function
cbs_get_data( id      = "7196ENG"      # table id
            , Periods = eq("2000MM01") | has_substring("JJ") # Jan 2000 and all years
            , CPI     = "000000"       # Category code for total 
            )
}
}
\seealso{
\code{\link[=cbs_get_meta]{cbs_get_meta()}}, \code{\link[=cbs_download_data]{cbs_download_data()}}

Other data retrieval: 
\code{\link{cbs_add_date_column}()},
\code{\link{cbs_add_label_columns}()},
\code{\link{cbs_add_unit_column}()},
\code{\link{cbs_download_data}()},
\code{\link{cbs_extract_table_id}()},
\code{\link{cbs_get_data_from_link}()}

Other query: 
\code{\link{eq}()},
\code{\link{has_substring}()}
}
