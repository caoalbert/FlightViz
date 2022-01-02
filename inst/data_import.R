library(tidyverse)
v1<- c("LAX", "HNL", "AA", "American Airlines", "A320", "A321", "A321NEO")





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
                                                      "Source"
                                                      ))



v1<- matrix(v1, nrow = 1)
df2<- as.data.frame(v1)
colnames(df2)<- c("Dep_Airport", "Arvl_Airport", "Airline_cd", "Airline", "Acf_fam", "Acf_model", "Acf_type")
df2<- df2 %>% 
  left_join(airports, by = c("Dep_Airport" = "IATA")) %>%
  left_join(airports, by = c("Arvl_Airport" = "IATA"), suffix = c("_dep", "_arvl"))

world<- map_data("world")
ggplot(df2)+
  geom_map(data = world, map = world, aes(long, lat, map_id = region), color = "white", fill = "lightgray")+
  geom_curve_interactive(aes(x = Long_dep, y = Lat_dep, xend = Long_arvl, yend = Lat_arvl))







create_globe() %>% 
  globe_paths(data = df4)

df3<- df2 %>% select(Lat_dep, Long_dep, Lat_arvl, Long_arvl)

loc<- c(-118.408, 33.94, -157.9242, 21.32)

x<- matrix(loc, byrow = T, nrow=2)

s1<- st_linestring(x)
s2<- st_sfc(s1)
df4<- st_sf(st_sfc(s1))

