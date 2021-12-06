
shinyUI(fluidPage(
    titlePanel("UI Dinamico"),
    tabsetPanel(
        tabPanel('Ejemplo 1', 
            numericInput("min1", "Limite inferior", value = 5),
            numericInput("max1", "Limite superior", value = 10),
            sliderInput("slider1", "Seleccione intervalo",
                        min = 0, max = 15, value = 5)
        ),
        tabPanel('Ejemplo 2', 
            sliderInput("s1", "Seleccione valor", min = -5, max = 5, value = 0),
            sliderInput("s2", "Seleccione valor", min = -5, max = 5, value = 0),
            sliderInput("s3", "Seleccione valor", min = -5, max = 5, value = 0),
            sliderInput("s4", "Seleccione valor", min = -5, max = 5, value = 0),
            actionButton("reset", "Reiniciar")
        ),
        tabPanel('Ejemplo 3', 
            numericInput("n", "corridos", value = 10),
            actionButton("corridos", "valor")
        ),
        tabPanel('Ejemplo 4', 
                 numericInput("nvalue", "valor", value = 0)),
        tabPanel('Ejemplo 5', 
                 numericInput('celcius', "Temperatura C", value=NA),
                 numericInput('Fare', "Temperatura F", value=NA),
        ),
        tabPanel('Ejemplo 6', 
            br(),
            selectInput("dist", "Seleccione la distribucion",
                        choices = c("Normal","Uniforme", "Exponencial")),
            numericInput("n_random","Cuantos numeros aleatorios", value = 100, min = 0),
            hr(),
            tabsetPanel(
                id="params",
                type="hidden",
                tabPanel("Normal",
                         h1("Distribucion normal"),
                         numericInput("media", "media", value = 0),
                         numericInput("sd", "sd", value = 1),
                         ),
                tabPanel("Uniforme",
                         h1("Distribucion Uniforme"),
                         numericInput("unif_min", "minimo", value = 0),
                         numericInput("unif_max", "maximo", value = 1),
                ),
                tabPanel("Exponencial",
                         h1("Exponencial"),
                         numericInput("razon", "razon", value = 1, min = 0),
                ),
                
            ),
            plotOutput("plot_dist")
        )
    )
))
