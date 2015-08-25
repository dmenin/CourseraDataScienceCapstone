#install.packages("tm")
#install.packages("wordcloud")
#install.packages("RWeka")
#setwd("C:\\git\\capstone\\1BuildModel")

rm(list = ls())

libs <- c("tm","ggplot2", "graph", "Rgraphviz", "wordcloud","twitteR","RWeka","dplyr", "data.table")
lapply(libs, require, character.only = TRUE)



source('buildNGram.R')
source('ModelBuilder.R')


n1 <- ModelBuilder(100000, 1, 1)
n2 <- ModelBuilder(100000, 2, 2)
n3 <- ModelBuilder(100000, 3, 3)
n4 <- ModelBuilder(100000, 4, 4)

saveRDS(n1[freq>1],"n1.RDS")
saveRDS(n2[freq>1],"n2.RDS")
saveRDS(n3[freq>1],"n3.RDS")
saveRDS(n4[freq>1],"n4.RDS")