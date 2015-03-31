#txt <- "c:\\git\\capstone\\final\\en_US_small\\"
#ovid <- Corpus(DirSource(txt),readerControl = list(reader = readPlain,  language = "en_US", load = TRUE))


#-----------------------------------------------------------------------------------
#https://apps.twitter.com
api_key <- "zjtQwiqHGXg8qaCXTIa4x7OFx"
api_secret <- "phHgOkCVM1a5fXUP36qpcCv9Rot4FxzHqF5qABvjq3r1FWcpft"
access_token <- "45141109-rIXQxFLqM3FAtV4XKzlswxOzKbBL9zhwjkSDmpTh0"
access_token_secret <- "JExDufSFXeURJUalHTtDt1Z2RNgAsXDqwStlkLnwfnQ4k"
setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)
t<-userTimeline('dmenin', n=500)
tweets.df <-twListToDF(t)
myCorpus <-Corpus(VectorSource(tweets.df$text))
#searchTwitter("iphone")
#http://www.slideshare.net/rdatamining/text-mining-with-r-an-analysis-of-twitter-data
#-----------------------------------------------------------------------------------


install.packages("tm")
install.packages("wordcloud")
library(tm)
library(ggplot2) 
library(graph)
library(Rgraphviz)
library(wordcloud) 
library(twitteR)

rm(list = ls())
con <- file("c:\\git\\capstone\\final\\en_US_small\\en_US.twitter_small.txt", "r") 
a<- readLines(con, 100) 
close(con)

df<-as.data.frame(a)
names(df) <- c("text")
myCorpus <- Corpus(VectorSource(df$text))

----
myCorpus <- tm_map(myCorpus, content_transformer(tolower))


myCorpus <- tm_map(myCorpus, removePunctuation) # remove punctuation 
myCorpus <- tm_map(myCorpus, removeNumbers) #remove numbers 
removeURL <- function(x) gsub("http[[:alnum:]]*", "", x) # remove URLs 
myCorpus <- tm_map(myCorpus, removeURL) 

  # add two extra stop words: available and via 
  #myStopwords <- c(stopwords("english"), "available", "via") 
  # remove r and big from stopwords 
  #myStopwords <- setdiff(myStopwords, c("r", "big")) 
  # remove stopwords from corpus 
  #myCorpus <- tm_map(myCorpus, removeWords, myStopwords) 10 / 35


myCorpus <- tm_map(myCorpus, PlainTextDocument) #http://stackoverflow.com/questions/24191728/documenttermmatrix-error-on-corpus-argument
tdm <- TermDocumentMatrix(myCorpus, control = list(wordLengths = c(1, Inf)))

#??
#idx<-dimnames(tdm)$Terms == "r"
#inspect(tdm[idx])


freq.terms <- findFreqTerms(tdm, lowfreq = 10)

term.freq <- rowSums(as.matrix(tdm)) 
term.freq <- subset(term.freq, term.freq >= 10) 
df <- data.frame(term = names(term.freq), freq = term.freq) #WORD COUNT


ggplot(df, aes(x = term, y = freq)) + geom_bar(stat = "identity") + xlab("Terms") + ylab("Count") + coord_flip() 

#which words are associated with "a"
findAssocs(tdm,"academia",0.2)
#Association Matrix
plot(tdm, term = freq.terms, corThreshold = 0.12, weighting = T)

#Word Cloud
m <- as.matrix(tdm) 
# calculate the frequency of words and sort it by frequency 
word.freq <- sort(rowSums(m), decreasing = T) 
wordcloud(words = names(word.freq), freq = word.freq, min.freq = 3, random.order = F) 

#remove sparse terms
tdm2 <- removeSparseTerms(tdm, sparse = 0.95)
m2 <- as.matrix(tdm2)

#cluster terms and dendogram
distMAtrix <- dist(scale(m2))
fit <- hclust (distMAtrix, method = "ward")
plot(fit)
rect.hclust(fit, k=6)


m3 <- t(m2) # transpose the matrix to cluster documents (tweets) 
set.seed(122) # set a fixed random seed 
k <- 6 # number of clusters 
kmeansResult <- kmeans(m3, k) 
round(kmeansResult$centers, digits = 3) # cluster centers 



for (i in 1:k) {
  cat(paste("cluster ", i, ": ", sep = "")) 
  s <- sort(kmeansResult$centers[i, ], decreasing = T) 
  cat(names(s)[1:5], "\n") 
  # print the tweets of every cluster
  #print(t[which(kmeansResult$cluster==i)]) 
}
