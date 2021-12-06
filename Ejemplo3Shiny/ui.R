
shinyUI(fluidPage(
    titlePanel("Tablas en DT"),
    tabsetPanel(
        tabPanel('Tablas DT', 
            h1("Vista basica"),
            DT::dataTableOutput("tabla1"),
            h2("filtros"),
            DT::dataTableOutput("tabla2")
        ),
        tabPanel('Ejemplo 2', 
            fluidRow(
                column(6,
                       h2("Single select row"),
                       DT::dataTableOutput("tabla3"),
                       verbatimTextOutput("output1")),
                column(6,
                       h2("Single multiple row"),
                       DT::dataTableOutput("tabla4"),
                       verbatimTextOutput("output2")),
            ),
            fluidRow(
                column(6,
                       h2("Single select column"),
                       DT::dataTableOutput("tabla5"),
                       verbatimTextOutput("output3")),
                column(6,
                       h2("Single multiple column"),
                       DT::dataTableOutput("tabla6"),
                       verbatimTextOutput("output4")),
            ),
            fluidRow(
                column(6,
                       h2("Single select cell"),
                       DT::dataTableOutput("tabla7"),
                       verbatimTextOutput("output5")),
                column(6,
                       h2("Single multiple cell"),
                       DT::dataTableOutput("tabla8"),
                       verbatimTextOutput("output6")),
            ),
            fluidRow(
                column(6,
                       h2("Single select col row"),
                       DT::dataTableOutput("tabla9"),
                       verbatimTextOutput("output7")),
                column(6,
                       h2("Single multiple col row"),
                       DT::dataTableOutput("tabla10"),
                       verbatimTextOutput("output8")),
            )
        )
    )
))
