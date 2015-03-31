#use stringr?

suggestWord <- function(etext,dt_n1,dt_n2,dt_n3)
{
  etext <- tolower(etext)
  etext <- trim(etext)
  nWords<-str_count(etext, "\\S+")
  if (nWords == 0){
    v<-dt_n1[][order(-freq)][1:3,]  
  }else if (nWords == 1){
    v<-dt_n2[gram==etext][order(-freq)][1:3,]
  } else if (nWords==2){    
    v<- dt_n3[gram==etext][order(-freq)][1:3,]
  } else{ #more than 2 words
    w<- c(word(etext,nWords-1), " ", word(etext,nWords))
    w<-paste(w, collapse = '')
    v<- dt_n3[gram==w][order(-freq)][1:3,]
  }
  
  return(v)
}

trim.leading <- function (x)  sub("^\\s+", "", x)
trim.trailing <- function (x) sub("\\s+$", "", x)
trim <- function (x) gsub("^\\s+|\\s+$", "", x)
