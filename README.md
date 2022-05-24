# Cardiovascular-disease-predict

Introduction

Cardiovascular disease is number one cause of death for people. Heart failure is usually caused by Cardiovascular disease. 
I have found a heart data set from kaggle. Goal of this project is to predict heart failure using the data which has 918 rows and 12 variables.

Model Description

I fitted a Generalized linear model to predict the heart disease. I splitted the whole data into 718 train data and 200 test data.
This summary of fitted model shows there are some variables with p - value higher than 0.05.
I used stepwise function to remove non significant variable. The stepwise function shows when the model assign sex, chestPainType, Cholesterol, 
FastingBS, ExerciseAngina, Oldpeak and ST_Slope as prediction values.
The model has lowest AIC value with thsese variables.
I tested the lrtest with the first model and the new model. It shows the p-value 0.2113.
I trained the model using the train data set and the new glm model. If the probability is larger than 0.5, it is written as 1. 
I made confusion matrix to get Accuracy, sensitivity, and specificity values. The accuracy is 0.87, sensitivity is 0.89, and specifity is 0.83.
I also did it to my test data set. Accuracy, sensitivity and specificity are decreased a little but it has high scores.
I made a roc curve .The area under the curve(AUC) shows 0.929. This model can have both high specificity and sensitivity. 
i can say this model is a good model which has high AUC score.
I made R^2 of the model. McFadden value is 0.539 so the model explains 53.9% of the situation.
I plotted using peason method. The values are overally evenly distributed around the 0 line.
I plotted the residuals using deviance method. The values are also around the 0 line.
I plotted the leverage using hatvalue function. It shows some of outliers in this function.
I plotted the studentized residuals and there seems no outliers in this funciton.
I plottd the cook’s distance and there seems no outliers in this funciton.
I predicted a man who has NAP chestpanitype,150 cholesterol value, has Fasting BS, has exerciseangina, has 1.5 oldpeak and st slope is up. 
The probability of this man has heart disease is 0.470.

Conclusion

To sum up, i made a glm function to predict whether a man or woman has heart disease or not using 7 prediction values. 
The model shows good scores on accuracy,specificity, sensitivity and auc.
Moreover, i can actually predict the person’s heart disease probability.
