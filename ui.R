if (!require("pacman")) install.packages("pacman") # https://shiny.rstudio.com/ Aiuda
pacman::p_load(readr, readxl,dplyr, tidyverse, janitor, ggplot2, forcats,  ggthemes, shiny, shinythemes)

Sys.setlocale("LC_ALL", "es_ES.UTF-8") 
options(scipen=9999) 

library(readr)
library(readxl)
library(janitor)
library(tibble)
library(readxl)
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggthemes)
library(forcats)
library(shiny)
library(shinythemes)

# Cargar y filtrar datos

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


shinyUI(fluidPage(
  
  titlePanel("Análisis de Coherencia para Estados de México"),
  
  sidebarLayout(
    
    sidebarPanel( 
      
      selectInput("estado", "Seleccione un estado",
                choices = unique(cmex$estado))
    ),
  mainPanel(
    tabsetPanel(type = "tabs",
                tabPanel("Graf1", plotOutput("Graf1")),
                tabPanel("Graf2", plotOutput("Graf2")),
                tabPanel("Graf3", plotOutput("Graf3")))
    )
  )))
    
