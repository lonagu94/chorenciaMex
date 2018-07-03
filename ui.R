if (!require("pacman")) install.packages("pacman") # https://shiny.rstudio.com/       Aiuda
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

shinyUI(fluidPage(theme = shinytheme("sandstone"),
  
  titlePanel("Análisis de Coherencia para Estados de México"),
  
  sidebarLayout(
    
    sidebarPanel( 
      
      selectInput("estado", "Seleccione un estado",
                choices = unique(cmex$estado)),       
      img(src="https://cidecyd.files.wordpress.com/2015/02/logolnpp-01.jpg", height = 150, width = 170),
      br(),
      br(),
      p("Laboratorio Nacional de Políticas Públicas")
    ),
  mainPanel(
    tabsetPanel(type = "tabs",
                tabPanel("Graf1", plotOutput("Graf1")),
                tabPanel("Graf2", plotOutput("Graf2")),
                tabPanel("Graf3", plotOutput("Graf3")))
    )
  )))
    
