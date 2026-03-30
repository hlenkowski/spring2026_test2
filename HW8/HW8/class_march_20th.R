library(tidyverse)
library(nycflights13)

# load datasets
View(airlines)
View(airports)
View(planes)
View(weather)

# inspect to find out primary keys
flights |>
  count(tailnum) |> 
  filter(n > 1)
#count will look for repetition, if >1, then not primary key

airlines |>
  count(carrier) |>
  filter(n > 1)

airlines |>
  count(name) |>
  filter(n > 1)

planes |>
  count(tailnum)
  filter(n > 1)
  
weather |>
  count(time_hour, origin)
  
flights |> 
  count(time_hour, carrier, flight) |> 
  filter(n > 1)

flights2 <- flights |> 
  select(year, time_hour, origin, dest, tailnum, carrier)
View(flights2)

flights3 <- flights2 |>
  left_join(airlines)
View(flights3)


#friday mar20 
#discussing joining

#in metadata ID is the primary key (id only has one name per row)
#in dynamic data, ID is foreign key (repeated many times)

#example used: flights data set joined with airline data set (much smaller, adds info on airlines)
#metadata to help include full names of airlines:
flights3 <- flights2 |>
  left_join(airlines)
View(flights)

#"it's best not to repeat data" --> do not repeat data in the proper data set, only repeat as you pull it up for analysis


