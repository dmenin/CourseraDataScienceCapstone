#use stringr?

suggestWord <- function(etext,dt_n1,dt_n2,dt_n3,dt_n4, rec_count=0)
{
  
  if (rec_count ==5){
    #safety mechanism in case the recursion enters in a loop;
    v<-dt_n1[][order(-freq)]  
    return(v[1:10,])
  }
#   etext <- tolower(etext)
#   etext <- gsub("[?.;'!:+@¡¿·#',]", " ", etext)
#   etext <- trim(etext)
#   nWords<-str_count(etext, "\\S+")
  etext <-iconv(etext, from="UTF-8", to="latin1", sub=" ")
  if (rec_count==0){
    df <- data.frame(etext)
    names(df) <- c("text")
    
    myCorpus <-Corpus(VectorSource(df))
    myCorpus <- tm_map(myCorpus, content_transformer(tolower))
    myCorpus <- tm_map(myCorpus, removePunctuation) # remove punctuation 
    myCorpus <- tm_map(myCorpus, removeNumbers) #remove numbers 
    removeURL <- function(x) gsub("http[[:alnum:]]*", "", x) # remove URLs 
    myCorpus <- tm_map(myCorpus, removeURL) 
    
    etext <-myCorpus[[1]]
  }
  
  etext <- trim(etext)  
  nWords<-str_count(etext, "\\S+")  
  
  if (nWords == 0){    
    v<-dt_n1[][order(-freq)]     
  }else if (nWords == 1){    
    v<-dt_n2[gram==etext][order(-freq)]    
  } else if (nWords==2){
    v<- dt_n3[gram==etext][order(-freq)]    
  } else if (nWords==3){
    v<- dt_n4[gram==etext][order(-freq)]    
  } else{ #more than 3 words    
    w<- sub( patt='(.+)(([ ,.]+\\w+){3})[ ]?$', repl='\\2', etext) # "cant wait to see" becomes "wait to see"
    w<-paste(w, collapse = '')
    w<-trim(w)
    v<- dt_n4[gram==w][order(-freq)]
  }

  if (nWords>=1 && is.na(v[1]$target)){ #couldnt find n gram, recursion to get n-1 gram
    
    if (nWords ==1){ etext <-""} 
    else if (nWords ==2) { etext <- sub( patt='(.+)(([ ,.]+\\w+){1})[ ]?$', repl='\\2', etext)}
    else if (nWords ==3) { etext <- sub( patt='(.+)(([ ,.]+\\w+){2})[ ]?$', repl='\\2', etext)}
    else if (nWords >=4) {etext <- sub( patt='(.+)(([ ,.]+\\w+){3})[ ]?$', repl='\\2', etext)}
      
    v <- suggestWord(etext, dt_n1, dt_n2, dt_n3, dt_n4,rec_count+1)
  }
  
  return(v[1:10,])
}

trim.leading <- function (x)  sub("^\\s+", "", x)
trim.trailing <- function (x) sub("\\s+$", "", x)
trim <- function (x) gsub("^\\s+|\\s+$", "", x)

#rm(suggestWord)
etext <-"Cloud computing has opened the world of new opportunities for Information Technology Industry. The enterprises are quite optimistic about this new buzz. Cloud computing as a â€œcomputing modeÂ Â  "
suggestWord(etext,dt_n1,dt_n2,dt_n3,dt_n4,0)
# 
# etext

# suggestWord("you have a wonderfull day",dt_n1,dt_n2,dt_n3, dt_n4)   
# suggestWord(" wait to see",dt_n1,dt_n2,dt_n3, dt_n4)   
# suggestWord("hellou",dt_n1,dt_n2,dt_n3, dt_n4)   
# 
# etext <- "you have a wonderfull day"
# dt_n4[][order(-freq)]

