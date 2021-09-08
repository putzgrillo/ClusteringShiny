# x é o conjunto de dados a ser transformado
# logTransform é um parâmetro lógico se aplica transformação logarítimica log(x + 1)
# rangeTransform é um parâmetro lógico se aplica transformação de escala (posição entre máx e mínimo)
funcaoTransformarDados <- function(x, logTransform = T, rangeTransform = T, sufixo = "TRANSF") {
  nomes <- paste(colnames(x), sufixo, sep = "_")
  if (logTransform) {    x <- lapply(x, function(y) { log(y + 1) })  }
  if (rangeTransform) {  x <- lapply(x, function(y) { (y-min(y)) / (max(y)-min(y)) })  }
  names(x) <- nomes
  resultado <- x %>% bind_cols()
return(resultado)
}