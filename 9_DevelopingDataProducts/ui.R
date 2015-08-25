shinyUI(fluidPage(
  titlePanel("Coursera Data Science Specialization - Developing Data Products class Project - Part 1"),
  sidebarLayout(
    sidebarPanel(
      h2("Parameters"),
      p("Inform the parameters:"),

      sliderInput("ageSlider", label = "Age (months)", min = 3, max = 144, value = 51),      
      numericInput("weight", "Inform the weight in pounds:", 35),      
      numericInput("height", "Inform the height in inches:", 35.5),      
      radioButtons("radioGender", label = "Gender", choices = list("M" = 1, "F" = 2),  selected = 1)   ,      
      textOutput("caption"),

      
      img(src = "bigorb.png", height = 72, width = 72),"shiny is a product of ",  span("RStudio", style = "color:blue")
    ),
    mainPanel(
      h3("Children BMI Analysis"),
      p("This is a tool to analyse how close your baby''s BMI is from the average babies of his age."),
      
      p("In order to do that, just infor your baby''s age, weight (in pounds), height (in inches) and if it is male or female on the panel on your left"),
      
      p("The data will be compared with the  Weight and height measurement for a sample of U.S. children presented in the NHANES III survey (http://www.cdc.gov/nchs/nhanes.htm). This survey is used to form the CDC Growth Charts (http://www.cdc.gov/growthcharts) for children"),
      p("You can also find this dataset's documentation searching for 'kid.weights' at http://cran.r-project.org/web/packages/UsingR/UsingR.pdf"),
      
      
      strong("This is part of the Developing Data Products course on the Data Science Specialization of the Johns Hopkins University of Public Health"),
      strong("Please do not take the calculations seriously, the main output of this is the Shiny applicaiton, not the calculation themselves."),      
       
      h3("Graph"),
      plotOutput("myView")
    )
  )
))

