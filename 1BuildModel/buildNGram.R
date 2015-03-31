buildNGram <- function(filePath, nrows, minGram, maxGram)
{
  #con <- file("c:\\git\\capstone\\final\\en_US\\en_US.twitter.txt", "r") 
  #con <- file("c:\\git\\capstone\\final\\en_US_small\\en_US.twitter_small.txt","r")
  con <- file(filePath, "r") 
  a<- readLines(con,nrows) 
  close(con)
  
  a <- iconv(a, from="UTF-8", to="latin1", sub=" ") #transforms  "I'm doing it!ðY'¦" to "I'm doing it!    "  
  df<-as.data.frame(a)
  names(df) <- c("text")

  myCorpus <-Corpus(VectorSource(df))
  
  
  myCorpus <- tm_map(myCorpus, content_transformer(tolower))
  myCorpus <- tm_map(myCorpus, removePunctuation) # remove punctuation 
  myCorpus <- tm_map(myCorpus, removeNumbers) #remove numbers 
  removeURL <- function(x) gsub("http[[:alnum:]]*", "", x) # remove URLs 
  myCorpus <- tm_map(myCorpus, removeURL) 
  
  #remove words
  #word_list <- c("how", "you", "way")
  #corpus_sample <- tm_map(myCorpus, removeWords, word_list) 
  
  myCorpus <- tm_map(myCorpus, PlainTextDocument) #http://stackoverflow.com/questions/24191728/documenttermmatrix-error-on-corpus-argument
  
  
  #n gram
  BigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = minGram, max = maxGram))
  tdm <- TermDocumentMatrix(myCorpus, control = list(tokenize = BigramTokenizer))
  
  
  term.freq <- rowSums(as.matrix(tdm)) #sums the words across the documents
 # term.freq <- subset(term.freq, term.freq > 1) #only necessary if I want to ommit a word with few counts
  df <- data.frame(term = names(term.freq), freq = term.freq) #WORD COUNT
}
  