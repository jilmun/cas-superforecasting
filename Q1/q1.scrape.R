require(dplyr)
require(rvest)

options(stringsAsFactors = FALSE)
setwd("~/cas-superforecasting/Q1")

url_base <- "http://securities.stanford.edu/list-mode.html?page="
tbl.clactions <- data.frame(
  "Filing.Name" = character(0),
  "Filing.Date" = character(0),
  "District.Court" = character(0),
  "Exchange" = character(0),
  "Ticker" = character(0) )

for (i in 1:ceiling(4171/20)) {  # total filings: 4171, listed 20 per page
  url <- paste0(url_base, i)
  tbl.page <- url %>%
    read_html() %>%
    html_nodes(xpath='//*[@id="records"]/table') %>%
    html_table()
  names(tbl.page[[1]]) <- names(tbl.clactions)
  tbl.clactions <- bind_rows(tbl.clactions, tbl.page[[1]])
}

write.csv(tbl.clactions, file="class_actions.csv", row.names=FALSE)
