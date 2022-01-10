df1<- data.frame(
  Dep_Airport = c("LAX", "LAX", "DFW", "CVG"),
  Arvl_Airport = c("HNL", "PEK", "JFK", "SFO"),
  Airline_cd = rep("AA", 4),
  Airline = rep("American Airlines", 4),
  Manufacture = c(rep("Airbus", 3), "Boeing"),
  Model = c(rep("A320", 3), "B737"),
  Subtype = c(rep("A321", 3), "B737-8"),
  Alti = c(0.1,0.4,0.8,0.2)
)

df2<- df1 %>%
  left_join(airports, by = c("Dep_Airport" = "IATA")) %>%
  left_join(airports, by = c("Arvl_Airport" = "IATA"), suffix = c("_dep", "_arvl")) %>%
  select(Lat_dep, Long_dep, Lat_arvl, Long_arvl, Alti, Manufacture)





