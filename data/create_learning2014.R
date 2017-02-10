# Janne Kirjasniemi 3.2.2017 Viikon 2 scripti

library(dplyr)

learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep ="\t", header=TRUE)
str(learning2014)
dim(learning2014)
#Loaded the .txt file into a data file named learning2014, 
#which created a dataframe with 60 variables(columns) and 
#183 observations(rows).

deep_var <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22",
              "D30", "D06", "D15", "D23", "D31")
deep_col <- select(learning2014, one_of(deep_var))
deep_sum <- rowSums(deep_col) #Sum of variables without mean of observations
deep <- rowMeans(deep_col) #Mean of observations
#Added deep as a column to learning2014
learning2014$deep <- deep


#Same for stra and surf
stra_var <- c("ST01","ST09","ST17","ST25", "ST04","ST12",
              "ST20","ST28")
stra_col <- select(learning2014, one_of(stra_var))
stra_sum <- rowSums(stra_col)
stra <- rowMeans(stra_col)
learning2014$stra <- stra

surf_var <- c("SU02", "SU10", "SU18", "SU26", "SU05", "SU13",
              "SU21", "SU29", "SU08", "SU16", "SU24", "SU32")
surf_col <- select(learning2014, one_of(surf_var))
surf_sum <- rowSums(surf_col)
surf <- rowMeans(surf_col)

learning2014$surf <- surf

choose_var <- c("gender", "Age", "Attitude", "deep", "stra",
                "surf", "Points")
learning2014_c1 <- select(learning2014, one_of(choose_var))
glimpse(learning2014_c1)
learning2014_c2 <- filter(learning2014_c1, Points > 0)
glimpse(learning2014_c2)
write.csv2(learning2014_c2, file = "learning2014")
learning2014_2 <- read.csv2("learning2014")
str(learning2014_2)
