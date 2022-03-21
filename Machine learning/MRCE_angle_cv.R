library(readr)
library(glasso)
library(MRCE)
library(tidyverse)
library(janitor)
library(cowplot)
library(FactoMineR)
library(here)
library(openxlsx)
library(Metrics)
library(writexl)

#reading data into R
charlies_format <- read_csv("~/Capstone project/charlies_format2.csv")
#View(charlies_format)

#removing sternx,sterny (origin), and the last 2 columns because mrce doesn't take in nan values and including the origin will probably overfir the model. 
new_df <-subset(charlies_format, select= -c(38,39,28,29))

#renaming the columns for better understanding 
#names(new_df) <- c("C1X","C1Y","C1A","C2X","C2Y","C2A","C3X","C3Y","C3A","C4X","C4Y","C4A","C5X","C5Y","C5A","C6X","C6Y","C6A","C7X","C7Y","C7A","CANTHUSX","CANTHUSY","TRAGUSX","TRAGUSY","C7SX","C7SY","ILIACX","ILIACY","NECK_LENX","NECK_LENY","HEADANGLE","NECKANGLE","TRUNK_A","NECK_B")

#Separating x and y(angles and center_pos_x and center_pos_y)
Angles   <- subset(new_df, select = c(3,6,9,12,15,18,21))
Center_X <- subset(new_df, select = c(1,4,7,10,13,16,19))
Center_Y <- subset(new_df, select = c(2,5,8,11,14,17,20))
X        <- subset(new_df, select = c(22,23,24,25,26,27,28,29,30,31,32,33,34,35))

#Splitting data into train(80) and test (20)
dt=sort(sample(nrow(new_df),nrow(new_df)*.75))
xtrain <- X[dt,]
xtest  <- X[-dt,]
angle_train <- Angles[dt,]
angle_test  <- Angles[-dt,]

#the next 2 functions is the second method we can use to  
#predict angles using "cross-validation" method and different values for lam1 and lam2
lam1.vec=rev(10^seq(from=-3, to=3, by=0.25))#we could use these to find best values for lam1 and lam2  
lam2.vec=rev(10^seq(from=-3, to=3, by=0.25))#using cross-validation method.
mrce_angle_cv<-mrce(X = data.matrix(xtrain), Y = data.matrix(angle_train),  
                    lam1.vec=lam1.vec, 
                    lam2.vec=lam2.vec,
                    method="cv",
                    cov.tol=1e-4, cov.maxit=1e3, omega=NULL, 
                    maxit.out=1e3, maxit.in=1e3, tol.out=1e-8, 
                    tol.in=1e-8, kfold=5, silent=FALSE, eps=1e-5, 
                    standardize=FALSE, permute=FALSE)
mrce_angle_fit<-mrce(X= xtrain, Y=angle_train,  
                     lam1=mrce_angle_cv$best.lam1, 
                     lam2=mrce_angle_cv$best.lam2, 
                     method="single", 
                     cov.tol=1e-4, cov.maxit=1e3, omega=NULL, 
                     maxit.out=1e3, maxit.in=1e3, tol.out=1e-8, 
                     tol.in=1e-8, kfold=5, silent=TRUE, eps=1e-5, 
                     standardize=FALSE, permute=FALSE)

mrce_angle_fit

#this function helps predict using test-dataset and our model
predict.mrce <- function(object, data) {
  do.call("rbind", apply(data, 1, function(x) {
    predout <- c(object$muhat + matrix(x, ncol = length(x)) %*% object$Bhat)
    predout <- data.frame(matrix(predout, ncol = length(predout)))
    names(predout) <- names(object$my)
    predout
  }))
}
 
#our actual predictions
angle_preds = predict.mrce(mrce_angle_fit,xtest)

#Now comparing errors. using rmse???
error <- rmse(data.matrix(angle_test),data.matrix(angle_preds))
error
mean_aver <- mae(data.matrix(angle_test), data.matrix(angle_preds))
mean_aver
write_xlsx(angle_preds,'C:\\Users\\einst\\Documents\\Capstone project\\MRCE\\angle_preds.xlsx')
