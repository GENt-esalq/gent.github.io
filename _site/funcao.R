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
