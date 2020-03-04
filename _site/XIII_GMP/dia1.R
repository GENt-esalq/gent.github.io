#########################
# Script Curso R

# Data: 23/07/2019
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
=
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