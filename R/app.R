library(tidyverse)
library(globe4r)
library(sf)
library(shiny)
library(lubridate)
library(ggiraph)
library(readxl)
load("../data/airports.rda")


ui<- fluidPage(
  fileInput("flight_history", "Choose an Excel Spreadsheet",
            accept = c(".xsls")),
  tags$hr(),
  checkboxGroupInput("manufacturer", "Manufacturer", choices = NULL,
                                                     selected = NULL),
  sliderInput("year", "Year", value = c(1980, 2022),
                              min = 1980,
                              max = 2022),
  globeOutput("globe")
)


server<- function(input, output){

  flight_history<- reactive({
    req(input$flight_history)
    upload<- read_xlsx(input$flight_history$datapath)
    upload %>%
      left_join(airports, by = c("Dep_Airport" = "IATA")) %>%
      left_join(airports, by = c("Arvl_Airport" = "IATA"), suffix = c("_dep", "_arvl")) %>%
      mutate(Date = as.Date(Date, "%m/%d/%Y")) %>%
      mutate(Year = year(Date)) %>%
      select(Lat_dep, Long_dep, Lat_arvl, Long_arvl, Alti, colnames(upload), Year, Manufacturer)
  })
  
  observeEvent(input$flight_history, {
    updateSliderInput(inputId = "year", 
                      min = min(flight_history()$Year),
                      max = max(flight_history()$Year, 
                      value = max(flight_history()$Year),
                      step = 1))
    updateCheckboxGroupInput(inputId = "manufacturer", selected = levels(factor(flight_history()$Manufacturer)), 
                             choices = levels(factor(flight_history()$Manufacturer)))
  })


  filtered_flight_history<- reactive( {
    flight_history() %>% 
    dplyr::filter(Manufacturer %in% input$manufacturer,
                Year %in% seq(input$year[1], input$year[2], 1))})




  output$globe<- renderGlobe({
    req(input$flight_history)
    create_globe(filtered_flight_history()) %>%
      globe_arcs(coords(start_lat = Lat_dep,
                        start_lon = Long_dep,
                        end_lat = Lat_arvl,
                        end_lon = Long_arvl)) %>%
      arcs_altitude_scale(0.2)
  })
}

shinyApp(ui, server)

# Calculates the optimal height
