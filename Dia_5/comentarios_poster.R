datos_df<- read_tsv("../datos/datos_arrecifes_especies.tsv")

orden_latitud <- datos_df %>% select(localidad, latitud) %>% arrange(latitud) %>% distinct()

orden_latitud$latitud[orden_latitud$localidad == "huatulco_pa"] = 15.3


orden_latitud %<>% arrange(latitud)

# datos_df$localidad <- factor(datos_df$localidad, levels = orden_latitud$localidad)

datos_df$localidad <- as.factor(datos_df$localidad)

datos_df$localidad <- factor(datos_df$localidad, levels = c('huatulco_pa','acapulco','ixtapa','caleta_de_campos','revillagigedo','manzanillo','isabel','islas_marias','los_cabos','cabo_pulmo','isla_cerralvo','espiritu_santo','el_portugues','bajo_seco_sur','el_cayo','las_animas','isla_san_diego','isla_santa_cruz','isla_san_mateo','isla_el_farallon','bajo_seco_norte','loreto','punta_pulpito','isla_san_idelfonso','isla_san_marcos','isla_tortuga','isla_san_pedro_nolasco','isla_san_pedro_martir','san_francisquito','isla_san_lorenzo','isla_san_esteban','isla_tiburon','isla_patos','isla_angel_de_la_guarda','bahia_san_luis_gonzaga','puerto_libertad','puerto_lobos'))

datos_df %>% ggplot(aes(x=localidad,y=densidad)) + geom_bar(stat='identity') + theme(axis.text.x = element_text(angle = 90, hjust = 1))


