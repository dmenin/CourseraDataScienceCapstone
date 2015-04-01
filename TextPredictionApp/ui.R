shinyUI(fluidPage(
  
  sidebarLayout(
    sidebarPanel(
      
      textInput("ptext", "Text to predict:", ""),
       fluidRow(        
#         column(4,submitButton("Submit")),
#         column(4,submitButton("Submit")),
#         column(4,submitButton("Submit"))
#         column(4,actionButton("b1", label = "Action")),
#         column(4,actionButton("b2", label = "Action")),
#         column(4,actionButton("b3", label = "Action"))
          column(4,uiOutput("b1")),
          column(4,uiOutput("b2")),
          column(4,uiOutput("b3"))
          
       )
  

    ),
    mainPanel(
      p("This is Version 0.1 of my Text Predictor for the Coursera Data Science Capstone Project."),
      
      p("It is a very raw and early version - it does one thing and one thing only, which is to use 3 grams to predict the next word on a sentence. My goal was to create something just to see if I'm on the right track. I haven't dealt with the most simple exceptions yet, for example, punctuation will break the predictior :) - will be doing that on the next steps."),
      
      br(),
      
      p("The training data is considerably small and it is composed by 100.000 rows of twitter tweets and I'm using solely 3 grams on the prediction (except for the fist words where I use the uni and bi grams), so Its very easy to loop the algorithm with things like:"),
      
      p("",strong("the best way to"),  "the gym to get", strong("the best way to"),"get", strong("the best way"), "to get - gonna have to deal with this one too"),
      
      br(),
      
      p("Also, I've not yet removed curse words from the training data so please use it with discression - BTW, people curse A LOT on twitter =/ (I guess I should have done this step first)"),
      
      p("Any feedback would be greatly appreciated - dmenin@gmail.com"),
      
      
      
      h3("Current Text"),
      textOutput("caption"),
      p(".............................."),

      h3("Top 3 suggestions:"),

      tableOutput("myView")
    )
  )
))
