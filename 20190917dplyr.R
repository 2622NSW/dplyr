setwd("~/Documents")
# https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html
library(tidyverse)
df <- read_csv("RefereesWWC.csv")
dim(df)
tibble(df)
# https://tibble.tidyverse.org/
# https://r4ds.had.co.nz/tibbles.html
# Tibble and data frame interchangeable terms.
# Object names must start with a letter.
# Example of a filter in use:
p1 <- ggplot(data = df) + 
  geom_point(mapping = aes(x = ID, y = ATM))
filter(df, ATM > 50) 
filter(df, GTM > 92) 
p1
# Names of Vriables
# int: integers.
# dbl: doubles, or real numbers.
# chr: character vectors, or strings.
# dttm: date-times (a date + a time).
# lgl: logical, vectors that contain only TRUE or FALSE.
# fctr factors to represent categorical variables with fixed possible values.
# date: dates.

# Five key dplyr functions
# (filter ()): pick observations by their values.
# (arrange ()): reorder the rows.
# (select()): pick variables by their names.
# (mutate()): create new variables with functions of existing variables.
# (summarise()): collapse many values down to a single summary.

# These can all be used in conjunction with group_by().

# All verbs work similarly:
# 1. The first argument is a data frame.
# 2. The subsequent arguments describe what to do with the data frame, using the variable names (without quotes).
# 3. The result is a new data frame.

# filter
filter(df, ID <5, ATM <55)
# Create data frame
df1 <- filter(df, ID <5, ATM <55)
# Parenthese give description and a tibble.
(df1 <- filter(df, ID <5, ATM <55))
# Using Filter to find data. Include df reference.
filter(df, ATM < 59 | GTM > 97)

# arrange. Include df reference.
arrange(df, Referee, Goals, Fouls)
df2 <- arrange(df, Referee, Goals, Fouls)
# descending order
arrange(df, desc(Fouls))

# Select. Include df reference.
select(df, ATM, GTM, Fouls)
# Select inclusive columns
select(df, Temperature:Humidity)
# Exclude colums
select(df, -(YC:Humidity))

# mutate
mutate(df,
       Difference = GTM - ATM
)
df3 <- mutate(df,
              Difference = GTM - ATM
)
df3
# transmute to keep the new variables
transmute(df,
          Difference = GTM - ATM
)
# With mutate () the function must be vectorised.
# Ranking
min_rank(df$Fouls)
row_number(df$Fouls)
min_rank(desc(df$Fouls))

# Summarise
Add <- group_by(df, ATM + DwellM)
summarise(Add, Total = mean(Add, na.rm = TRUE))
# Combined graphic
p2 <- ggplot(df, aes(x = ATM, y = DwellM)) +
  geom_point(aes(colour=ATM)) +
  geom_smooth(method = glm) +
  labs(title = "Referees at the Women's World Cup 2019", 
       subtitle = "Ball in Play and Ball Not In Play", x= "Ball in Play: Minutes", 
       y="Ball Not In Play: Minutes") +
  labs(caption="Actual Time Played in Relation to Ball Not In Play") +
  labs(colour = "Ball in Play\nMinutes") +
  theme_minimal () +
  theme(plot.title = element_text(color="black", size=16, face="bold"),
        plot.subtitle = element_text(color="blue", size=14, face="bold"),
        axis.title = element_text(color="black", size=12, face="bold"),
        axis.text = element_text(color="black", size=10))
p2  




