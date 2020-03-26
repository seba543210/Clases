##########################################
## Class 02: Review and  Data Management
## Author: Esteban Lopez
## Course: Spatial Analytics 
## Program: Master in Business Analytics
## Institution: Universidad Adolfo Ibáñez
##########################################

#---- Part 1: Review  -------------------

#Estas son las cosas que me gustaría que les queden bien claras

### 1. Sintaxis básica

# Creación de Objetos

x<-NULL   #  objeto vacio en blanco
y<-c(TRUE,FALSE) # 2 elementos concatenados, de formato logico , con la funcion c, 
as.numeric(y) #otorga valores 1 y 0

A<-1
years<-2010:2020
year <- seq(2010,2020, by = 0.5)

tiktoc<-c("Que", "linda", "te ves", "limpiando", "Esperancita")
tiktoc

#numeros_en_texto <- ("1", "2", "3")
#as.numeric(numeros_en_texto)  # convertir string de numeros a numericos




m1<-matrix(1:4,2,2)

m1%*%t(m1)
diag(m1) #diagonal de la matriz

a1<-array(1:12,dim = c(2,2,3))
a1

d1<-data.frame(m1)  #CONVERTIR LA MATRIZ A UN DATA FRAME, DE TODO, NUMEROS Y TEXTO
d1
data("quakes") # promise, DE QUE VA A USAR ESOS DATOS
d1<-data.frame(quakes)

View(d1)  #abre tabla con los datos

ls()

l1<-list(A=A,years,tiktoc,m1) #HACE UNA LISTA CON ESOS ELEMENTOS, EL 1, A�OS, LO QUE TIENE TIKTOC, Y LUEGO LO QUE TIENE M1
A
#LISTAS NO SON MUTABLES, VALORES SON INDEPENDIENTES

# Manipulación de Objetos
ls()

class(A)  # que clase de datos hay en A, es numerico, (o data frame, lista, etc)
typeof(A)  #tipo de, en este caso doble, tiene decimales

A <- 1L #para hacer un entero, es single gracias a la L

length(years)  #largo del objeto, ojala hacerlo con objeto unidimensional

#para mas de 1 dimension, como matrices, usar dim:
dim(m1)
#as�, 2 filas y 2 columnas

#para saber peso del objeto:
object.size(d1)
#puede haber objetos pesados que hagan mas lento la memoria ram
#ir eliminando los no usados, para borrar espacio

View(d1)
names(d1)  #nombres de las variables
head(d1)   # primeras 6 observaciones
tail(d1)  # 6 ultomas observaciones

rm(l1)  #borrar obser

rm(A)  #borra la observacion especifica del ambiente


#Bonus: como se borra todo?

rm(list = ls())  # borrra todo, la lista



# Indexación uso de los [] CON CORCHETTES

length(years)
years[1]

dim(m1)
m1[2,3]  #separa dimensiones con 1 coma
#da la segunda fila, pero 3 est� fuera de limites, es hasta 2
m1[2] 


dim(a1)  #revisar
a1[2,1,3]  #fila, columna, dimesion, osea 10




View(l1)

l1[2]
l1[2][[1]][1:2] #entrega posiciones tambien

l1[[2]][1:2] #otra forma de hacer lo mismo



View(d1)
d1  # 2 dimensiones
d1[1,]   #primera fila de la observacion
d1[,1]
d1[,'lat']  #toda la columna lat

d1$mag[-1]
d1$mag[c(1,3,5)]
d1$mag[seq(1,16,2)]
d1$lat[1:4]


?quakes  #info sobre la base


d1[1:4,c('lat','long')]

d1$mag>5  #entrega true or false si elemento cumple con 
#la condicion

#para contar los true or false
table(d1$mag>5)

d1[d1$mag > 6] #da todas las columnas
d1[d1$mag > 6, 'stations'] #solo columna stations





table(d1$mag>5)
d1[d1$mag>6,]


#generar variables dummies
d1$dummy_5up<-as.numeric(d1$mag>5)
head(d1)

# Distinguir entre funciones, objetos, números y sintaxis básica
# Funciones: palabra + () con argumentos separados por commas
# Objetos: palabras a la izquierda del signo <- 




?Syntax  #para saber los comandos
#R NO ES UN LENGUAJE DE PROGRAMACION ORIENTADO A LA TAREA,
#EST� ORIENTADO AL OBJETO
#STATA O SPSS SON A LA TAREA, QUE MODIFICA BASES Y LE PIDE COSAS

#---- Part 2: Loops  -------------------

A<-2
A

if(A==1){
  print("A es un objeto con un elemento numérico 1")
} else {
  print("A no es igual a 1, pero no se preocupe que lo hacemos")
  A<-1L  #ahora convierte A a 1
}

A

#loop:
for(i in 1:5){
  print(paste("Me le declaro a la ", i))
  Sys.sleep(2)   #duerme el sistema por 2 seg
  print("no mejor no... fail!")
  Sys.sleep(1)
}

#ejemplo: ordenar ventas de un excel a fin de mes
#funciones para leer archivo, creer uno nuevo, y desechar antiguos



i<-1  #define el contador
eps<-50/(i^2)   #define la variable eps
while(eps>0.001){
  eps<-50/(i^2)
  print(paste("eps value es still..", eps))
  i<-i+1
}





#algo algo de parentesis, x(), es para llamar a una funcion







#---- Part 3: Data Management ----
# Tres formas de trabajar con datos


### 1. R-Base 
#http://github.com/rstudio/cheatsheets/raw/master/base-r.pdf

quakes[quakes$mag>6,'mag'] #filtra, da la los casos con magnitud mayor igual a 6

by(data = quakes$mag,INDICES = quakes$stations,FUN = mean)
tapply(X = quakes$mag,INDEX = quakes$stations, FUN = mean)



### 2. tydiverse 
#https://rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf

view(quakes)

library(tidyverse)
#Cómo se instala el paquete si no lo tengo? Tank!!! ayudaaaa!

quakes %>% 
  filter(mag>6) %>%  #filtro sismos mayores a 6
  select(mag)       #solo entrega columna mag

quakes %>% 
  group_by(stations) %>%
  summarise(mean(mag))   #entrega promedio por estacion






### 3. data.table (recommended in this course)
library(data.table)
#https://github.com/rstudio/cheatsheets/raw/master/datatable.pdf

class(quakes) #es un data frame

quakes<-data.table(quakes) 
class(quakes)


quakes[quakes$mag>6,'mag'] #metodo 1


quakes[mag > 6,]

quakes[mag>6,.(mag)]

#quakes[mag>6,.(mag)]



quakes[,mean(mag),by=.(stations)]


#DE ACA, TMB REVISAR MAS

### Reading data from a file

library(readxl)

view(casos)

casos<-data.table(read_excel("Class_02/2020-03-17-Casos-confirmados.xlsx",na = "—",trim_ws = TRUE,col_names = TRUE),stringsAsFactors = FALSE)

casos<-casos[Region=="Metropolitana",]

library(ggplot2)

ggplot(casos[order(Edad,decreasing = T)],)+geom_bar(stat = 'identity' ,aes(x=`Centro de salud`, y=Edad/Edad, group=Sexo, fill=Edad)) + coord_flip()+ facet_wrap(~Sexo) 

casos[Sexo=="Fememino",Sexo:="Femenino"]

ggplot(casos[order(Edad,decreasing = T),])+geom_bar(stat = 'identity',aes(x=`Centro de salud` ,y=Edad/Edad,fill=Edad)) + coord_flip()+ facet_wrap(~Sexo) +labs(title = "Casos Confirmados por Sexo y Establecimiento",subtitle = "Región Metropolitana - 2020-03-17",caption = "Fuente: https://www.minsal.cl/nuevo-coronavirus-2019-ncov/casos-confirmados-en-chile-covid-19/")

