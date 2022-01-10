
create_globe(df2) %>%
  globe_arcs(coords(start_lat = Lat_dep,
                    start_lon = Long_dep,
                    end_lat = Lat_arvl,
                    end_lon = Long_arvl)) %>%
  arcs_altitude_scale(0.2)


ui<- fluidPage(
  selectInput("manufacture", "Manufacture", choices = levels(factor(df2$Manufacture))),
  globeOutput("globe")
)


server<- function(input, output){
  df<- reactive({
    df2 %>% filter(Manufacture == input$manufacture)
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
