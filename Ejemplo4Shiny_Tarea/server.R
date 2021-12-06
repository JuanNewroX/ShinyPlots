library(shiny)
library(stringr)
library(ggplot2)
library(dplyr)

shinyServer(function(input, output, session) {
  
    data <- mtcars %>% mutate(
      color_paint =  "#000000",
      cantidad = 1,
      carro = rownames(mtcars)
    ) %>% unique()  
    makeReactiveBinding('data')
    
    output$grafica_base_r <- renderPlot({
      data %>% write.csv("datos.csv", row.names=FALSE)
      plot(mtcars$wt, mtcars$mpgm, xlab="wt", ylab = "millas por galon") 
    })
  
    output$mtcars_tbl <- renderTable({
      data <- read.csv("datos.csv")
      #df <- nearPoints(data, input$clk, xvar ="wt", yvar = "mpg") 
      #df <- brushedPoints(mtcars, input$mouse_brush, xvar ='wt', yvar = 'mpg') 
      df <- data %>% filter(color_paint != "#000000")
      #df 
    })
  
    output$grafica_ggplot <- renderPlot({
      diamonds %>% ggplot(
        aes(x=carat, y=price, color=color))+
        geom_point()+
        xlab("Precio")+
        ylab("kilates")+ggtitle("Precio de diamantes por kilates")
    })
     
    
    output$plot_click_options <- renderPlot({
      cat("grafico ")
      plot(data$wt, data$mpg, xlab="wt", ylab = "millas por galon", col=data$color_paint )
    })
    
    observeEvent(input$clk,{
      cat("actualizar")
      data <- read.csv("datos.csv")
      
      dfSele <- nearPoints(data, input$clk, xvar ="wt", yvar = "mpg") 
      
      data <- data %>% rbind(dfSele) %>% group_by(carro) %>% mutate(
        cantidad = n()
      ) %>% mutate(
        color_paint = ifelse(cantidad == 1, color_paint, "#00FF00") 
      ) %>% ungroup() %>% unique()
      
      data %>% write.csv("datos.csv" , row.names=FALSE)
      
      output$plot_click_options <- renderPlot({
        cat("grafico ")
        plot(data$wt, data$mpg, xlab="wt", ylab = "millas por galon", col=data$color_paint )
      })
      
      output$mtcars_tbl <- renderTable({
        df <- data %>% filter(color_paint != "#000000")
        df 
      })
    })
    
    observeEvent(input$mouse_hover,{
      cat("actualizar")
      data <- read.csv("datos.csv")
      
      dfSele <- nearPoints(data, input$mouse_hover, xvar ="wt", yvar = "mpg") 
      
      data <- data %>% rbind(dfSele) %>% group_by(carro) %>% mutate(
        cantidad = n()
      ) %>% mutate(
        color_paint = ifelse(cantidad == 1, color_paint, "#AAAAAA") 
      ) %>% ungroup() %>% unique()
      
      data %>% write.csv("datos.csv", row.names=FALSE)
      
      output$plot_click_options <- renderPlot({
        cat("grafico ")
        plot(data$wt, data$mpg, xlab="wt", ylab = "millas por galon", col=data$color_paint )
      })
      
      output$mtcars_tbl <- renderTable({
        df <- data %>% filter(color_paint != "#000000")
        df 
      })
    })
    
    observeEvent(input$mouse_brush,{
      cat("actualizar")
      data <- read.csv("datos.csv") 
      
      dfSele <- brushedPoints(data, input$mouse_brush, xvar ="wt", yvar = "mpg") 
      
      data <- data %>% rbind(dfSele) %>% group_by(carro) %>% mutate(
        cantidad = n()
      ) %>% mutate(
        color_paint = ifelse(cantidad == 1, color_paint, "#00FF00") 
      ) %>% ungroup() %>% unique()
      
      data %>% write.csv("datos.csv", row.names=FALSE)
      
      output$plot_click_options <- renderPlot({
        cat("grafico ")
        plot(data$wt, data$mpg, xlab="wt", ylab = "millas por galon", col=data$color_paint )
      })
      
      output$mtcars_tbl <- renderTable({
        df <- data %>% filter(color_paint != "#000000")
        df 
      })
    })
    
    observeEvent(input$dclk,{
      cat("actualizar")
      data <- mtcars %>% mutate(
        color_paint =  "#000000",
        cantidad = 1,
        carro = rownames(mtcars)
      ) %>% unique()  
      
      data %>% write.csv("datos.csv", row.names=FALSE)
      
      output$plot_click_options <- renderPlot({
        cat("grafico ")
        plot(data$wt, data$mpg, xlab="wt", ylab = "millas por galon", col=data$color_paint )
      })
      
      output$mtcars_tbl <- renderTable({
        df <- data %>% filter(color_paint != "#000000")
        df 
      })
    })
    
    
    
    output$click_data <- renderPrint({
      list(
        click_xy = c(input$clk$x,  input$clk$y),
        double_click_xy = c(input$dclk$x,  input$dclk$y),
        hover_xy = c(input$mouse_hover$x,  input$mouse_hover$y),
        brush_xy = c(input$mouse_brush$xmin,  input$mouse_brush$ymin,
                     input$mouse_brush$xmax,  input$mouse_brush$ymax)
      )
    })
    
    
  
  
  
 
  
})
