library(rgdal)     # R wrapper around GDAL/OGR
library(ggplot2)   # for general plotting
library(ggmap)    # for fortifying shapefiles

setwd('~/Documents/repositories/de_nadar_a_programar')
# First read in the shapefile, using the path to the shapefile and the shapefile name minus the
# extension as arguments
# shapefile <- readOGR("Shape/GSHHS_f_L2.shp")
shapefile <- readOGR("Shape/mbtifgw.shp")

# Next the shapefile has to be converted to a dataframe for use in ggplot2
shapefile_df <- fortify(shapefile)

# Now the shapefile can be plotted as either a geom_path or a geom_polygon.
# Paths handle clipping better. Polygons can be filled.
# You need the aesthetics long, lat, and group.
map <- ggplot() +
  geom_path(data = shapefile_df, 
            aes(x = long, y = lat, group = group),
            color = 'black', fill = 'white', size = 1)

print(map) 

# Using the ggplot2 function coord_map will make things look better and it will also let you change
# the projection. But sometimes with large shapefiles it makes everything blow up.
map_projected <- map +
  coord_map()

print(map_projected)

