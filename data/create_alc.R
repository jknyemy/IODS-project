#Janne Kirjasniemi 10.2.2017 Week three workshop
library(dplyr)

student_1 <- read.csv2("student-mat.csv")
student_2 <- read.csv2("student-por.csv")

join_by <- c("school", "sex", "age", "address", "famsize",
             "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason",
             "nursery", "internet")
#Combining the data sets accordin to join_by
alc <- inner_join(student_1, student_2, by = join_by)
glimpse(alc)
#Picking out the variables used to combine the data
alc_1 <- select(alc, one_of(join_by))
#Selecting the other columns as vector of strings ending 
#in .x (look at glimpse(alc) to see why)
notjoined_columns <- colnames(select(alc, ends_with(".x")))
#Edited out the .x suffix from the names
notjoined_columns <- gsub(".x", "", notjoined_columns)
#Printing to check
notjoined_columns

#I used the example from data camp pretty straightforwardly.

for(column_name in notjoined_columns) {
  # select two columns from 'alc' with the same original name
  two_columns <- select(alc, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc_1[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc_1[column_name] <- first_column
  }
}
#Checking to see it pans out
glimpse(alc_1)
#Making a new variable for alcohol use by taking the 
#mean of two variables
alc_use <- rowMeans(select(alc_1, one_of(c("Dalc", "Walc"))))
alc_1$alc_use <- alc_use
#A new variable of alcohol use when higher than 2
high_use <- alc_1$alc_use > 2
head(high_use)
alc_1$high_use <- high_use
# A final check
glimpse(alc_1)
write.csv2(alc_1, "student_alc")

sukup <- table(alc_1$sex, alc_1$high_use)
prop.table(sukup)
sukup

