set.seed(123)
library(caTools)
library(randomForest)
library(naivebayes)
library(rpart)
library(RColorBrewer)
library(rattle)
df = read.csv("credit.csv")
df$ID = NULL
df$default = df$default.payment.next.month
df$default.payment.next.month = NULL
str(df)
df[,c(2:4,6:11,24)]=lapply(df[,c(2:4,6:11,24)],factor) 


sample = sample.split(df,SplitRatio = 0.8) # splits the data in the ratio mentioned in SplitRatio. After splitting marks these rows as logical TRUE and the the remaining are marked as logical FALSE
train =subset(df,sample ==TRUE) # creates a training dataset named train1 with rows which are marked as TRUE
test=subset(df, sample==FALSE)

##### variable selection
#collinearity
corr = cor(df[,c(5,12:23)])
View(corr)
#collinearity for caregorical variable
cat = df[,c(2:4,6:11,24)]
name = names(cat)
v1 = c()
v2 = c()
p = c()
v = c()
for (i in 1:(dim(cat)[2]-1)){
  for (k in (i+1):dim(cat)[2]){
    tbl=table(cat[,i],cat[,k])
    chi = chisq.test(tbl)
    v1 = c(v1,name[i])
    v2 = c(v2,name[k])
    v = c(v,sqrt(chi$statistic / sum(tbl)))
    p = c(p,chi$p.value)
  }
}
corrcat = data.frame(cbind(v1,v2,p,v))
corrcat$p = NULL
# importance & random forest
rf = randomForest(default~.,data = train,importance = TRUE)
pred = predict(rf,newdata = test)
table = table(pred,test$default)
min_error_rate <- (table[1,1] + table[2,2])/sum(table)
imp = importance(rf, type=1)
# logistic
gf = glm(default~.,data = train,family = "binomial")
pred = predict(gf,newdata = test,type = "response")
pred = ifelse(pred>=0.5,1,0)
table = table(pred,test$default)
min_error_rate <- (table[1,1] + table[2,2])/sum(table)
#naive
model = naive_bayes(default~.,data = train,laplace =0.01)
pred = predict(model,newdata = test[1:23],type = "class")
table = table(pred,test$default)
min_error_rate <- (table[1,1] + table[2,2])/sum(table)
#cart
model = rpart(default~., data = train)
pred = data.frame(predict(model,newdata = test[1:23]))
pred$result = ifelse(pred$X1>=pred$X0,1,0)
table = table(pred$result,test$default)
min_error_rate <- (table[1,1] + table[2,2])/sum(table)

###model after variable selection
#randomforest model
train1 = train[,c("AGE","SEX","EDUCATION","MARRIAGE","LIMIT_BAL","PAY_0","BILL_AMT4","default")]
test1 = test[,c("AGE","SEX","EDUCATION","MARRIAGE","LIMIT_BAL","PAY_0","BILL_AMT4","default")]
# random forest
rf = randomForest(default~.,data = train1,importance = TRUE)
pred = predict(rf,newdata = test1)
table = table(pred,test1$default)
min_error_rate <- (table[1,1] + table[2,2])/sum(table)
# logistic
gf = glm(default~.,data = train1,family = "binomial")
step(gf)
pred = predict(gf,newdata = test1,type = "response")
pred = ifelse(pred>=0.5,1,0)
table = table(pred,test1$default)
min_error_rate <- (table[1,1] + table[2,2])/sum(table)
#naive
model = naive_bayes(default~.,data = train1,laplace =0.01)
pred = predict(model,newdata = test1[1:7],type = "class")
table = table(pred,test1$default)
min_error_rate <- (table[1,1] + table[2,2])/sum(table)
#cart
cmodel = rpart(default~., data = train1,cp = 0.01)
cpred = data.frame(predict(cmodel,newdata = test1[1:7]))
cpred$result = ifelse(cpred$X1>=cpred$X0,1,0)
table = table(cpred$result,test$default)
min_error_rate <- (table[1,1] + table[2,2])/sum(table)
fancyRpartPlot(cmodel) 

#stepwise logistic
gf1 = glm(default ~ SEX + EDUCATION + MARRIAGE + LIMIT_BAL + PAY_0 + BILL_AMT4,data = train1,family = "binomial")
pred = predict(gf1,newdata = test1,type = "response")
pred = ifelse(pred>=0.5,1,0)
table = table(pred,test1$default)
min_error_rate <- (table[1,1] + table[2,2])/sum(table)

#pruning for rpart
printcp(cmodel)
ptree<- prune(cmodel,cp= cmodel$cptable[which.min(cmodel$cptable[,"xerror"]),"CP"])
