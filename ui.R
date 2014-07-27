shinyUI(pageWithSidebar(
  headerPanel("Know Weather You would have survived the titanic or not"),
  sidebarPanel(
    selectInput(inputId="Pclass",label="Passenger Class - Are you a big spender or a miser",choices= c("First Class"="1","Second Class"="2","Third Class"="3")),
      selectInput(inputId="Gender",label="Gender-You cant do anything here",choices=c("male"="male","female"="female")),
      numericInput(inputId="Age","Age",25,min=1,max=100,step=1),
      numericInput("Fare","Fare",25,min=7,max=200,step=.5),
      actionButton("goButton","Predict!!!")    
    ),
  mainPanel(
    verbatimTextOutput("cod"),
    h3("You would have:"),
    verbatimTextOutput("sod"),
    h3("People like you have:"),
    plotOutput("plot")
    )
  ))