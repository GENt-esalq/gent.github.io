#########################
# Script Curso R

# Data: 20/03/2020
# GENt
#########################


# obtendo o data.frame que contém os dados que queremos usar
info = read.csv("info_pessoal.csv", stringsAsFactors = FALSE)

# ver as primeiras linhas de um objeto
head(info)


library(ggplot2)

# para cada camada de informação, usaremos uma nova função separada por "+"
ggplot(info) + 
  geom_point(aes(x = peso, y = altura))

# vamos adicionando novas informações
ggplot(info) + 
  geom_point(aes(x = peso, y = altura, color = genero))

# mas tomar cuidado para não ter tanta informação demais
ggplot(info) + 
  geom_point(aes(x = peso, y = altura, color = genero, size = idade, shape = escolaridade))

# legendas
ggplot(info) + 
  geom_point(aes(x = peso, y = altura, color = genero)) +
  labs(title = "Meu primeiro scatter plot", x = "Peso (kg)", y = "Altura (m)", color = "Gênero")

ggplot(info) + 
  geom_point(aes(x = peso, y = altura, color = genero)) +
  labs(title = "Meu primeiro scatter plot", x = "Peso (kg)", y = "Altura (m)", color = "Gênero") +
  scale_color_manual(values = c("#F1290A", "#55BB29"))

ggplot(info) + 
  geom_point(aes(x = peso, y = altura, color = genero)) +
  labs(title = "Meu primeiro scatter plot", x = "Peso (kg)", y = "Altura (m)", color = "Gênero") +
  scale_color_manual(values = c("#F1290A", "#55BB29")) +
  theme_light() +
  theme(legend.position = "bottom") 

# IMC
# Alternativa 1: uma escala de IMC
IMC.numerico = function(m, h){
  m/h^2
}

ggplot(info) + 
  geom_point(aes(x = peso, y = altura, color = IMC.numerico(peso, altura))) +
  labs(x = "Peso (kg)", y = "Altura (m)", color = "IMC") +
  scale_color_continuous(low = "blue", high = "red")

# Alternativa 2: categorias de IMC
IMC.categorico = function(m, h){
  imc = IMC.numerico(m, h)
  for (i in 1:length(imc)) {
    if(imc[i] < 18.5) {
      return("Magreza")
    } else if(imc[i] < 25) {
      return("Normal")
    } else if(imc[i] < 30) {
      return("Sobrepeso")
    } else if(imc[i] < 40) {
      return("Obesidade")
    } else {
      return("Obesidade grave")
    }
  }
}

ggplot(info) + 
  geom_point(aes(x = peso, y = altura, color = IMC.categorico(peso, altura))) +
  labs(x = "Peso (kg)", y = "Altura (m)", color = "IMC")


# GENERO
# posição: empilhamento
ggplot(info) + 
  geom_bar(aes(x = graduacao, fill = genero)) +
  labs(x = element_blank(), y = "Contagem", fill = "Gênero")

# posição: esquivando
ggplot(info) + 
  geom_bar(aes(x = graduacao, fill = genero), position = "dodge") +
  labs(x = element_blank(), y = "Contagem", fill = "Gênero")

# AREA DE INTERESSE
# posição: empilhamento
ggplot(info) + 
  geom_bar(aes(x = graduacao, fill = area)) +
  labs(x = element_blank(), y = "Contagem", fill = "Área de interesse") +
  coord_flip()

# posição: esquivando
ggplot(info) + 
  geom_bar(aes(x = graduacao, fill = area), position = "dodge") +
  labs(x = element_blank(), y = "Contagem", fill = "Área de interesse") +
  coord_flip()


# facet_wrap
ggplot(info) +
  geom_bar(aes(x = graduacao, fill = genero)) +
  labs(x = element_blank(), y = "Contagem", fill = "Gênero") +
  facet_wrap(~ area) + coord_flip()

ggplot(info) +
  geom_bar(aes(x = graduacao, fill = area)) +
  labs(x = element_blank(), y = "Contagem", fill = "Área de interesse") +
  facet_wrap(~ genero) + coord_flip()


# alterando o número de bins
ggplot(info) +
  geom_histogram(aes(x = altura), bins = 10) +
  labs(x = "Altura", y = "Contagem")

ggplot(info) +
  geom_histogram(aes(x = altura), bins = 20) +
  labs(x = "Altura", y = "Contagem")

# alterando a largura das bins
ggplot(info) +
  geom_histogram(aes(x = altura), binwidth = 0.1) +
  labs(x = "Altura", y = "Contagem")

ggplot(info) +
  geom_histogram(aes(x = altura), binwidth = 0.3) +
  labs(x = "Altura", y = "Contagem")


# densidades
ggplot(info) +
  geom_density(aes(x = altura)) +
  labs(x = "Altura", y = "Densidade")

ggplot(info) +
  geom_density(aes(x = altura)) +
  geom_point(aes(x = altura, y = 0.1), shape = "|", size = 10) +
  labs(x = "Altura", y = "Densidade")

# boxplot
ggplot(info) +
  geom_boxplot(aes(x = escolaridade, y = conhecimentoR)) +
  labs(x = element_blank(), y = "Conhecimento prévio em R")

ggplot(info) +
  geom_violin(aes(x = area, y = conhecimentoR)) +
  labs(x = element_blank(), y = "Conhecimento prévio em R")


# PCA
# para instalar, use install.packages("ggfortify")
library(ggfortify)

autoplot(prcomp(~ conhecimentoR + altura + peso + idade, data = info),
         data = info, shape = 'area', colour = 'graduacao', loadings = TRUE, loadings.colour = 'red', 
         loadings.label = TRUE, loadings.label.colour = 'black',
         loadings.label.size = 4) +
  labs(shape = "Área de \ninteresse", color = "Formação", title = "PCA")


# Mapa
library(tidyverse)

# Coletando os dados da base por estado
estados = brazilmaps::get_brmap("State")

# Adicionando uma coluna com as siglas dos estados, será importane para a próxima etapa
estados$sigla = c("RO", "AC", "AM", "RR", "PA", "AP", "TO", "MA", "PI", "CE", "RN", "PB", "PE", "AL", "SE", "BA", "MG", "ES", "RJ", "SP", "PR", "SC", "MS", "MT", "GO", "DF", "RS")

# Aqui, estamos pegando as duas últimas letras da cidade de origem da pessoa,
# se ela tiver preenchido corretamente, estas últimas serão o estado, como em
# "Piracicaba - SP". Após isto, fazemos a contagem de pessoas por estado e 
# unimos com os dados do brazilmaps
estados = info %>%
  mutate(sigla = str_sub(cidade, nchar(cidade)-1, nchar(cidade))) %>%
  group_by(sigla) %>%
  summarise(n = n()) %>%
  right_join(estados, by = "sigla")

# Aqui usamos um outro tipo de plot, o geom_sf(), que precisa de dados de
# coordenadas geométricas para construir os mapas. O resto envolve apenas
# funções e argumentos que nós conhecemos!!!
ggplot(estados) +
  geom_sf(aes(geometry = geometry, fill = n)) + 
  theme_minimal() + scale_fill_continuous(low = "gray40", high = "red") +
  labs(fill = "Número \nde pessoas")
