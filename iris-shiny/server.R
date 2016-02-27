# load libraries
library(shiny)
require(googleVis)
require(rCharts)
require(datasets)
require(randomForest)
require(ggplot2)
# begin shiny server 
shinyServer(function(input, output) {
    # read input variables
    petallength <- reactive({input$petallength})
    sepalwidth <- reactive({input$sepalwidth})
    
    
    ## load iris data
    #load(iris)    
    names(iris) = gsub("\\.", "", names(iris))
    
    # Testing model accuraccy within the dataset
    set.seed(123)
    inTrain <- createDataPartition(y=iris$Species, times = 1, p=0.8,list = FALSE)
    irisTrain <- iris[inTrain,]
    irisTest <- iris[-inTrain,]
    
    irisFit <- randomForest(Species ~ PetalLength + SepalWidth, data = irisTrain)
    acc <- confusionMatrix(irisTest$Species, predict(irisFit, irisTest[1:4]))$overall[1]
    
    # Build random forests model to predict species based on Petal Length and Sepal Width
    fit <- randomForest(Species ~ PetalLength + SepalWidth, data = iris)
    
    # build input test dataset
    test <- reactive({data.frame(PetalLength = petallength(), SepalWidth = sepalwidth())})
    
    #predict
    pred <- reactive({predict(fit, test())})
    
    #final dataframe to plot
    final <- reactive({data.frame(test(), Species = pred())})
    
    ## return the input values
    output$sepalwidth <- sepalwidth
    output$petallength <- petallength
    output$acc <- renderPrint({round(acc*100,2)})
    output$species <- renderText({as.character(final()$Species)})
    
    output$myplot <- renderPlot({   
        
        final_df <- final()
        
        ggplot(iris, aes(PetalLength, SepalWidth, color = Species)) +  
            geom_jitter(size = 3) + 
            scale_x_continuous(limits = c(0.5, 8)) + 
            scale_y_continuous(limits = c(1.5, 5)) + 
            geom_point(data = final_df, size = 7, shape = 8) +
            geom_point(data = final_df, size = 3)
        
    })
})
