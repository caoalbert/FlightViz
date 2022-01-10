df1<- data.frame(
  Dep_Airport = c("LAX", "LAX", "DFW"),
  Arvl_Airport = c("HNL", "PEK", "JFK"),
  Airline_cd = rep("AA", 3),
  Airline = rep("American Airlines", 3),
  Manufacture = rep("Airbus", 3),
  Model = rep("A320", 3),
  Subtype = rep("A321", 3),
  Alti = c(0.1,0.4,0.8)
)

df2<- df1 %>%
  left_join(airports, by = c("Dep_Airport" = "IATA")) %>%
  left_join(airports, by = c("Arvl_Airport" = "IATA"), suffix = c("_dep", "_arvl")) %>%
  select(Lat_dep, Long_dep, Lat_arvl, Long_arvl, Alti)





