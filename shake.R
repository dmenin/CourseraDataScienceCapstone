#http://www.r-bloggers.com/text-mining-the-complete-works-of-william-shakespeare/
rm(list = ls())

TEXTFILE = "pg100.txt"
if (!file.exists(TEXTFILE)) {
download.file("http://www.gutenberg.org/cache/epub/100/pg100.txt", destfile = TEXTFILE)
}
shakespeare = readLines(TEXTFILE)
length(shakespeare)

shakespeare = shakespeare[-(1:173)]
shakespeare = shakespeare[-(124195:length(shakespeare))]

shakespeare = paste(shakespeare, collapse = " ")
nchar(shakespeare)

shakespeare = strsplit(shakespeare, "<<[^>]*>>")[[1]]


(dramatis.personae <- grep("Dramatis Personae", shakespeare, ignore.case = TRUE))
shakespeare = shakespeare[-dramatis.personae]


library(tm)
doc.vec <- VectorSource(shakespeare)
doc.corpus <- Corpus(doc.vec)
summary(doc.corpus)

doc.corpus <- tm_map(doc.corpus, tolower)
doc.corpus <- tm_map(doc.corpus, removePunctuation)
doc.corpus <- tm_map(doc.corpus, removeNumbers)
doc.corpus <- tm_map(doc.corpus, removeWords, stopwords("english"))


#Stemming: removes affixes from words (run", "runs" and "running" all become "run")
install.packages("SnowballC")
library(SnowballC)
doc.corpus <- tm_map(doc.corpus, stemDocument)

doc.corpus  <- tm_map(doc.corpus, stripWhitespace)
doc.corpus  <- tm_map(doc.corpus , PlainTextDocument)

TDM <- TermDocumentMatrix(doc.corpus)
inspect(TDM)

DTM <- DocumentTermMatrix(doc.corpus)
inspect(DTM[1:10,1:10])


findFreqTerms(TDM, 2000)
findAssocs(TDM, "love", 0.75)

TDM.common = removeSparseTerms(TDM, 0.1)
inspect(TDM.common[1:10,1:10])


library(slam)
TDM.dense <- as.matrix(TDM.common)

head(TDM.dense)
library(reshape2)
TDM.dense = melt(TDM.dense, value.name = "count")


library(ggplot2)

   ggplot(TDM.dense, aes(x = Docs, y = Terms, fill = log10(count))) +
       geom_tile(colour = "white") +
       scale_fill_gradient(high="#FF0000" , low="#FFFFFF")+
       ylab("") +
       theme(panel.background = element_blank()) +
       theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())