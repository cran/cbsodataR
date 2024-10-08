% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cbs_add_unit_column.R
\name{cbs_add_unit_column}
\alias{cbs_add_unit_column}
\title{For each topic column add a unit column}
\usage{
cbs_add_unit_column(x, columns = colnames(x), ...)
}
\arguments{
\item{x}{\code{data.frame} retrieved using \code{\link[=cbs_get_data]{cbs_get_data()}}.}

\item{columns}{\code{character} with the names of the columns for which units will be added,
non-topic columns will be ignored.}

\item{...}{not used.}
}
\value{
the original data.frame \code{x} with extra unit
columns. (see description)
}
\description{
Adds extra unit columns to the dataset that was retrieved using \code{\link[=cbs_get_data]{cbs_get_data()}}.
}
\details{
The unit columns will be named \verb{<topic_column>_unit}, and are a \code{character}

By default all topic columns will be with a unit column. The name
of each unit column will be \verb{<topic_column>_unit}.
}
\examples{
if (interactive()) {
  x <- cbs_get_data( id      = "7196ENG"      # table id
                   , Periods = "2000MM03"     # March 2000
                   , CPI     = "000000"       # Category code for total 
                   , verbose = TRUE           # show the url that is used
                   )
  
  
  # adds two extra columns
  x_with_units <- 
    x |> 
    cbs_add_unit_column()
  
  x_with_units[,1:4]
}
}
\seealso{
Other data retrieval: 
\code{\link{cbs_add_date_column}()},
\code{\link{cbs_add_label_columns}()},
\code{\link{cbs_download_data}()},
\code{\link{cbs_extract_table_id}()},
\code{\link{cbs_get_data}()},
\code{\link{cbs_get_data_from_link}()}

Other meta data: 
\code{\link{cbs_add_date_column}()},
\code{\link{cbs_add_label_columns}()},
\code{\link{cbs_download_meta}()},
\code{\link{cbs_get_meta}()}
}
\concept{data retrieval}
\concept{meta data}
