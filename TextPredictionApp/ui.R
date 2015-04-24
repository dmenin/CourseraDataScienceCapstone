shinyUI(fluidPage(
  br(),
  br(),
  br(),
  br(),
  br(),
  br(),  
  br(),  
  
  br(),
  br(),  
  br(),    
  br(),    
  
  tags$head(tags$style(HTML("
       body {
            background: url(img/back.jpg);
            
            background-repeat: no-repeat;
        }                        
    "))),
  
#  sidebarLayout(

    sidebarPanel(
      tags$head(
        tags$style(type="text/css", ".well { width: 290px; }"),
        tags$style(type="text/css", ".well { height: 187px; }")
      ),      

      textInput("ptext", "Type Message:", ""),
       fluidRow(        
          column(4,uiOutput("b2")),
          column(4,uiOutput("b1")),
          column(4,uiOutput("b3"))
       ),
      checkboxInput('adv', 'Advanced', FALSE)
    ),
    mainPanel(
    
     fluidRow( 
       column(8,plotOutput("plot"))
       #column(2,tableOutput("myView"))       
     )
    )
  #)
))
