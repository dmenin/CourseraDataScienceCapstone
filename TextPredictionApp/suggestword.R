#use stringr?

suggestWord <- function(etext,dt_n1,dt_n2,dt_n3)
{
  etext <- tolower(etext)
  etext <- trim(etext)
  nWords<-str_count(etext, "\\S+")
  
  if (nWords == 0){    
    v<-dt_n1[][order(-freq)]     
  }else if (nWords == 1){    
    v<-dt_n2[gram==etext][order(-freq)]    
  } else if (nWords==2){        
    v<- dt_n3[gram==etext][order(-freq)]    
  } else{ #more than 2 words
    w<- c(word(etext,nWords-1), " ", word(etext,nWords)) #"the best way" becomes "best way" so I can look for it on the dt_n3
    w<-paste(w, collapse = '')
    v<- dt_n3[gram==w][order(-freq)]
  }

  if (nWords>1 && is.na(v[1]$target)){ #couldnt find 3 gram, recursion to get gram 2
    etext <- sub(".* ", "", etext)
    v <- suggestWord(etext, dt_n1, dt_n2, dt_n3)
  }
  
  return(v[1:10,])
}

trim.leading <- function (x)  sub("^\\s+", "", x)
trim.trailing <- function (x) sub("\\s+$", "", x)
trim <- function (x) gsub("^\\s+|\\s+$", "", x)