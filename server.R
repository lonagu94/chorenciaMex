shinyServer(function(input, output) {
  
  library(ggplot2)
  cmex <- read_excel("~/P_Prof/Scripts/cmex.xlsx", na = "empty")
  
  cmex <- cmex %>%
    clean_names()
  
  cmex$dependencia_responsable <- as.factor(cmex$dependencia_responsable)
  cmex$tipo_de_apoyo_1 <- as.factor(cmex$tipo_de_apoyo_1)
  cmex$cantidad_de_presupuesto_estatal_ejercido <- as.numeric(cmex$cantidad_de_presupuesto_estatal_ejercido)
  cmex$unidad_de_medida_de_los_beneficiarios <- as.factor(cmex$unidad_de_medida_de_los_beneficiarios)
  cmex$derecho_social <- as.factor(cmex$derecho_social)
  cmex$derecho_social_1 <- as.factor(cmex$derecho_social_1)
  cmex$temporalidad_del_apoyo_1 <- as.factor(cmex$temporalidad_del_apoyo_1)
  cmex$numero_total_de_apoyos_otorgados <- as.numeric(cmex$numero_total_de_apoyos_otorgados)
  
  cmex1 <- cmex %>% 
    filter(unidad_de_medida_de_los_beneficiarios != "Familias | Hogares", unidad_de_medida_de_los_beneficiarios != "Localidades")
  
  cmex %>% 
    group_by(estado)
  
  cmex1 %>% 
    group_by(estado)
  
  AA <- reactive({
    cmex %>% 
      filter(estado == input$estado)}
    )
  
  # Primera Gráfica 
  
  output$Graf1 <- renderPlot({
    cmex1 %>% 
    filter(estado == input$estado) %>% 
    group_by(derecho_social) %>% 
    summarise(gast_total_DS = sum(cantidad_de_presupuesto_estatal_ejercido, na.rm = T),
              apoy_total_DS = sum(numero_total_de_apoyos_otorgados, na.rm = T),
              total_benef_DS = sum(numero_total_de_beneficiarios, na.rm = T)) %>% 
    filter(derecho_social != "Medio Ambiente Sano",
           derecho_social != "Vivienda",
           derecho_social != "No Discriminación",
           derecho_social != "Seguridad Social",
           derecho_social != "Trabajo") %>% 
      ggplot() +
      geom_point(mapping = aes(x = apoy_total_DS, y = total_benef_DS,
                               color = derecho_social,
                               size = gast_total_DS,
                               alpha = 0.5)) +
      scale_size("Presupuesto ejercido", range = c(5, 20)) +
      labs(title = paste("Relación entre Número de Beneficiarios, Apoyos otorgados\ny Presupuesto por Derecho Social para", input$estado),
           x = "Total de beneficiarios", 
           y = "Total de apoyos otrogados",
           colour = "Derecho social",
           caption = "Nota: Fueron excluidos aquellos programas cuyo padros de beneficiarios estaba medido por Personas Morales, con el fin de que las cantidades fueran comparables") + 
      theme(plot.title = element_text(hjust = 0.5,
                                      size = 18,
                                      face = "bold"),
            plot.caption = element_text(hjust = 0)) +
      guides(alpha = F)
  })
  
 #Segunda gráfica
  
   output$Graf2 <- renderPlot({
    cmex1 %>% 
      filter(estado == input$estado) %>% 
      filter(derecho_social != "Medio Ambiente Sano",
             derecho_social != "Vivienda",
             derecho_social != "No Discriminación",
             derecho_social != "Seguridad Social",
             derecho_social != "Trabajo") %>% 
      ggplot() +
      geom_jitter(mapping = aes(x = numero_total_de_apoyos_otorgados, y = derecho_social,
                                color = derecho_social,
                                size = cantidad_de_presupuesto_estatal_ejercido,
                                alpha = 0.3)) +
      scale_size("Presupuesto ejercido", range =  c(5,10)) +
      labs(title = "Apoyos otorgados por programa por Derecho Social",
           x = "Número total de apoyos otrogados",
           y = "",
           color = "Derecho social",
           caption = "Nota: Fueron excluidos aquellos programas cuyo Padron de Beneficiarios estaba medido por Personas Morales, con el fin de que las cantidades fueran comparables") + 
      theme(plot.title = element_text(hjust = 0.5, 
                                      size = 18, 
                                      face = "bold"), 
            plot.caption = element_text(hjust = 0, vjust = 1)) +
      guides(alpha = F)
    
  })
   
  # Tercera gráfica 
   
  output$Graf3 <- renderPlot({
    cmex %>%
      filter(estado == input$estado) %>%
      ggplot() + 
      geom_bar(mapping = aes(x = fct_rev(fct_infreq(derecho_social)), # Ordenar de acuerdo con la frecuencia de cada una de las barras (por default las ordena de mayor a menor) y desués revertir el orden. Aquí solo tenemos x, si tuviermos y, usamos reorder (está más abajo)
                             color = derecho_social,
                             fill = derecho_social)) +
      labs(title = "Número de programas por Derecho Social para la Ciudad de México",
           x = " Derecho social", 
           color = "",
           fill = "") +
      theme(plot.title = element_text(hjust = 0.5,
                                      size = 18,
                                      face = "bold"), 
            axis.title.y = element_text(angle = 90, hjust = 0.5, vjust = 0.4),
            axis.title.x = element_blank()) +
      coord_flip() +
      guides(fill = F,
             color = F)
    
    })
 })
