# load shiny package
library(shiny)
library(e1071)
library(caret)
require(randomForest)
# library(MathJax) # No existe con este nombre
# begin shiny UI
shinyUI(navbarPage("Shiny Project",
                   # create documentation tab
                   tabPanel("Documentation",
                            
                            h3('Iris species prediction'),
                            p('This Shiny App predicts the species of a plant given its', 
                              em('petal lenght'), 'and ', em('sepal width'), '.'),
                            p('The ', a('Iris dataset', 
                                        href = 'https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/iris.html', 
                                        target = '_blank'),
                              ' collects data about petal lenght and width and sepal lenght and width for the three species of iris flowers ', 
                              '(setosa, versicolor and virginica).'),
                            br(),
                            h4('Instructions:'),
                            tags$ul(
                                tags$li('Select petal length and sepal width in the sliders'),
                                tags$li('Check the results:'),
                                tags$ul(
                                    tags$li('the predicted species name, and'), 
                                    tags$li('your flower presented with the Iris dataset',
                                            'your flower is presented with an', strong('*'), 
                                            'in the color associated to the predicted species'), 
                                    fluidRow(
                                        column(6, offset = 1,
                                               img(src="legend.png", height = 64, width = 66)
                                        ))
                                ),
                                tags$li('With any change to the inputs the prediction and the plot will be regenerated.')
                            ),
                            
                            
                            br(),
                            br(),
                            h4('Additional detail'),
                            p('Among the four variables in the Iris dataset, ',
                              'we have selected the two with highest contribution ',
                              'in predicting the flower species (PCA, components 1 and 2) ',
                              'to simplify the representation of the input and predicted species.'
                            ),
                            br(),
                            p('See the code:   '), 
                            fluidRow(
                                column(6, offset = 1,
                                       p(span('require(randomforest)', 
                                              br(),
                                              'require(datasets)',
                                              br(),
                                              'load(iris)',
                                              br(),
                                              '# Testing model accuraccy within the dataset',
                                              br(),
                                              'inTrain <- createDataPartition(y=iris$Species, times = 1, p=0.8,list = FALSE)',
                                              br(),
                                              'irisTrain <- iris[inTrain,]',
                                              br(),
                                              'irisTest <- iris[-inTrain,]',
                                              br(),
                                              'irisFit <- randomForest(Species ~ PetalLength + SepalWidth, data = irisTrain)',
                                              br(),
                                              'confusionMatrix(irisTest$Species, predict(irisFit, irisTest[1:4]))$overall[1]',
                                              style = "color: grey; font-family: courier; font-size: 12px"))
                                )),
                            br(),
                            p(strong('Using Petal lenght and Sepal width results in', 
                                     textOutput("acc", inline = TRUE), '% within the dataset.'))
                            
                   ),
                   # second tab
                   tabPanel("Iris species prediction",
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
                                fluidRow(
                                    column(4,
                                           h3('Illustrating inputs'),
                                           h4('Petal length:   ',
                                              span(
                                                  textOutput("petallength", inline = TRUE), 
                                                  style = "color: blue")),
                                           br(),
                                           h4('Sepal width:    ',
                                              span(
                                                  textOutput("sepalwidth", inline = TRUE),
                                                  style = "color: blue")),
                                           br()),
                                    column(4, 
                                           h3('Process outputs'),
                                           h4('Predicted species:     ',
                                              span(
                                                  textOutput("species", inline = TRUE),
                                                  style = "color: blue")),
                                           br())
                                ),
                                
                                fluidRow(
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
