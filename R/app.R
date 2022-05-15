


library(tidyverse)
library(globe4r)
library(sf)
library(shiny)
library(lubridate)
library(ggiraph)
library(readxl)
data(airports)


ui<- fluidPage(
  fileInput("flight_history", "Choose an Excel Spreadsheet",
            accept = c(".xsls")),
  tags$hr(),
  checkboxGroupInput("manufacturer", "Manufacturer", choices = levels(factor(df2$Manufacture)),
                                                     selected = levels(factor(df2$Manufacture))),
  sliderInput("year", "Year", value = c(min(df2$Year), max(df2$Year)),
                              min = min(df2$Year),
                              max = max(df2$Year)),
  globeOutput("globe")
)


server<- function(input, output){

  df2<- reactive({
    req(input$flight_history)
    upload<- read_xlsx(input$flight_history$datapath)
    df1 %>%
      left_join(airports, by = c("Dep_Airport" = "IATA")) %>%
      left_join(airports, by = c("Arvl_Airport" = "IATA"), suffix = c("_dep", "_arvl")) %>%
      mutate(Date = as.Date(Date, "%m/%d/%Y")) %>%
      mutate(Year = year(Date)) %>%
      select(Lat_dep, Long_dep, Lat_arvl, Long_arvl, Alti, colnames(df1), Year) %>%
      dplyr::filter(Manufacturer %in% input$manufacturer,
                    Year %in% seq(input$year[1], input$year[2], 1))
  })







  output$globe<- renderGlobe({
    create_globe(df()) %>%
      globe_arcs(coords(start_lat = Lat_dep,
                        start_lon = Long_dep,
                        end_lat = Lat_arvl,
                        end_lon = Long_arvl)) %>%
      arcs_altitude_scale(0.2)
  })
}

shinyApp(ui, server)

# Calculates the optimal height
