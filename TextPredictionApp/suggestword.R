#use stringr?

suggestWord <- function(etext,dt_n1,dt_n2,dt_n3,dt_n4)
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
  } else if (nWords==3){
    v<- dt_n4[gram==etext][order(-freq)]    
  } else{ #more than 3 words
    #w<- c(word(etext,nWords-1), " ", word(etext,nWords)) #"the best way" becomes "best way" so I can look for it on the dt_n3
    w<- sub( patt='(.+)(([ ,.]+\\w+){3})[ ]?$', repl='\\2', etext) # "cant wait to see" becomes "wait to see"
    w<-paste(w, collapse = '')
    w<-trim(w)
    v<- dt_n4[gram==w][order(-freq)]
  }

  if (nWords>=1 && is.na(v[1]$target)){ #couldnt find n gram, recursion to get n-1 gram
    
    if (nWords ==1){ etext <-""} 
    else if (nWords ==2) { etext <- sub( patt='(.+)(([ ,.]+\\w+){1})[ ]?$', repl='\\2', etext)}
    else if (nWords ==3) { etext <- sub( patt='(.+)(([ ,.]+\\w+){2})[ ]?$', repl='\\2', etext)}
    else if (nWords >=4) { etext <- sub( patt='(.+)(([ ,.]+\\w+){3})[ ]?$', repl='\\2', etext)}
      
    v <- suggestWord(etext, dt_n1, dt_n2, dt_n3, dt_n4)
  }
  
  return(v[1:10,])
}

trim.leading <- function (x)  sub("^\\s+", "", x)
trim.trailing <- function (x) sub("\\s+$", "", x)
trim <- function (x) gsub("^\\s+|\\s+$", "", x)


# suggestWord("you have a wonderfull day",dt_n1,dt_n2,dt_n3, dt_n4)   
# suggestWord(" wait to see",dt_n1,dt_n2,dt_n3, dt_n4)   
# suggestWord("hellou",dt_n1,dt_n2,dt_n3, dt_n4)   
# 
# etext <- "you have a wonderfull day"
# dt_n4[][order(-freq)]

