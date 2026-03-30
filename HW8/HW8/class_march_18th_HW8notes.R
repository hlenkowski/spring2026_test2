library(tidyverse)
library(nycflights13)
?gss_cat

# logical vectors - conditonal transformations
x <- c(-3:3, NA)
if_else(x > 0, "+ve", "-ve")
if_else(x > 0, "+ve", "-ve", "???")
#in past we used parse_number() to replace non number with NA
#now we use ???
#not sure exactly what it does

# numbers
1:10 %/% 3
1:10 %% 3

# an example of %/% in a practical workflow
flights |> 
  group_by(hour = sched_dep_time %/% 100) |> 
  summarize(prop_cancelled = mean(is.na(dep_time)), n = n()) |> 
  filter(hour > 1) |> 
  ggplot(aes(x = hour, y = prop_cancelled)) +
  geom_line(color = "grey50") + 
  geom_point(aes(size = n))

# Factors
x1 <- c("Dec", "Apr", "Jan", "Mar")
x2 <- c("Dec", "Apr", "Jam", "Mar")

sort(x1)

month_levels <- c(
  "Jan", "Feb", "Mar", "Apr", "May", "Jun",
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
)

#notes on fct --> look this up idk what it is I got distracted
y1 <- factor(x1, levels = month_levels)
y1

sort(y1)

y2 <- fct(x2, levels = month_levels)
#this gives an error: "all values of x must appear in levels or na" --> missing level: Jan


csv <- "
month,value
Jan,12
Feb,56
Mar,12"

df <- read_csv(csv)
df
df <- read_csv(csv, col_types = cols(month = col_factor(month_levels)))

# dates and times

csv <- "
  date
  01/02/15
"

# glimpse(date_of) will show you the data set (rows and columns and their values) that 
  #are in date format and date and time format


#reformatting
read_csv(csv, col_types = cols(date = col_date("%m/%d/%y")))
read_csv(csv, col_types = cols(date = col_date("%d/%m/%y")))
read_csv(csv, col_types = cols(date = col_date("%y/%m/%d")))
#stay consistent with the order! can rearrange however 

# pulling out components
datetime <- ymd_hms("2026-07-08 12:34:56")

year(datetime)
month(datetime)
mday(datetime)

yday(datetime)
wday(datetime)

#fct{forcats} (look up what this does I missed it)



#friday mar20 
#discussing joining

#in metadata ID is the primary key (id only has one name per row)
#in dynamic data, ID is foreign key (repeated many times)

#example used: flights data set joined with airline data set (much smaller, adds info on airlines)
#metadata to help include full names of airlines:
flights3 <- flights2 |>
  left_join(airlines)
View(flights)

