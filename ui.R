dashboardPage(
    
    dashboardHeader(title = "Pedidos de reembolso dos deputados federais brasileiros"
    ),
    
    dashboardSidebar( sidebarMenu(
        # menuItem("Barplot", tabName = "bar", icon = icon("bar-chart", lib = "font-awesome")),
        # menuItem("Tabela", tabName = "tabela", icon = icon("table",lib = "font-awesome")),
        menuItem("Reembolsos", tabName = "dash", icon = icon("search dollar",lib = "font-awesome"))
    )
    ),
    
    dashboardBody(
        tabItems(
            tabItem(tabName = "dash",
                    fluidRow(
                        box(width = 12,height = 100,status = "warning", title = "DIGITE O NOME DO DEPUTADO FEDERAL:",
                            background = "light-blue",
                            selectInput("parl",label = NULL, choices =unique(as.character(camara$congressperson_name)),selected=sample(unique(as.character(camara$congressperson_name)),1))),
                        box(width = 12,height = 100,status = "warning", title = "SELECIONE O TIPO DE GASTO",
                            background = "light-blue",
                            selectInput("tipo",label = NULL, choices =unique(as.character(camara$subquota_description),selected=sample(unique(as.character(camara$subquota_description)),1))),
                            box(status = "warning",title="Distribuição de gastos ao se remover determinada empresa",width = 12,
                                plotlyOutput('densidades'))
                            
                        )
                        
                    )
            )
        )
    )
    #https://rstudio.github.io/shinydashboard/structure.html#mixed-row-and-column-layout
)