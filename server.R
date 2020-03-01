function(input, output, session) {
  
  dados <- reactive({ 
    
    gastos <- camara %>%
      filter(congressperson_name==input$parl,subquota_description==input$tipo) %>% 
      select(supplier,total_net_value,cnpj_cpf) 
    
    
    fornecedores <- gastos %>%
      select(cnpj_cpf) %>%
      unique() %>% 
      pull()
    
    dadosx <- gastos %>% 
      mutate(sem="DENSIDADE COMPLETA") %>% 
      select(-cnpj_cpf,-supplier)
    
    for(i in fornecedores){

      dadosx=bind_rows(dadosx, gastos %>% 
                        filter(cnpj_cpf!=i) %>% 
                        mutate(sem=sample(gastos %>% filter(cnpj_cpf==i) %>% select(supplier) %>% unique() %>% pull,1))) %>% 
        select(-cnpj_cpf,-supplier)
    }
    dadosx
  })
  
  
  
  
  
  
  
  output$densidades=renderPlotly({
    ggplotly(ggplot(data=dados(),aes(total_net_value))+
               geom_density(aes(colour=sem))+
               theme_bw()
             # +
             #   theme(legend.position = "none")
             )
  })
  
  datasetInput <- reactive({
    
    camara %>%
      filter(congressperson_name==input$parl,subquota_description==input$tipo) %>% 
      select(Valor_Reembolsado=total_net_value,Tipo_de_gasto=subquota_description,Fornecedor=supplier,cnpj_cpf,Data=issue_date) %>% 
      datatable()

  })
  
  output$tabela <- renderDT(
    datasetInput(), # data
    class = "display nowrap compact", # style
    filter = "top"
    )
  
}
