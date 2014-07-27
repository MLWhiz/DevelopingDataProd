library(shiny)
library(rpart)
library(ggplot2)
library(gbm)
library(lattice)
train<-read.csv("train.csv",na.strings=c("NA",""))
train[is.na(train$Age),]$Age<-mean(train[!is.na(train$Age),]$Age)
colums_count_of_missing_values <- colSums(is.na(train))
train_good<-train[,(colums_count_of_missing_values==0)]
train_good$Survived<-as.factor(train_good$Survived)
#train_good$Sex<-factor(ifelse(train_good$Sex=="male",1,0))
modelFit<- rpart(Survived~Sex+Pclass+Age+Fare,data=train_good)

shinyServer(function(input, output) {
  
  x<-reactive({
    input$goButton
    isolate(
      
      ifelse(
        (predict(modelFit,data.frame(Sex=input$Gender,Pclass=as.integer(input$Pclass),Age=as.numeric(input$Age),Fare=as.numeric(input$Fare))))[1][1]
        >(predict(modelFit,data.frame(Sex=input$Gender,Pclass=as.integer(input$Pclass),Age=as.numeric(input$Age),Fare=as.numeric(input$Fare))))[2][1],0,1
      
             
             )
            
            )})
  
  output$cod<-renderText({ ifelse(x()==1,"Congrats", ifelse(x()==0,"Alas!","entervalue"))})
  output$sod<-renderText({ ifelse(x()==1,"Survived", ifelse(x()==0,"Died","entervalue"))})
  output$plot<-renderPlot({          qplot(Age,Fare,data=subset(subset(train_good,Sex==input$Gender),Pclass== input$Pclass),color=Survived)          
                                     
                                     
                                     
                                     }         )
  
})

