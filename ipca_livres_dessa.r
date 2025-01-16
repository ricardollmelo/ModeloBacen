# Instalar pacotes necessários
if (!require(seasonal)) install.packages("seasonal")
if (!require(openxlsx)) install.packages("openxlsx")
if (!require(dplyr)) install.packages("dplyr")

library(seasonal)
library(openxlsx)
library(dplyr)

# Criar uma série temporal fictícia (substitua pelos seus dados reais)
ts_data <- ts(dataset$IPCALIVRES, start = c(2018, 1), frequency = 12)

# Aplicar o método X-13ARIMA-SEATS
x13_result <- seas(ts_data)

# Extrair a série dessazonalizada
serie_dessazonalizada <- final(x13_result)

# Trimestralizar os dados pelo método da média
ts_trimestral <- aggregate(ts_data, nfrequency = 4, FUN = mean)
serie_trimestral_dessazonalizada <- aggregate(serie_dessazonalizada, nfrequency = 4, FUN = mean)

# Criar um data frame com os resultados trimestrais
resultados_trimestrais <- data.frame(
  Data = time(ts_trimestral),
  Original_Trimestral = ts_trimestral,
  Dessazonalizada_Trimestral = serie_trimestral_dessazonalizada
)

# Converter para formato brasileiro (números com vírgula como separador decimal)
resultados_trimestrais_br <- resultados_trimestrais %>%
  mutate(
    Original_Trimestral = formatC(Original_Trimestral, format = "f", decimal.mark = ",", big.mark = "."),
    Dessazonalizada_Trimestral = formatC(Dessazonalizada_Trimestral, format = "f", decimal.mark = ",", big.mark = ".")
  )

# Exportar para Excel
write.xlsx(resultados_trimestrais_br, file = "11.IPCA_LIVRES_DESSAZONALIZADOS.xlsx")

# Mensagem de confirmação
print("Os dados foram exportados no formato brasileiro para '11.IPCA_LIVRES_DESSAZONALIZADOS.xlsx'")



    
