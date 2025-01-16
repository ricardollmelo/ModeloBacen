
# Instalar pacotes necessários

install.packages("mFilter")
library(mFilter)
library(dplyr)
library(openxlsx)



# Aplicar o filtro HP ao resultado primário mensal
hp_filter <- hpfilter(RPPIB$ResultadoPrimario, freq = 14400)

# Extrair a tendência e o ciclo
tendencia <- hp_filter$trend
ciclo <- RPPIB$ResultadoPrimario - tendencia

# Dividir o desvio da tendência pelo PIB mensal
desvio_por_pib <- ciclo / RPPIB$PibMensal

# Adicionar os resultados ao dataset original
dataset <- RPPIB %>%
  mutate(tendencia = tendencia,
         ciclo = ciclo,
         desvio_por_pib = desvio_por_pib)

# Visualizar o resultado
print(dataset)

setwd("C:/Users/ricar/OneDrive/Documentos/Materiais_Economia/Modelo_Pequeno_Porte_BC/1.Dados")

DatasetModificado <- dataset %>%
  mutate(
    across(where(is.numeric), ~ formatC(., format = "f", decimal.mark = ",", big.mark = "."))
  )

write.xlsx(DatasetModificado, file = "6.RP_SOBRE_PIB.xlsx")






