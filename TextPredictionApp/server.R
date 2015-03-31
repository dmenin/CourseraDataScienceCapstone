#install.packages("dplyr")
#install.packages("calibrate")
#install.packages("UsingR")
library(shiny)
library(datasets)
library(calibrate)
library(UsingR)
library(dplyr)
library(stringr)
library(data.table)
#setwd("C:\\git\\capstone\\TextPredictionApp")

loadN1 <- reactive({      
  dt_n1 <- readRDS("dt_n1.RDS")         
})
loadN2 <- reactive({      
  dt_n2 <- readRDS("dt_n2.RDS")      
})    
loadN3 <- reactive({      
  dt_n3 <- readRDS("dt_n3.RDS")      
})  


shinyServer(
  function (input, output) {

      output$myView <- renderTable({        
          source('suggestword.R')
          predict<-(input$ptext)      
          dt_n1 <- loadN1()
          dt_n2 <- loadN2()
          dt_n3 <- loadN3()
       
          ret <- suggestWord(predict,dt_n1,dt_n2,dt_n3)
          ret <- subset(ret, select = -c(freq))
      })	
  
      output$caption <- renderText({      
        predict<-(input$ptext)      
        predict
      })   
      

  }
)


#if(grepl("[[:space:]]+$", input$ptext) || (input$ptext=="")){ }
