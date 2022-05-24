rm(list=ls())
heart <- read.csv('/Users/jaylee/Desktop/Stat462/project/heart.csv')
heart

##1 EDA
str(heart)
ggpairs(heart)

##2 Fitting Model
##divide data in 2 parts
# 718 train data and 200 test data
set.seed(462)
pos <- sample(x = nrow(heart),size = 200,replace = F)
train <- heart[-pos,]
test <- heart[pos,]
glm.fit=glm(HeartDisease~., data = train,family=binomial(link = "logit"))
summary(glm.fit)


##Using stepwise
glm.fit2 <- step(object = glm.fit,scope = HeartDisease~.,direction="both")
summary(glm.fit2)

##3 remove non significant variable 
glm.fit3=glm(HeartDisease~Sex+ChestPainType+Cholesterol+FastingBS+ExerciseAngina+
               Oldpeak+ST_Slope,
             data=train,family=binomial(link = "logit"))
summary(glm.fit3)
lrtest(glm.fit,glm.fit3)

#Training
glm.probs.train <- predict(glm.fit3,newdata = train,type="response")
glm.pred.train=rep("0",nrow(train))
# if prob larger than 0.5 it is up(success)
glm.pred.train[glm.probs.train>.5]="1"
glm.pred.train <- factor(glm.pred.train)
confusionMatrix(data = glm.pred.train,
                reference = as.factor(train$HeartDisease),
                positive = "1")

#Test
glm.probs.test <- predict(glm.fit3,newdata = test,type="response")
glm.pred.test=rep("0",nrow(test))
# if prob larger than 0.5 it is up(success)
glm.pred.test[glm.probs.test>.5]="1"
glm.pred.test <- factor(glm.pred.test)
confusionMatrix(data = glm.pred.test,
                reference = as.factor(test$HeartDisease),
                positive = "1")
###Roc Curve
require(pROC)
test_roc <- roc(test$HeartDisease,glm.probs.test,
                plot = TRUE, 
                print.auc = TRUE)
###Final Analysis
###R^2
pR2(glm.fit3)
###Residuals
##Pearson
plot(residuals(glm.fit3,type = "pearson"),pch=19)
##Deviance
plot(residuals(glm.fit3,type = "deviance"),pch=19)
###Leverages
plot(hatvalues(model = glm.fit3),ylim = range(hatvalues(model = glm.fit3),
      3*sum(hatvalues(model = glm.fit3))/length(hatvalues(model = glm.fit3))))
abline(h = 3*sum(hatvalues(model = glm.fit3))/length(hatvalues(model = glm.fit3)),
       col="red",lwd=2)
###Studentized Residuals
plot(rstudent(model = glm.fit3),pch=19,ylim=range(rstudent(model = glm.fit3),3,-3))
abline(h = c(3,-3),col="red",lwd=2)
###Cook's Distance
plot(cooks.distance(model = glm.fit3),type="h",
     ylim=range(cooks.distance(model = glm.fit3),0.5,1))
abline(h = c(0.5,1),col="red",lwd=2)

# prediction 
predict(object = glm.fit3,newdata = data.frame(Sex=c('M'),ChestPainType=c('NAP'),
         Cholesterol = c(150),FastingBS=c(1),ExerciseAngina=c('Y'),Oldpeak=c(1.5),
         ST_Slope=c('Up')),interval = "confidence")

