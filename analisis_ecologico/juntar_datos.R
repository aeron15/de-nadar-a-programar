library(readxl)
library(dplyr)
library(janitor)
library(ggplot2)
library(magrittr)
library(tidyr)

# leer hojas excel --------------------------------------------------------

datos_pacifico <- '/Users/Renan/Documents/repositories/de_nadar_a_programar/datos/pacifico.xlsx' %>% read_excel(sheet = 4, skip = 1) %>% clean_names() %>% rename(codigo = código)

datos_golfo <- '/Users/Renan/Documents/repositories/de_nadar_a_programar/datos/golfo_california.xlsx' %>% read_excel(sheet = 3, skip = 1) %>% clean_names()


tmp1 <- datos_golfo %>% rename(localidad = sitio_oficial, total = abundancia) %>% dplyr::select(localidad, especie, total, biomasa, densidad) %>% mutate(region = 'golfo')
  
tmp2 <- datos_pacifico %>% dplyr::select(localidad, especie, total, biomasa, densidad) %>% mutate(region = 'pacifico')

datos_df <- rbind(tmp1, tmp2)

# plotear datos -----------------------------------------------------------

datos_df %>% ggplot(aes(x=localidad, y = densidad )) + geom_bar(stat = 'identity') + theme(axis.text.x = element_text(angle = 90, hjust = 1))

# datos_df %<>% slice(complete.cases(datos_df))

# arreglar datos para conseguir varias columnas ---------------------------

tmp1 <- datos_golfo %>% gather(rango, total_rango, 15:32) %>% filter(!is.na(total_rango)) %>% rename(localidad = sitio_oficial, total = abundancia) %>% dplyr::select(localidad, especie, total, biomasa, densidad, rango, total_rango) %>% mutate(region = 'golfo')

tmp2 <- datos_pacifico %>% gather(rango, total_rango, 12:30) %>% filter(!is.na(total_rango)) %>% dplyr::select(localidad, especie, total, biomasa, densidad, rango, total_rango) %>% mutate(region = 'pacifico')

datos_df <- rbind(tmp1, tmp2)

datos_df %>% ggplot(aes(x=localidad, y = densidad )) + geom_bar(stat = 'identity') + theme(axis.text.x = element_text(angle = 90, hjust = 1)) + facet_grid( . ~ especie)

# Abundancia por especie

datos_df %>% ggplot(aes(x=localidad, y = densidad )) + geom_bar(stat = 'identity') + theme(axis.text.x = element_text(angle = 90, hjust = 1)) + facet_wrap(~ especie)
