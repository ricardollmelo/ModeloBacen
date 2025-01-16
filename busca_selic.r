# Carregar os pacotes necessários
library(rbcb)
library(dplyr)
library(lubridate)

# Buscar os dados da série histórica da Selic
selic_data <- rbcb::get_series(432)

# Transformar a data em formato Date
selic_data$date <- ymd(selic_data$date)

# Verificar os nomes das colunas
print(names(selic_data))

# Função para buscar o último valor de cada mês
get_last_value_per_month <- function(selic_data) {
  selic_data %>%
    group_by(year = year(date), month = month(date)) %>%
    filter(date == max(date)) %>%
    ungroup() %>%
    select(date, value = 2)  # Ajustar o nome da coluna conforme necessário
}

# Buscar o último valor de cada mês
ultimo_valor_por_mes <- get_last_value_per_month(selic_data)

# Visualizar os dados do último valor de cada mês
print(ultimo_valor_por_mes)

# Carregar os pacotes necessários
library(openxlsx)

# Nome do arquivo Excel
output_file <- "ultimo_valor_selic.xlsx"

# Função para exportar dados para Excel
export_to_excel <- function(data, file_name) {
  # Criar um workbook
  wb <- createWorkbook()
  
  # Adicionar uma planilha
  addWorksheet(wb, "Taxa Selic")
  
  # Escrever os dados na planilha
  writeData(wb, "Taxa Selic", data)
  
  # Salvar o workbook
  saveWorkbook(wb, file_name, overwrite = TRUE)
}

# Exportar os dados do último valor de cada mês para um arquivo Excel
export_to_excel(ultimo_valor_por_mes, output_file)

# Mensagem de confirmação
print(paste("Dados exportados para", output_file))



