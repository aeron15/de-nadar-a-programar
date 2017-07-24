ggplot(datos_ALS, aes(x=edad,y=progresion))+geom_point()

# Separar por tipo de enfermedad
ggplot(datos_ALS, aes(x=edad,y=progresion))+geom_point()+facet_wrap(~tipo_ALS)

# Separar por tipo de enfermedad y genero
ggplot(datos_ALS, aes(x=edad,y=progresion))+geom_point()+facet_grid(genero~tipo_ALS)

# Marcar todos los pacientes

sp<-ggplot(datos_ALS, aes(x=edad,y=progresion))+geom_point()
sp + geom_text(aes(label=pacientes), size=4, hjust=0)


# Marcar los pacientes que son mujeres

datos_ALS$es_mujer<-datos_ALS$genero=="mujer"
datos_ALS$nombre_mujer<-datos_ALS$pacientes
datos_ALS$nombre_mujer[!datos_ALS$es_mujer]<-NA

sp<-ggplot(datos_ALS, aes(x=edad,y=progresion))+geom_point()
sp + geom_text(aes(label=nombre_mujer), size=4, hjust=0)

#Visualizar de los efectos dependiendo del paciente
ggplot(efecto_medicina_ALS, aes(x=efecto, fill=paciente))+geom_density(alpha=0.3) 

#Ajustar la cuenta del progreso
ggplot(datos_ALS, aes(x=progresion))+geom_density()+facet_grid(genero~tipo_ALS)

# Ver los histogramas y el smooth
ggplot(datos_ALS, aes(x=progresion, y=..density..))+
  geom_histogram(fill="cornsilk", colour="grey60", size=.2)+
  geom_density()+
  facet_grid(genero~tipo_ALS)
