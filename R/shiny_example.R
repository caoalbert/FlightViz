
create_globe(df2) %>%
  globe_arcs(coords(start_lat = Lat_dep,
                    start_lon = Long_dep,
                    end_lat = Lat_arvl,
                    end_lon = Long_arvl)) %>%
  arcs_altitude_scale(0.2)


ui<- fluidPage(
  actionButton("add", "add arcs"),
  globeOutput("globe")
)
server<- function(input, output){
  output$globe<- renderGlobe({
    create_globe(df2) %>%
      globe_arcs(coords(start_lat = Lat_dep,
                        start_lon = Long_dep,
                        end_lat = Lat_arvl,
                        end_lon = Long_arvl)) %>%
      arcs_altitude_scale(0.2)}
  )


}

shinyApp(ui, server)

# Calculates the optimal height
