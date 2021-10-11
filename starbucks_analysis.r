setwd("filepath")
getwd()

#reading in data
data1 = read.table("data.txt", header=T, sep="\t")
head(data1)
data1 <- as.data.frame((data1))
#shape of dataframe
dim(data1)


## to calculate the total number of missing values for each variable, use colSums
is.missing <- is.na(data1)*1 
colSums(is.missing) 
## missing values for the whole dataset
sum(is.missing)

##eliminate records with missing data, assign to new df
data2 <- na.omit(data1)
##count of remaining records
dim(data2)

##eliminate impossible values for all variables X1 to X22
colSums(data2[, 1:22] > 5 | data2[, 1:22] < 1)
#sum of all total impossible values
sum(colSums(data2[, 1:22] > 5 | data2[, 1:22] < 1))

##replace <1 values with 1 and >5 values with 5
keep <- data2[, 23:27]
data2[data2 < 1] <- 1  
data2[data2 > 5] <- 5
data2 <- data2[c(-23:-27)]
data2 <- cbind(data2, keep)
##count of impossible values and count of 1,2,3,4,5's
table(unlist(data2[,1:22]))

##satis100 replace <0 with 0 and >100 witb 100
data2$satis100[data2$satis100 < 0] <- 0
data2$satis100[data2$satis100 > 100] <- 100
##recommend replace <0 with 0 and >10 with 10
data2$recommend[data2$recommend < 0] <- 0
data2$recommend[data2$recommend > 10] <- 10
##count of the unique values in recommend
table(data2$recommend)
##avg of all variables
colMeans(data2)


setwd("filepath")
starbucks = as.data.frame(read_excel("starbucks_2.xlsx"))
library(readxl)
library(ggplot2)
library(hrbrthemes)
library(dplyr)
options(scipen=999)
head(starbucks)

##Chart I
ggplot(starbucks, aes(x=profits, y=Income, colour=recommend)) + 
  geom_point(size=0.5)

##Chart II
aggregated<-aggregate(starbucks$profits, by=list(Category=starbucks$satis100), FUN=mean)
ggplot(aggregated, aes(x=Category, y=x)) +
  geom_line()
aggregated

##dummy variables
starbucks2 <- starbucks
starbucks2$fail <- ifelse(starbucks2$satis100 < 20, 1, 0)
starbucks2$exceed <- ifelse(starbucks2$satis100 > 80, 1, 0)
attach(starbucks2)
starbucks2

#set working directory 
setwd("filepath")
options(scipen=999) #remove scientific notation

#load data
starbs <- read.table("Starbucks Data.txt", header=T, sep="\t")
head(starbs)

#load packages
library(miscTools)
library(cluster)
library(NbClust)
library(factoextra)

nrow(starbs) #train:5000; test:1121
K <- 5000
N <- nrow(starbs)

train <- as.data.frame(starbs[1:K,]) 
test <- as.data.frame(starbs[(K+1):N,])
head(train)
nrow(train)

test.X <- test[, 1:22]
test.y <- test[, 24]

train.reg1 <- lm(recommend ~ X1 + X2 + X3 + X4 + 
                  X5 + X6 + X7 + X8 + X9 + X10 + 
                  X11 + X12 + X13 + X14 + X15 + X16 + 
                  X17 + X18 + X19 + X20 + X21 + X22, data=train) 
summary(train.reg1)   

test.preds <- as.vector(predict(object=train.reg1, newdata=test.X)) #use model to predict on test set
test.preds

test.r2  <- rSquared(y=test.y, resid= (test.y - test.preds))
round(test.r2,4)

attach(train)
train_re <- cbind.data.frame(recommend, train[, 1:22]) #new dataframe with only X and y 

null.model <- lm(recommend ~ 1) # intercept only model for recommend
full.model <- lm(recommend ~ ., data = train_re) #model with all predictors

summary(full.model) 

#variable selection - forward selection 
forward.results <- step(object=null.model, direction="forward", scope=formula(full.model))

summary(forward.results)

#difference between original R^2 and new R^2
0.3547 - 0.3543
 
X <- starbs[, 1:22]
nrow(X)
ncol(X)
head(X)

# min, max clusters to test: 2,10 ; kmeans method, use euclidean distance
nb <- NbClust(X, distance="euclidean", min.nc=2, max.nc=10, method="kmeans")
fviz_nbclust(nb)

#centers: 2; iterations: 1000; nstart = 100
cluster.results = kmeans(x = X, centers = 2, iter.max=1000, nstart=100)

cluster.results
#frequency of customers for each segment
cluster.numbers = cluster.results$cluster
cluster.numbers

segment_sizes = table(cluster.numbers)
segment_sizes
 
#cluster centers
cluster.centers <- t(round(cluster.results$centers,2)) 
cluster.centers #higher segment is segment 1
satisfied_centers <- cluster.centers[,1]

satisfied_centers

X$cluster <- cluster.results$cluster #add segments to original dataset by segment ID
X$recommend <- starbs$recommend #add recommend variable to original dataset

most_satisfied <- X[X$cluster == 1, ] #seperate datasets for each segment
all_other <- X[X$cluster == 2, ]

most_satisfied <- within(most_satisfied, rm(cluster)) #remove segment ID
all_other <- within(all_other, rm(cluster))

most_satisfied_reg <- lm(recommend ~ ., data = most_satisfied) #seperate regression models
all_other_reg <- lm(recommend ~ ., data = all_other) 

most_satisfied_pred <- fitted.values(most_satisfied_reg) #fitted values for regression models
all_other_pred <- fitted.values(all_other_reg)

avg_most_satisfied_pred <- round(mean(most_satisfied_pred), 2) #average fitted values for recommend
avg_all_other_pred <- round(mean(all_other_pred), 2)


avg_most_satisfied_pred  
avg_all_other_pred
avg_most_satisfied_pred - avg_all_other_pred #difference of averages



#X1, X2, X7, X8, X10 ++1 


all_other$X1 <- ifelse(all_other$X1 < 5, all_other$X1 + 1, all_other$X1 + 0)
all_other$X2 <- ifelse(all_other$X2 < 5, all_other$X2 + 1, all_other$X2 + 0)
all_other$X7 <- ifelse(all_other$X7 < 5, all_other$X7 + 1, all_other$X7 + 0)
all_other$X8 <- ifelse(all_other$X8 < 5, all_other$X8 + 1, all_other$X8 + 0)
all_other$X10 <- ifelse(all_other$X10 < 5, all_other$X10 + 1, all_other$X10 + 0)


#use existing regression to recalculate recommend on "All Other" incremented data
all_other.X <- all_other[, 1:22]

new_pred <- as.vector(predict(object=all_other_reg, newdata = all_other.X)) #predicted values for recommend
avg_all_other_new_pred <- round(mean(new_pred), 2) #average of predicted values for recommend

avg_all_other_new_pred

avg_all_other_new_pred - avg_all_other_pred #difference between new and old average for all other segment








