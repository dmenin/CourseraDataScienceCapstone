library(foreach)


x <- matrix(runif(500), 100)
y <- gl(2, 50)
library(randomForest)



#Let's do that, but first, we'll do the work sequentially:
rf <- foreach(ntree=rep(250, 4), .combine=combine) %do%
      randomForest(x, y, ntree=ntree)
rf



options(cores=2)
?registerDoParallel
(2)

addToModel <- function(gram_dt, modelLM) {
  

  
  
  
  loginfo(paste("Total de Linhas",nrow(gram_dt))  , logger="modellogger.module")
  
  modelLM <- foreach (i = 1:nrow(gram_dt), .combine=rbind) %dopar% {
    
    if((i %% 1000) == 0) {
      loginfo(paste("Processando linha",i)  , logger="modellogger.module")
    }
    
    lastWord   <- word(gram_dt[i,1,with=F]$Terms,-1)
    startTerm <- gsub("\\s*\\w*$", "", gram_dt[i,1,with=F]$Terms)
    frequency <- gram_dt[i,2,with=F]$Freq
    data.table(term = startTerm, nextWords = data.table(word=lastWord, freq=frequency))
  }