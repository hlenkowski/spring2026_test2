library(tidyverse)
library(babynames)

valid_levels <- c("beginner", "intermediate", "advanced")

students <- read_csv("../data/student_info.csv", show_col_types = FALSE) |>
  rename(
    name               = `Name`,
    year_of_study      = `year of study`,
    major              = `major`,
    experience_level   = `level of programming experience (e.g. beginner, intermediate, advanced)`,
    prog_languages     = `programming languages (R, Python, Julia, etc.)`,
    research_interests = `research / academic interests`,
    group              = `Group number / name`,
    attended_jan30     = `attendance jan 30th`
  )

##############################
# what is the distribution of research interests in the whole class?
##############################

students_interests <- students |>
  select(name, research_interests) |>
  separate_longer_delim(research_interests, regex("[;/]"))

students_interests |> ggplot(aes(research_interests)) |>
  ggplot(aes(x=research_interests)) +
  geom_bar()

#all at once:

students |>
  select(name, research_interests) |>
  separate_longer_delim(research_interests, regex("\\s*[;/]\\s*")) |>
  mutate(
    research_interests = str_to_lower(research_interests))|>
  ggplot(aes(x=fct_infreq(research_interests))) +
  geom_bar() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))
#)

##############################
# what is the average level of programming experience in each group?
##############################

valid_levels <- c("beginner", "intermediate", "advanced")

students |>
  mutate(
    experience_level = str_to_lower(str_trim(experience_level)),
    experience_level = case_when(
      ~ "beginner",
      ~ "intermediate",
      .default = experience_level
    ),
    experience_level = factor(experience_level, levels = valid_levels, ordered = TRUE),
  ) |>
  group_by(group) |>
  ggplot(aes(x=group,y=as.numeric(experience_level))) + 
  geom_boxplot()

#OR: newer approach  edited in class

valid_levels <- c("beginner", "intermediate", "advanced")

students |>
  mutate(
    experience_level = str_to_lower(str_trim(experience_level)),
    experience_level = case_when(
      str_detect(experience_level, "^mid-beginner") ~"beginner",
      .default = experience_level
    ),
    experience_level = factor(experience_level, levels = valid_levels, ordered = TRUE),
  ) |>
  group_by(group) |>
  ggplot(aes(x=group, y=as.numeric(experience_level))) +
  geom_boxplot()
      

##############################
# How many people in each group know R, python, etc.?
##############################

students_languages <- students |>
  select(name, group, prog_languages) |>
  separate_longer_delim(prog_languages, regex("\\s*[,]\\s*")) |>
  mutate(cpp = str_detect(prog_languages, "C\\+\\")) |>
  
  group_by(group) |>
  ggplot(aes(x=prog_languages))+
  geom_point(aes(color = group))




##############################
# Do undergraduates have more or less programming experience than graduate students?
##############################

