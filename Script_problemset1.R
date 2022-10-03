##Gabriela Fonseca Rodríguez
##Codigo:202012093

##PROBLEM SET 1

#Limpiar el entorno
rm(list=ls())

##Version de R 
R.version.string

## instalar/llamar pacman
require(pacman)
p_load(rio, dplyr)

##1. VECTORES
vector_1 <- c(1:100) 
vector_2 <- seq(1,99,by=2)
vector_3 <- vector_2+1

##2.IMPORTAR/EXPORTAR LA BASE DE DATOS
require(rio) ##Libreria necesaria para importar bases de datos

#Importar bases de datos
data_personas = import(file="input/Enero - Cabecera - Caracteristicas generales (Personas).csv")
data_ocupados = import(file="input/Enero - Cabecera - Ocupados.csv")

#Exportar base de datos 
export(data_personas, "output/Características generales (Personas).rds")
export(data_ocupados, "output/Ocupados.rds")

##3.GENERAR VARIABLES
##Generar variable coupados
data_ocupados$ocupados <- 1

##Generar variable joven 
data_personas$joven <- ifelse(data_personas$P6040>18 & data_personas$P6040<28, yes=1, no=0)

##4..ELIMINAR FILAS/COLUMNAS DE UN CONJUNTO DE DATOS
#De caracteriisticas generales eliminar algunos datos
data_personas %>% filter(P6040>18 & P6040<70)

#Dentro del enunciado dice seleccionar p6920 de caracteristicas pero esta en base de ocupados y se pide 60 50 de ocupado pero esta en base de caracteristicas por lo que se cambian estas dos variables y se ponen en la base donde se encuentran
#De caracteristicas generales seleccione secuencia_p, orden, hogar, directorio, P6020, P6040, P6050, DPTO, fex_c_2011, ESC y MES
data_personas %>% select(SECUENCIA_P, ORDEN, HOGAR, DIRECTORIO, P6020, P6040, P6050 ,DPTO, fex_c_2011, ESC , MES) %>% head(5)

#De ocupados seleccione secuencia_p, orden, hogar, directorio, ocupados, INGLABO, P6920
data_ocupados %>% select(SECUENCIA_P, ORDEN, HOGAR, DIRECTORIO, ocupados, INGLABO, P6920) %>% head(5)

##5.COMBINAR BASE DE DATOS



##6.DESCRIPTIVAS DE UN CONJUNTO DE DATOS



