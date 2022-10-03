##Gabriela Fonseca Rodríguez
##Codigo:202012093

##PROBLEM SET 1

#Limpiar el entorno
rm(list=ls())
##Salida de R :[1] "R version 4.2.1 (2022-06-23 ucrt)"

##Version de R 
R.version.string

## instalar/llamar pacman
require(pacman)
p_load(rio, dplyr, ggplot2)

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
data =full_join(data_ocupados, data_personas, by=c("SECUENCIA_P","ORDEN", "HOGAR", "DIRECTORIO"))

##6.DESCRIPTIVAS DE UN CONJUNTO DE DATOS

##Tabla_1. Ingreso segun sexo y departamento. Como es el salario discriminando entre mujeres y hombres, teniendo en cuenta tambien el departamento de donde son 
data %>% 
  group_by(P6020, DPTO.y) %>%
  summarise(prom_inglabo = mean(INGLABO, na.rm=T))

##Tabla_2. Ingreso segun sexo y tipo de contrato
data %>% 
  group_by(P6020, P6920) %>%
  summarise(prom_contrato=mean(INGLABO, na.rm=T))

##Tabla_3. Descritivas de Salario, con ello podemos comparar con las condicionales como cambia el promedio de el ingreso en general vs discriminado por las descritivas condicionales como por sexo
summary(data[,c("INGLABO")])

##Grafica_1
ingresos_edad <- data %>% filter(P6040>18 & P6040<70)%>%
  group_by(P6040) %>% 
  summarise(ingresos = mean(INGLABO, na.rm = T)) %>% 
  ggplot(data=. , mapping = aes(x = as.factor(P6040) , y = ingresos, fill = as.factor(P6040))) + 
  geom_bar(stat = "identity") 

ingresos_edad  +
  labs(x = "edad") + 
  theme_classic()

##Grafica_2
ingresos_pension <- data %>% 
  group_by(P6920) %>% 
  summarise(ingresos = mean(INGLABO, na.rm = T)) %>% 
  ggplot(data=. , mapping = aes(x = as.factor(P6920) , y = ingresos, fill = as.factor(P6920))) + 
  geom_bar(stat = "identity") 

ingresos_pension  +
  scale_fill_manual(values = c("1"="#76EEC6" , "2"="#BF3EFF", "3"="#FFE1FF") , label = c("1"="Cotizando" , "2"="No cotizando", "3"="Pensionado") , name = "Cotizante") +
  labs(x = "Cotizante") + 
  theme_classic()

##Grafica_3
Ingreso_edad_sexo = ggplot(data , mapping = aes(x = P6040 , y = INGLABO, group=as.character(P6020), color=as.character(P6020))) +
  geom_point( size = 0.7)

Ingreso_edad_sexo + scale_color_manual(values = c("2"="slateblue1" , "1"="#EE7600") , label = c("1"="Hombre" , "2"="Mujer") , name = "Sexo")








