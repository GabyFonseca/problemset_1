##Gabriela Fonseca Rodríguez
##Codigo:202012093

##PROBLEM SET 1

#Limpiar el entorno
rm(list=ls())

##Version de R 
R.version.string

##1. VECTORES
vector_1 <- c(1:100) 
vector_2 <- seq(1,99,by=2)
vector_3 <- vector_2+1

##IMPORTAR/EXPORTAR LA BASE DE DATOS
require(rio) ##Libreria necesaria para importar bases de datos

#Importar bases de datos
data_personas = import(file="input/Enero - Cabecera - Caracteristicas generales (Personas).csv")
data_ocupados = import(file="input/Enero - Cabecera - Ocupados.csv")

#Exportar base de datos 
export(data_personas, "output/Características generales (Personas).rds")
export(data_ocupados, "output/Ocupados.rds")





