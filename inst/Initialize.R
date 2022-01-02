library(tidyverse)
library(globe4r)
library(sf)
airports<- read_csv("airports.dat.txt", col_names = c("Airport_id",
                                                      "Name",
                                                      "City",
                                                      "Country",
                                                      "IATA",
                                                      "ICAO",
                                                      "Lat",
                                                      "Long",
                                                      "Alt",
                                                      "Timezone",
                                                      "DST",
                                                      "Tz database",
                                                      "Type",
                                                      "Source"))
