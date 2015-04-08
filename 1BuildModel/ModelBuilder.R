#sum(str_count(a, "love"))
#install.packages("tm")
#install.packages("wordcloud")
#install.packages("RWeka")
#setwd("C:\\git\\capstone\\1BuildModel")


libs <- c("tm","ggplot2", "graph", "Rgraphviz", "wordcloud","twitteR","RWeka","dplyr", "data.table")
lapply(libs, require, character.only = TRUE)


rm(list = ls())



  source('buildNGram.R')
  twitter_en <-  "c:\\git\\capstone\\0ModelData\\en_US\\en_US.twitter.txt"
  blog_en <-  "c:\\git\\capstone\\0ModelData\\en_US\\en_US.blogs.txt"
  news_en <-  "c:\\git\\capstone\\0ModelData\\en_US\\en_US.news.txt"  
  
  begin <- Sys.time()
  df1 <- buildNGram(twitter_en, 1,1,1)
  df2 <- buildNGram(blog_en, 1,1,1)
  df3 <- buildNGram(news_en, 100000,1,1)
  end <- Sys.time()
  end-begin
  df_n1 <- rbind(df1,rbind(df2,df3))
  rownames(df_n1) <- NULL
  df_n1<-aggregate(df_n1[,c("freq")],by=list(df_n1$term),FUN=sum)
  names(df_n1) <- c("target", "freq")
  dt_n1 <-data.table(df_n1)
  
  
  begin <- Sys.time()
  df1 <- buildNGram(twitter_en, 1,2,2)
  df2 <- buildNGram(blog_en, 1,2,2)
  df3 <- buildNGram(news_en, 100000,2,2)
  end <- Sys.time()
  end-begin
  df_n2 <- rbind(df1,rbind(df2,df3))
  rownames(df_n2) <- NULL
  df_n2<-aggregate(df_n2[,c("freq")],by=list(df_n2$term),FUN=sum)
  names(df_n2) <- c("term", "freq")
  rexp <- "^(\\w+)\\s?(.*)$"
  df_n2<-data.frame(gram=sub(rexp,"\\1",df_n2$term), target=sub(rexp,"\\2",df_n2$term), freq = df_n2$freq)
  dt_n2 <-data.table(df_n2)
  
  
  begin <- Sys.time()
  df1 <- buildNGram(twitter_en, 1,3,3)
  df2 <- buildNGram(blog_en, 1,3,3)
  df3 <- buildNGram(news_en, 100000,3,3)
  end <- Sys.time()
  end-begin
  df_n3 <- rbind(df1,rbind(df2,df3))
  rownames(df_n3) <- NULL
  df_n3<-aggregate(df_n3[,c("freq")],by=list(df_n3$term),FUN=sum)
  names(df_n3) <- c("term", "freq")
  dt_n3 <-data.table(df_n3)
  dt_n3<-data.table(  gram = sub(" [^ ]*$", "", dt_n3$term), target = sub(".* ", "", dt_n3$term), freq=dt_n3$freq )

  begin <- Sys.time()
  df1 <- buildNGram(twitter_en, 1,4,4)
  df2 <- buildNGram(blog_en, 1,4,4)
  df3 <- buildNGram(news_en, 100000,4,4)
  end <- Sys.time()
  end-begin
  df_n4 <- rbind(df1,rbind(df2,df3))
  rownames(df_n4) <- NULL
  df_n4<-aggregate(df_n4[,c("freq")],by=list(df_n4$term),FUN=sum)
  names(df_n4) <- c("term", "freq")
  dt_n4 <-data.table(df_n4)
  dt_n4<-data.table(  gram = sub(" [^ ]*$", "", dt_n4$term), target = sub(".* ", "", dt_n4$term), freq=dt_n4$freq )
  
  



saveRDS(dt_n1,"N_dt_n1.RDS")
saveRDS(dt_n2,"N_dt_n2.RDS")
saveRDS(dt_n3[freq>1],"N_dt_n3.RDS")
saveRDS(dt_n4[freq>1],"N_dt_n4.RDS")



#dt_n1 <- readRDS("dt_n1.RDS")
#dt_n2 <- readRDS("dt_n2.RDS")
#dt_n3 <- readRDS("dt_n3.RDS")

#test  
#  suggestWord("",dt_n1,dt_n2,dt_n3)
#  suggestWord("the",dt_n1,dt_n2,dt_n3)
#  suggestWord("the fist",dt_n1,dt_n2,dt_n3)



  
  
#  dt_n1[][order(-freq)][1:3,]  
#  dt_n2[gram=="the"][order(-freq)][1:3,]
#  dt_n3[gram=="the first"][order(-freq)][1:3,]
  


