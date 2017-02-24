#create_human
#Janne Kirjasniemi
#Manipulation of the human dataset from the source: 
#http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt

library(dplyr)
library(MASS)
library(stringr)

human <- read.table("C:/Users/Janne/Documents/GitHub/IODS-project/data/human.txt", sep  =",", header = T)
str(human)
#Removing the commas from GNI and changing it into a numeric variable
#And then changing the GNI variable from a new human_dataset to the
#numeric one.
GNI_num <- str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric()
str(GNI_num)
human_ <- human
human_$GNI <- GNI_num
str(human_$GNI)

#Discarding irrelevant variables by saving the 
#relevant ones in a new dataset

keep_columns <- c( "Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human_set1 <- dplyr::select(human_, one_of(keep_columns))

#Removing the rows with NA values into a new dataset.

comp <- complete.cases(human_set1)
human_set1$comp <- comp
human_set2 <- filter(human_set1, comp==TRUE)
human_set2
human_set2 <- select(human_set2, -comp)

#Removing observations relating to regions
last <- nrow(human_set2) - 7
human_set2 <- human_set2[1:last,]

#Changing rownames to countrynames and removing the country name 
# column.

rownames(human_set2) <- human_set2$Country
head(human_set2)
human_set2 <- select(human_set2, -Country)

write.table(human_set2, file="human")
