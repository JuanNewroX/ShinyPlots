library(shiny)
library(stringr)

shinyServer(function(input, output) {
  
  archivo_cargado <- reactive({
    contenido_archivo <- input$cargar_archivo
    if(is.null(contenido_archivo)){
      return(NULL)
    } else if(str_detect(contenido_archivo$name, '.csv')){
      out <- readr::read_csv(contenido_archivo$datapath)
      return(out)
    } else if(str_detect(contenido_archivo$name, '.tsv')){
      out <- readr::read_tsv(contenido_archivo$datapath)
      return(out)
    } else{
      out <- data_frame(nombre_aerchivo = contenido_archivo$name, 
        error = "Extension de archivo no soportada")
      return(out)
    }
  })
  
  out_dataset <- reactive({
    if(is.null(archivo_cargado())){
      return(NULL)
    }
    archivo_cargado() %>% filter(Date >=  input$rango_fechas[1],
                                 Date <=  input$rango_fechas[2])
    
  })
  
  output$contenido <- DT::renderDataTable(
    out_dataset() %>% DT::datatable()
  )
  
  output$download_dataframe <- downloadHandler(
    filename = function(){
      paste0("data", Sys.Date(), ".csv")
    },
    content = function(file){
      readr::write_csv(out_dataset(), file)
    }
    
  )

})
