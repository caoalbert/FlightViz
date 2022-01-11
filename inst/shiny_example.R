
create_globe(df2) %>%
  globe_arcs(coords(start_lat = Lat_dep,
                    start_lon = Long_dep,
                    end_lat = Lat_arvl,
                    end_lon = Long_arvl)) %>%
  arcs_altitude_scale(0.2)


ui<- fluidPage(
  checkboxGroupInput("manufacturer", "Manufacturer", choices = levels(factor(df2$Manufacture)),
                                                     selected = levels(factor(df2$Manufacture))),
  sliderInput("year", "Year", value = c(min(df2$Year), max(df2$Year)),
                              min = min(df2$Year),
                              max = max(df2$Year)),
  globeOutput("globe")
)


server<- function(input, output){
  df<- reactive({
    df2 %>%
      filter(Manufacturer %in% input$manufacturer,
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
