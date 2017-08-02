# Load in all the packages we need for the full post
library(cshapes)
library(tidyverse)
library(forcats)
library(scales)
library(openxlsx)
library(directlabels)
library(ggthemes)
library(RColorBrewer)
library(countrycode)
library(maps)
library(viridis)
library(leaflet)
library(rworldmap)
library(sf)
library(maptools)

list.of.packages <- c("cshapes",
"tidyverse",
"forcats",
"scales",
"openxlsx",
"directlabels",
"ggthemes",
"RColorBrewer",
"countrycode",
"maps",
"viridis",
"leaflet",
"rworldmap",
"sf",
"maptools",
"fields")

(new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])])
if(length(new.packages)) install.packages(new.packages)
#------------download------------
tf <- tempfile()

download.file("https://www.sipri.org/sites/default/files/SIPRI-Milex-data-1949-2016.xlsx",
              destfile = tf, mode = "wb")

#---------------import and tidy----------
sipri <- read.xlsx(tf, sheet = "Share of GDP", startRow = 6) %>%
  gather(Year, Value, -Country, -Notes) %>%
  mutate(Value = as.numeric(Value),
         Year = as.numeric(Year)) %>%
  filter(!is.na(Value))

#----------------exploratory chart-----------
sipri %>%
  ggplot(aes(x = Year, y = Value, colour = Country)) +
  geom_line() +
  theme(legend.position = "none") +
  scale_y_continuous("Military expenditure as a percentage of GDP", label = percent) +
  ggtitle("Countries' and regions' expenditure on military as a percentage of GDP") +
  labs(caption = "Source: Stockholm International Peace Research Institute", x = "")