
shinyUI(fluidPage(
    titlePanel("Interacciones del usuario con graficas"),
    tabsetPanel(
        tabPanel('Graficas shiny ejemplo', 
            h1("Graficas en Shiny"),
            plotOutput("grafica_base_r"),
            plotOutput("grafica_ggplot")
        ),
        tabPanel('Interacciones con plots', 
            plotOutput("plot_click_options",
                       click = "clk",
                       dblclick = "dclk",
                       hover="mouse_hover",
                       brush = "mouse_brush"),
            verbatimTextOutput("click_data"),
            tableOutput("mtcars_tbl")
        )
    )
))
