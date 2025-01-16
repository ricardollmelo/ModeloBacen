# Instalar e carregar pacotes necessários
if (!require("mFilter")) install.packages("mFilter", dependencies = TRUE)
library(mFilter)

# Carregar os dados do PIB
# Substitua "sua_serie_pib" pelo nome do seu arquivo ou vetor com os dados do PIB.
# Exemplo fictício de série:
# sua_serie_pib <- c(100, 102, 105, 110, ...) 

# Importar a série de dados do PIB, se estiver em um arquivo CSV
# dados <- read.csv("caminho_para_seu_arquivo.csv")
# sua_serie_pib <- dados$PIB

# Aplicar o filtro HP
lambda <- 1600  # Lambda recomendado para séries trimestrais
filtro_hp <- hpfilter(pib$PIB, freq = lambda)

# Obter o PIB potencial e o hiato do produto
pib_potencial <- filtro_hp$trend
hiato_do_produto <- (pib$PIB - pib_potencial) / pib_potencial * 100

# Visualizar resultados
print("PIB Potencial:")
print(pib_potencial)
print("Hiato do Produto (%):")
print(hiato_do_produto)

# Plotar resultados
plot.ts(pib$PIB, col = "blue", lwd = 2, main = "PIB Real e PIB Potencial (Filtro HP)", ylab = "PIB", xlab = "Tempo")
lines(pib_potencial, col = "red", lwd = 2)
#legend("topleft", legend = c("PIB Real", "PIB Potencial"), col = c("blue", "red"), lty = 1, lwd = 2)

plot.ts(hiato_do_produto, col = "purple", lwd = 2, main = "Hiato do Produto (%)", ylab = "Hiato (%)", xlab = "Tempo")
abline(h = 0, col = "black", lty = 2)



# Instalar e carregar o pacote necessário para exportar para Excel
if (!require("writexl")) install.packages("writexl", dependencies = TRUE)
library(writexl)

# Gerar os dados do hiato do produto como no código anterior
# Aqui, assumimos que o cálculo do hiato já foi feito
# Certifique-se de ter a série `hiato_do_produto` pronta

# Criar um data frame com os resultados
resultados <- data.frame(
  Tempo = seq_along(hiato_do_produto),  # Substitua pelo seu índice temporal (ex: trimestres)
  PIB_Real = pib$PIB,
  PIB_Potencial = pib_potencial,
  Hiato_do_Produto = hiato_do_produto
)

# Exportar para um arquivo Excel
write_xlsx(resultados, "hiato_do_produto.xlsx")

# Mensagem de sucesso
cat("O arquivo 'hiato_do_produto.xlsx' foi salvo no diretório de trabalho atual.\n")

# Verificar o diretório atual (caso você precise localizar o arquivo)
getwd()
