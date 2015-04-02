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
    
    basedataset <- reactive({
      
      source('suggestword.R')
      predict<-(input$ptext)      
      dt_n1 <- loadN1()
      dt_n2 <- loadN2()
      dt_n3 <- loadN3()
      
      ret <- suggestWord(predict,dt_n1,dt_n2,dt_n3)      
    })  
    
    

      output$myView <- renderTable({        
        k <- basedataset()
        k <- subset(k, select = -c(freq))
        k
      })	
  
      output$caption <- renderText({      
        predict<-(input$ptext)      
        predict
      })   
      
      output$b1 <- renderUI({
        k <- basedataset()
        
        actionButton(inputId = "action1", label = k[1]$target)
      })
      
      output$b2 <- renderUI({
        k <- basedataset()
        
        actionButton("action2", label = k[2]$target)
      })      
       output$b3 <- renderUI({
         k <- basedataset()
         
         actionButton("action3", label = k[3]$target)
      })      
    
    output$plot <- renderPlot({
      k <- basedataset()
      p <- 
        ggplot(k, aes(x = target, y = freq, width = 0.7)) + 
        geom_bar(stat = "identity", fill = "grey50", colour = "black") +
        geom_text(aes(label = freq),
                  size = 3,
                  hjust = 0,
                  angle = 90) +
        theme_classic() +
        theme(axis.text.x = element_text(angle = 90),
              axis.ticks.x = element_blank())       
      p
    })
#     
#     observe({
#       input$action1 # check if the action button is clicked
#       isolate({
#         output$caption <-"clicked button 1"
#       })
#     })
    
#     observe({
#       input$action2 # check if the action button is clicked
#       output$test <-"c2"
#     })
#     
#     observe({
#       input$action3 # check if the action button is clicked
#       output$test <-"c3"
#     })
    

  }
)


#if(grepl("[[:space:]]+$", input$ptext) || (input$ptext=="")){ }
