library(caret);
full <-  read.csv("pml-training.csv")

#By default, simple bootstrap resampling is used 
#other functions: createFolds, createMultiFolds, createresamples
inTrain <- createDataPartition(y=full$classe, p=0.75,list = FALSE)
train <- full[inTrain,]
test <- full[-inTrain,]

#str(train[, 1:10]) # see info about the 10 first variables


#A:1 B:2 C:3 D:4 E:5
#train[,"nClass"] <- as.numeric (train[,"classe"])
#raw_timestamp_part_1, raw_timestamp_part_2, user_name, also removed
train <- train[,c("classe", "num_window",    "pitch_arm",  "pitch_belt",	"pitch_dumbbell",	"pitch_forearm",	"roll_arm",	"roll_belt",	"roll_dumbbell",	"roll_forearm",	"total_accel_arm",	"total_accel_belt",	"total_accel_dumbbell",	"total_accel_forearm",	"yaw_arm",	"yaw_belt",	"yaw_dumbbell",	"yaw_forearm",	"accel_arm_x",	"accel_arm_y",	"accel_arm_z",	"accel_belt_x",	"accel_belt_y",	"accel_belt_z",	"accel_dumbbell_x",	"accel_dumbbell_y",	"accel_dumbbell_z",	"accel_forearm_x",	"accel_forearm_y",	"accel_forearm_z",	"gyros_arm_x",	"gyros_arm_y",	"gyros_arm_z",	"gyros_belt_x",	"gyros_belt_y",	"gyros_belt_z",	"gyros_dumbbell_x",	"gyros_dumbbell_y",	"gyros_dumbbell_z",	"gyros_forearm_x",	"gyros_forearm_y",	"gyros_forearm_z",	"magnet_arm_x",	"magnet_arm_y",	"magnet_arm_z",	"magnet_belt_x",	"magnet_belt_y",	"magnet_belt_z",	"magnet_dumbbell_x",	"magnet_dumbbell_y",	"magnet_dumbbell_z",	"magnet_forearm_x",	"magnet_forearm_y",	"magnet_forearm_z")]


#1) Tree - Bad Choice
#  install.packages("rattle")
#  library(rattle)
#  install.packages("rpart")
#  library(rpart.plot)
#  fitTree <- train(classe ~ .,method="rpart",data=train)
#  plot(fitTree$finalModel, uniform=TRUE, main="Classification Tree")
#  text(fitTree$finalModel, use.n=TRUE, all=TRUE, cex=.8)
#  fancyRpartPlot(fitTree$finalModel)
#  predTree <- predict(fitTree, newdata=test)
#  confusionMatrix(predTree, test$classe)




#1)random forests 
fitforest <- randomForest(classe ~ ., data=train, ntree=50)
predForest <-predict(fitforest, test)

cm <- confusionMatrix(predForest, test$classe)
cm$table



