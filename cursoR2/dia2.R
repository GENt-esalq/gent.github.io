#########################
# Script Curso R

# Data: 18/03/2020
# GENt
#########################

# Exportando e importando dados

# Salvo meu objeto campo1
save(campo1, file = "campo1.RData")


# Removo o objeto
rm(campo1)  # Certifique-se que salvou o objeto antes de removê-lo


# Chamo ele de novo
load("campo1.RData")

save.image() #salva um .RData no meu diretório de trabalho
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