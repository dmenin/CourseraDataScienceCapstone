v<-c("en_US.blogs.txt","en_US.news.txt", "en_US.twitter.txt")
v1<-c("899289","1010242","2360148")
v2<-c("205","200","163")

v3 <- c("37272578","34309642", "30341028")
basicInfo<-data.frame(FileName=v,nRows=v1,FileSize=v2, nWords = v3)


saveRDS(basicInfo,"basicInfo.RDS")


wc *.txt 
899288   37272578 210160014 en_US.blogs.txt
1010242  34309642 205811889 en_US.news.txt
2360148  30341028 167105338 en_US.twitter.txt
linhas - palavras - caracteres