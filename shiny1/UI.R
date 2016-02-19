# load shiny package
library(shiny)
# library(MathJax) # No existe con este nombre
# begin shiny UI
shinyUI(navbarPage("Shiny Project",
                   # create first tab
                   #                    tabPanel("Documentation",
                   #                             # load MathJax library so LaTeX can be used for math equations
                   #                             withMathJax(), h3("Why is the Variance Estimator \\(S^2\\) divided by \\(n-1?\\)"),
                   #                             # paragraph and bold text
                   #                             p("The ", strong("sample variance")," can be calculated in ", strong(em("two")),
                   #                               " different ways:",
                   #                               "$$S^2 \\mbox{(unbiased)} = \\frac{\\sum_{i=1}^n (X_i - \\bar X)^2}{n-1}
                   #                               ~~~\\mbox{and}~~S^2\\mbox{(biased)}=\\frac{\\sum_{i=1}^n (X_i-\\bar X)^2}{n}$$",
                   #                               "The unbiased calculation is most often used, as it provides a ",
                   #                               strong(em("more accurate")), " estimate of population variance"),
                   #                             # break used to space sections
                   #                             br(), p("To show this empirically, we simulated the following in the ",
                   #                                     strong("Simulation Experiment"), " tab: "), br(),
                   #                             # ordered list
                   #                             tags$ol(
                   #                                 tags$li("Create population by drawing observations from values 1 to 20."),
                   #                                 tags$li("Draw a number of samples of specified size from the population"),
                   #                                 tags$li("Plot difference between sample and true population variance"),
                   #                                 tags$li("Show the effects of sample size vs accuracy of variance estimated")
                   #                             )),
                   # second tab
                   tabPanel("Simulation Experiment",
                            # some input variables
                            sidebarPanel(
                                #                                 numericInput('numeric1', 'Numeric input, labeled id1', 0, min = 0, max = 10, step = 1),
                                #                                 checkboxGroupInput("check1", "Checkbox",
                                #                                                    c("Value 1" = "1",
                                #                                                      "Value 2" = "2",
                                #                                                      "Value 3" = "3")),
                                sliderInput('petallength', 'Petal Length',value = 5, min = 0.5, max = 8, step = 0.05,),
                                sliderInput('sepalwidth', 'Sepal Width',value = 3.5, min = 1.5, max = 5, step = 0.05,)#,
                                #submitButton("Predict color")
                                
                            ),
                            
                            mainPanel(
                                
                                ## confirming data input
                                h3('Illustrating inputs'),
                                h4('You entered'),
                                fluidRow(
                                    column(3,    
                                           textOutput("petallength"),
                                           br()),
                                    column(3, 
                                           textOutput("sepalwidth"),
                                           br())
                                ),
                                fluidRow(
                                    #tests
                                    column(6,    
                                           h5('test summary'),
                                           verbatimTextOutput("test"),
                                           h5('pred summary'),
                                           verbatimTextOutput("pred"),
                                           br()),
                                    column(6,    
                                           h4('fit summary'),
                                           verbatimTextOutput("fit"),
                                           h4('final summary'),
                                           verbatimTextOutput("final"),
                                           br())
                                ),
                                fluidRow(
                                    h3('Predicted species'),
                                    textOutput("species"),
                                    ## the plot
                                    plotOutput("myplot")
                                )
                            )
                   )
))
#                    tabPanel("Simulation Experiment",
#                             # fluid row for space holders
#                             fluidRow(
#                                 # fluid columns
#                                 column(4, div(style = "height: 150px")),
#                                 column(4, div(style = "height: 150px")),
#                                 column(4, div(style = "height: 150px"))),
#                             # main content
#                             fluidRow(
#                                 column(12,h4("We start by generating a population of ",
#                                              span(textOutput("population", inline = TRUE), 
#                                                   style = "color: red; font-size: 20px"),
#                                              " observations from values 1 to 20:"),
#                                        tags$hr(),htmlOutput("popHist"),
#                                        # additional style
#                                        style = "padding-left: 20px"
#                                 )
#                             ),
#                             # absolute panel
#                             absolutePanel(
#                                 # position attributes
#                                 top = 50, left = 0, right =0,
#                                 fixed = TRUE,
#                                 # panel with predefined background
#                                 wellPanel(
#                                     fluidRow(
#                                         # sliders
#                                         column(4, sliderInput("population", "Size of Population:",
#                                                               min = 100, max = 500, value = 250),
#                                                p(strong("Population Variance: "), 
#                                                  textOutput("popVar", inline = TRUE))),
#                                         column(4, sliderInput("numSample", "Number of Samples:",
#                                                               min = 100, max = 500, value = 300),
#                                                p(strong("Sample Variance (biased): "), 
#                                                  textOutput("biaVar", inline = TRUE))),
#                                         column(4, sliderInput("sampleSize", "Size of Samples:",
#                                                               min = 2, max = 15, value = 10),
#                                                p(strong("Sample Variance (unbiased): "), 
#                                                  textOutput("unbiaVar", inline = TRUE)))),
#                                     style = "opacity: 0.92; z-index: 100;"
#                                 ))
#                    )
