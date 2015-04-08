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
library(scales) #allows the % formating on the graph
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
loadN4 <- reactive({      
  dt_n4 <- readRDS("dt_n4.RDS")
}) 


shinyServer(
  function (input, output) {
    
    basedataset <- reactive({
      
      source('suggestword.R')
      predict<-(input$ptext)      
      dt_n1 <- loadN1()
      dt_n2 <- loadN2()
      dt_n3 <- loadN3()
      dt_n4 <- loadN4()
      
      ret <- suggestWord(predict,dt_n1,dt_n2,dt_n3, dt_n4)      
      ret<-na.omit(ret)
    })  
    
    
#      this is the table output:
      output$myView <- renderTable({
        if (input$adv) {
          k <- basedataset()
          k <- subset(k, select = -c(freq))
          k
        }
      })	
  
#       output$caption <- renderText({      
#         predict<-(input$ptext)      
#         predict
#       })   
      
      output$b1 <- renderUI({
        k <- basedataset()     
        actionButton(inputId = "action1", label = k[1]$target)
      })
      
      output$b2 <- renderUI({
        k <- basedataset()   
        actionButton("action2", label = k[2]$target )
      })      
       output$b3 <- renderUI({         
         k <- basedataset()
         actionButton("action3", label = k[3]$target)
      })      
    
    
#     observe({
#       input$action1 # check if the action button is clicked
#       isolate({
#         output$caption <-renderText({
#           paste("clicked button 1")
#         })
#       })
#     })
# 
#     observe({
#       input$action2 # check if the action button is clicked
#       isolate({
#         output$caption <-renderText({
#           paste("clicked button 2")
#         })
#       })
#     })
#     
#     observe({
#       input$action3 # check if the action button is clicked
#       isolate({
#         output$caption <-renderText({
#           paste("clicked button 3")
#         })
#       })
#     })   
    
    
 
  output$plot <- renderPlot({
    if (input$adv) {
      k <- basedataset()
      if (!is.na(k[1]$target)) {
        k$perc_freq <- round(k$freq / sum(k$freq),2)        
        ggplot(k, aes(x = reorder(target,-perc_freq), y = perc_freq, width = 0.5)) + 
          labs(y='Frequency',x='Suggestion') + 
          scale_y_continuous(labels=percent) +
          geom_bar(stat = "identity", fill = "grey50", colour = "black") +
          theme_classic() +
          theme(axis.text.x = element_text(angle = 0), axis.ticks.x = element_blank())
        }
      }
    })    
    

  }
)


#if(grepl("[[:space:]]+$", input$ptext) || (input$ptext=="")){ }
