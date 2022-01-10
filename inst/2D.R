world<- map_data("world")
ggplot(df2)+
  geom_map(data = world, map = world, aes(long, lat, map_id = region), color = "white", fill = "lightgray")+
  geom_curve_interactive(aes(x = Long_dep, y = Lat_dep, xend = Long_arvl, yend = Lat_arvl))
