library(tidyverse)
library(readxl)
library(magrittr)
library(janitor)
library(lubridate)

datos1 <- '/Users/Renan/Documents/personal/Clubes_Ciencia/EN2_Database.xlsx' %>% read_excel(sheet = 3, skip = 1) %>% clean_names() %>% rename(codigo = código)

# Remove empty rows
datos1 %<>% slice(which(!is.na(datos1$codigo)))

# To load all sheets in a workbook, use lapply
path <- '/Users/Renan/Documents/personal/Clubes_Ciencia/EN2_Database.xlsx'
# path <- system.file("extdata/datasets.xls", package = "readxl")
tmp <- lapply(excel_sheets(path), read_excel, path = path)

# Use lubridate to fix the dates on this file
# Ask what is the distrubtion of species

# En el caso de peces tenemos unos parámetros a y b para calcular la biomasa a partir de las tallas tomadas en campo mediante la ecuación P= aLb , en el caso de los invertebrados tenemos su peso promedio para calcular la biomasa, y para todas las especies tenemos la información de nivel trófico, talla máxima y su taxonomía, en caso de que queramos calcular algunos índices de diversidad basados en esa información.

# datos <- tmp[3]

# EDA  --------------------------------------------------------------------

# Cual es la distribución de especies

datos1 %>% ggplot(aes(x=codigo)) + geom_histogram(stat = "count")

# Cuáles son las especies identificadas

datos1 %>% select(codigo) %>% unique() %>% count()

tmp <- datos1 %>% select(codigo) %>% group_by(codigo) %>% tally() %>% arrange(-n)

tmp %>% slice(1:50) %>% ggplot(aes(x = codigo, y = n)) + geom_col() + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1))

# For the most common species see what the a, l, b distribution is

datos1 %>% slice(1:10) %>% ggplot(aes(x = a, y = b)) + geom_point() + facet_wrap( ~ codigo)

# Hacer un mapa con los datos de cada localidad
# Ver sobre tiempo la abundancia de especies

tmp2 <- datos1 %>% group_by(fecha, codigo) %>% tally()

tmp2 %>% ggplot(aes(x=fecha, y= n, color = codigo)) + geom_line() + geom_point() + theme(legend.position="none") + ggtitle("Abundancia de especies en función del tiempo")
 
datos1 %>% ggplot(aes(x=fecha, y = t_c)) + geom_line() + geom_point() + ggtitle("Cambio de temperatura en función del tiempo")

# Incluir un moving average



# c("#009ACD", "#0000EE", "#C71585", "#FF34B3", "#76EE00")

#  Qué especies se encuentran a que profundidad?
# Qué especies son predictoras de cambios de temperatura
#  Cómo modelar cambios climáticos
# Can we predict species based on the size of the animals?
