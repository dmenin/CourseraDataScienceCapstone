#install.packages("dplyr")
#install.packages("calibrate")
#install.packages("UsingR")
library(shiny)
library(datasets)
library(calibrate)
library(UsingR)
library(dplyr)


shinyServer(
	function(input, output) {

	  basedataset <- reactive({
	    
	    if (input$radioGender == 1) {
	      s <- 'M'
	    } else {
	      s <- 'F'
	    }
	    
	    k <- kid.weights
	    k <- filter (k, gender == s)
	    
	  })    
    
	  datasetInput <- reactive({

      k <- basedataset()
	    	    
	    by_age <- group_by(k, age)
	    s <- summarise(by_age, mean_w = round(mean(weight),1), mean_h = round(mean(height),1), amt = n())
	    
	    s <- mutate (s, bmi = round( (mean_w / 2.2046) / ((mean_h*2.54/100)^2),1) )
	    
      s <- filter(s, age==input$ageSlider)
      
	    s
      
	  })      
    
 
	  output$myView <- renderPlot({
	    k <- basedataset()	 
	    k <- filter(k, age >= input$ageSlider-2 & age <= input$ageSlider +2)
      
      if (nrow(k) > 0) {
        gender <- if (input$radioGender == 1) {'male'} else {'female'}
              
        
  	    t = paste("Weight X Height plot for", gender,"kids from", input$ageSlider-2 ,"to", input$ageSlider+2, "months of age" , sep = " ")
        
        d <- plot(k$weight, k$height,  xlab="weight", ylab="Height", xlim=c(0, 150), ylim=c(0, 67) , main= t)
  	    d<- text(k$weight, k$height,k$age, cex=0.6, pos=4, col="blue")
  	    	    
        #points(x=80,y=20, col='red', lwd=6)
        d <- textxy(input$weight, input$height, cex=1, col='red',"* -> your kid is here")
        d
      }
	  })	
    

    
	  output$caption <- renderText({	    
	    s <- datasetInput()
	    avg_bmi <- s[1,"bmi"]
      
	    if (is.na(avg_bmi)) {
        
	     # if (input$radioGender == 1) {gender <- 'he'} else {gender <- 'she'}        
        
        c("We have no data on your kid's age but I'm sure ", 
          if (input$radioGender == 1) {'he is'} else {'she is'}
          , "allright, but just to be sure, cut on the suggar :)")
	      
	    } else {
        avg_bmi <- s[1,"bmi"]
        kid_bmi <-  round( (input$weight / 2.2046) / ((input$height*2.54/100)^2),1)
        
        dif <- kid_bmi / avg_bmi
        
        if (dif ==1) {
          t <- c("Your kid's BMI is", kid_bmi, "which is right on average :)")
        }else if (dif > 1) {
          t <- c("Your kid's BMI is", kid_bmi, "which is ", round((dif-1) * 100,2),"% above the average (",avg_bmi,")")
        } else {
          t <- c("Your kid's BMI is", kid_bmi, "which is ", round((1-dif)*100,2),"% bellow the average (",avg_bmi,")")
        }        

        t<- paste(t, collapse = '')#toString(t)
        t
	    }
	  })
    
    
	  
    
	}
)