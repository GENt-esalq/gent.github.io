#########################
# Script Curso R

# Data: 16/05/2019
# GENt
##########################

cat("Hello world!")

# Depende do seu computador
# setwd("~/Documents/CursoR") 

getwd() # Se tiver perdido

1+1.3                 #Decimal definido com "."
2*3
2^3
4/2

sqrt(4)              #raíz quadrada
log(100, base = 10)  #logarítmo na base 10
log(100)             #logarítmo com base neperiana

# Resolvendo problema 
((13+2+1.5)/3) + log(96, base = 4)

# Pedindo ajuda sobre função do R
?log


# Operação com vetores

# Diferentes formas de criar um vetor
c(1,3,2,5,2) 
1:10
seq(from=0, to=100, by=5)
# ou
seq(0,100,5) # Se você já souber a ordem dos argumentos da função
seq(from=4, to=30, by=3)
rep(3:5, 2)

# Operações
c(1,4,3,2)*2  # Multiplica todos os elementos por 2
c(4,2,1,5)+c(5,2,6,1) # Soma 4+5, 2+2, 1+6 e assim por diante
c(4,2,1,5)*c(5,2,6,1) # Multiplica 4*5, 2*2, 1*6 e assim por diante

# Criando objetos
x = c(30.1,30.4,40,30.2,30.6,40.1)
# ou
x <- c(30.1,30.4,40,30.2,30.6,40.1)

y = c(0.26,0.3,0.36,0.24,0.27,0.35)

# Operações com os objetos
x*2
x + y
x*y
z <- (x+y)/2
z

# Aplicando algumas funções
sum(z)  # soma dos valores de z
mean(z) # média 
var(z)  # variância

# Obtendo valores internos dos objetos por indexação
z[3] # elemento na terceira posição do vetor
z[2:4]

# Para saber algumas características do objeto
str(z)

# Vetor de caracteres
clone <- c("GRA02", "URO01", "URO03", "GRA02", "GRA01", "URO01")

# Vetor de fatores (ou variáveis categóricas)
clone_fator <- as.factor(clone)
str(clone_fator)
levels(clone_fator)
length(clone_fator)

# Vetor lógico
logico <- x > 40
logico   # Os elementos são maiores que 40?

# Indica a posição dos TRUE
which(logico)  # Obtendo as posiçoes dos elementos TRUE

x[which(logico)] # Obtendo os números maiores que 40 do vetor x pela posição

# Para ficar esperto/a
(a <- 1:10)
b <- seq(from = 0.1, to = 1, 0.1)
(b <- b*10)
a==b        # Existe um problema computacional de armazenamento
a==round(b) # Evitar que isso aconteceça arredondando o resultado
?round      # Fiquei com dúvida nessa função

errado <- c(TRUE, "vish", 1) # Não podemos misturar classes num mesmo vetor
errado

######################
# Dia 2
# 17/05/2019
######################


# Matrizes

X <- matrix(1:12, nrow = 6, ncol = 2)
X

W <- matrix(c(x,y), nrow = 6, ncol =2)
W

X*2
X*X        
X%*%t(X)          # Multiplicação matricial

W[4,2] # Número posicionado na linha 4 e coluna 2

colnames(W) <- c("altura", "diametro")
rownames(W) <- clone
W

# Data.frames

campo1 <- data.frame("clone" = clone,     # Antes do sinal de "="  
                     "altura" = x,        # estabelecemos os nomes  
                     "diametro" = y,      # das colunas
                     "idade" = rep(3:5, 2),
                     "corte"= logico) 
campo1

# Acessando a coluna de idades
campo1$idade

# ou
campo1[,4] 

# Especificando linha e coluna
campo1[1,2] 

# Diâmetro do URO03
campo1[3,3] 

# Volume
volume <- 3.14*((campo1$diametro/2)^2)*campo1$altura
volume

# Adicionando volume ao data.frame campo1
campo1 <- cbind(campo1, volume)
str(campo1)

# Listas

minha_lista <- list(campo1 = campo1, media_alt = tapply(campo1$altura, campo1$idade, mean), matrix_ex = W)
str(minha_lista)

# Acessando conteúdo das listas
minha_lista[[1]]
# ou
minha_lista$campo1

# Arrays
(meu_array <- array(1:24, dim = c(2,3,4)))

# Exportando e importando dados

# Salvo meu objeto campo1
save(campo1, file = "campo1.RData")

# Removo o objeto
rm(campo1)  # Certifique-se que salvou o objeto antes de removê-lo

# Chamo ele de novo
load("campo1.RData")

#save.image() #salva um .RData no meu diretório de trabalho

load("campo1.RData")

# Exportando em outros formatos
write.table(campo1, file = "campo1.txt", sep = ";", dec = ".", row.names = FALSE)
write.csv(campo1, file = "campo1.csv", row.names = TRUE)

# Importando tabelas
campo1_txt <- read.table(file = "campo1.txt", sep=";", dec=".", header = TRUE)
campo1_csv <- read.csv(file = "campo1.csv")
head(campo1_txt)
head(campo1_csv)

# Importando a tabela com os dados do formulário
## Se for sistema linux/mac
dados <- read.csv(file = "dados_alunos.csv", stringsAsFactors = FALSE, na.strings="-")
# ou
load("dados_alunos.RData")

## Se for sistema windows
#dados <- read.csv(file = "dados.csv", stringsAsFactors = FALSE, na.strings="-", fileEncoding = "UTF8" )

# Verificando que esta tudo certo
str(dados)
# também
dim(dados)

# Alterando nome das colunas
colnames(dados) <- c("Data_pesq", "Idade", "Niver", "Genero", "Cidade", 
                     "Altura","Peso", "Area", "ConhecimentoR", "Outras_linguagens", 
                     "Utilizacao", "Motivacao")
str(dados)

# Paradoxo do aniversário

table(dados$Niver)

# Estruturas condicionais

## If e else

if(2 >3){
  print("dois é maior que três")
} else {
  print("dois não é maior que três")
}

if(dados[3,9] == 0){
  print("Nunca é tarde para começar!")
} else {
  print("Já pegou o embalo, agora é só continuar!")
}

if(dados[7,9] == 0){
  print("Nunca é tarde para começar!")
} else if (dados[3,9] > 0 && dados[3,9] < 5){
  print("Já pegou o embalo, agora é só continuar!")
} else {
  print("Nos avise se estivermos falando algo errado...hehe")
}

## Switch

switch(dados[5,8],
       Exatas = print("Será que aprendeu alguma linhagem de programação na graduação?"),
       Interdiciplinar = print("Em que foi a gradução?"),
       print("Ta aqui colocando o pezinho na exatas")
)


# Estruturas de repetição

## For

for(i in 1:10){
  print(i)
}

test <- vector()
for(i in 1:10){
  test[i] <- i+4 
}
test

for(i in 1:nrow(dados)){
  if(dados[i,9] == 0){
    print("Nunca é tarde para começar!")
  } else if (dados[i,9] > 0 && dados[i,9] < 5){
    print("Já pegou o embalo, agora é só continuar!")
  } else {
    print("Nos avise se estivermos falando algo errado...hehe")
  }
}

# Exemplo do uso da função grepl
grepl("-", dados[1,5]) # A primeira linha contem o caracter "-"

for(i in 1:nrow(dados)){
  if(grepl("-", dados[i,5])){
    cat("Esse/a seguiu o exemplo direitinho. Parabéns!\n")
  } else {
    cat("Precisamos adicionar mais informações na linha", i, "\n")
  }
}

corrigir <- vector()
for(i in 1:nrow(dados)){
  if(grepl("-", dados[i,5])){
    cat("Esse/a seguiu o exemplo direitinho. Parabéns!\n")
  } else {
    cat("Precisamos adicionar mais informações na linha", i, "\n")
    corrigir <- c(corrigir, i)
  }
}

# Possibilidades de resposta para os exercícios

dados[corrigir,5]
novo <- c("São José dos Campos - SP", "Piracicaba - SP", "São Paulo - SP", "Piracicaba-SP",
          "Uberlância-MG", "Piracicaba-SP", "Uberaba-MG", "São Luis-MA", "Piracicaba-SP",
          "Piracicaba-SP")
dados[corrigir,5] <- novo

# Verificando se corrigiu
dados[,5]


decada <- 2019 - dados$Idade

for(i in 1:length(decada)){
  if(decada[i] > 1960 && decada[i] < 1970){
    print("Nasceu na década de 60")
  } else if(decada[i] >= 1970 && decada[i] < 1980){
    print("Nasceu na década de 70")
  } else if(decada[i] >= 1980 && decada[i] < 1990){
    print("Nasceu na década de 80")
  } else if(decada[i] >= 1990 && decada[i] < 2000){
    print("Nasceu na década de 90")
  } else {
    print("Xóvem")
  }
}

# While 

x <- 1

while(x < 5){
  x <- x + 1
  print(x)
}


## loop infinito (não rodar!)
# x <- 1
# 
# while(x < 5){
#   x + 1
#   print(x)
# }

# Uso do break e do next

x <- 1

while(x < 5){
  x <- x + 1
  if(x==4) break
  print(x)
}

x <- 1

while(x < 5){
  x <- x + 1
  if(x==4) next
  print(x)
}

# Outra estrutura de repetição: repeat

x <- 1
repeat{
  x <- x+1
  print(x)
  if(x==4) break
}

# Loops dentro de loops

# Criando uma matrix vazia
ex_mat <- matrix(nrow=10, ncol=10)

# cada número dentro da matrix será o produto no índice da coluna pelo índice da linha
for(i in 1:dim(ex_mat)[1]) {
  for(j in 1:dim(ex_mat)[2]) {
    ex_mat[i,j] = i*j
  }
}

# Elaboração de funções

## Gerando função quadra (para elevar ao quadrado)

quadra <- function(x){
  z <- x*x
  return(z)
}

quadra(3)
quadra(4)

qualquer_nome <- 4
quadra(qualquer_nome)

## Agora uma função com mais sentido
# Primeiro, como seria se nao fosse uma função

## Calcula o índice de massa corporal (IMC) dos participantes
IMC <- dados$Peso/quadra(dados$Altura)

## Calcula a média das idade dos participantes
id_med <- mean(dados$Idade)

## Calcula a mediana das idades dos participantes
id_median <- median(dados$Idade)

## Calcula a porgentagem de mulheres entre os participantes
mul <- 100*(length(which(dados$Genero == "Feminino"))/length(dados$Genero))

## Faz uma lista com todos os resultados
final_list <- list(IMC=IMC, idade_media = id_med, 
                   idade_mediana = id_median, porcentagem_mulheres = mul)

# Agora na versão função
minha_funcao <- function(df.entrada){
  ## Calcula o índice de massa corporal (IMC) dos participantes
  IMC <- df.entrada$Peso/quadra(df.entrada$Altura)
  
  ## Calcula a média das idade dos participantes
  id_med <- mean(df.entrada$Idade)
  
  ## Calcula a mediana das idades dos participantes
  id_median <- median(df.entrada$Idade)
  
  ## Calcula a porgentagem de mulheres entre os participantes
  mul <- 100*(length(which(df.entrada$Genero == "Feminino"))/length(df.entrada$Genero))
  
  ## Faz uma lista com todos os resultados
  final_list <- list(IMC=IMC, idade_media = id_med, 
                     idade_mediana = id_median, porcentagem_mulheres = mul)
  return(final_list)
  
}

# Rodando
test_list <- minha_funcao(df.entrada = dados)
test_list

# Posso colocar uns avisos

minha_funcao <- function(df.entrada){
  
  if (length(grep("Altura", colnames(df.entrada))) == 0 ||
      length(grep("Peso", colnames(df.entrada))) == 0 ||
      length(grep("Idade", colnames(df.entrada))) == 0 ||
      length(grep("Genero", colnames(df.entrada))) == 0)
    stop("Esta faltando alguma das informações.")
  
  
  ## Calcula o índice de massa corporal (IMC) dos participantes
  IMC <- df.entrada$Peso/quadra(df.entrada$Altura)
  
  ## Calcula a média das idade dos participantes
  id_med <- mean(df.entrada$Idade)
  
  ## Calcula a mediana das idades dos participantes
  id_median <- median(df.entrada$Idade)
  
  ## Calcula a porgentagem de mulheres entre os participantes
  mul <- 100*(length(which(df.entrada$Genero == "Feminino"))/length(df.entrada$Genero))
  
  ## Faz uma lista com todos os resultados
  final_list <- list(IMC=IMC, idade_media = id_med, 
                     idade_mediana = id_median, porcentagem_mulheres = mul)
  return(final_list)
  
}

test_list <- minha_funcao(df.entrada = dados)

dados1 <- dados[,-2] # Removendo coluna de idade

# Rodando isso vai dar bug
# test_list <- minha_funcao(df.entrada = dados1)


