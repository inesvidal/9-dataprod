# load libraries
library(shiny)
require(googleVis)
require(rCharts)
require(datasets)
require(randomForest)
require(ggplot2)
# begin shiny server 
shinyServer(function(input, output) {
    
    ## Example 1 Facetted Scatterplot
    
    # read input variables
    petallength <- reactive({input$petallength})
    sepalwidth <- reactive({input$sepalwidth})
    
    ## load iris data
    #load(iris)    
    names(iris) = gsub("\\.", "", names(iris))
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
    
    #tests
    output$fit <- renderPrint({head(fit,1)})    
    output$test <- renderPrint({test()})
    output$pred <- renderPrint({pred()})
    output$final <- renderPrint({final()})
    output$species <- renderPrint({droplevels(final()$Species)})
    
    
    #     library(caret)
    #     x <- iris
    #     preProc <- preProcess(x, method="pca", thresh =.95) # calculate PCs for training data
    #     train_pca <- predict(preProc, x)
    #     # run model on outcome and principle components
    #     fit_pca_rf <- train(y ~ ., data = train_pca, method = "rf") # calculate PCs for test data
    #     test_pca_rf <- predict(preProc, t)
    # compare results 
    #acc_pca_rf <- confusionMatrix(t$classe, predict(fit_pca_rf, test_pca_rf))$overall[1]
    
    
    output$myplot <- renderPlot({   
        
        final_df <- final()
        
        ggplot(iris, aes(PetalLength, SepalWidth, color = Species)) +  
            geom_jitter(size = 3) + 
            scale_x_continuous(limits = c(0.5, 8)) + 
            scale_y_continuous(limits = c(1.5, 5)) + 
        geom_point(data = final_df, size = 7, shape = 8) +
            geom_point(data = final_df, size = 3)
        
    })
    #     r1$save('fig/r1.html', cdn = TRUE)
    #     cat('<iframe src="fig/r1.html" width=100%, height=600></iframe>')
    
    ############ DEL EJEMPLO
    #     # define reactive parameters
    #     pop<- reactive({sample(1:20, input$population, replace = TRUE)})
    #     bootstrapSample<-reactive({sample(pop(),input$sampleSize*input$numSample,
    #                                       replace = TRUE)})
    #     popVar<- reactive({round(var(pop()),2)})
    #     # print text through reactive funtion
    #     output$biaVar <- renderText({
    #         sample<- as.data.frame(matrix(bootstrapSample(), nrow = input$numSample,
    #                                       ncol =input$sampleSize))
    #         return(round(mean(rowSums((sample-rowMeans(sample))^2)/input$sampleSize), 2))
    #     })
    #     # google visualization histogram
    #     output$popHist <- renderGvis({
    #         popHist <- gvisHistogram(data.frame(pop()), options = list(
    #             height = "300px",
    #             legend = "{position: 'none'}", title = "Population Distribution",
    #             subtitle = "samples randomly drawn (with replacement) from values 1 to 20",
    #             histogram = "{ hideBucketItems: true, bucketSize: 2 }",
    #             hAxis = "{ title: 'Values', maxAlternation: 1, showTextEvery: 1}",
    #             vAxis = "{ title: 'Frequency'}"
    #         ))
    #         return(popHist)
    #     })
})
