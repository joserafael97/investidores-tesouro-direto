library(tidyverse)
library(lubridate)
library(here)

investidores_tesouro = readr::read_csv2(here::here("data/InvestidoresTesouroDireto.csv"))


investidores_ativos_tesouro = investidores_tesouro %>% 
    filter(`Operou 12 Meses` == 'S' ) %>% 
    group_by(`Codigo do Investidor`) %>% 
    summarise(uf = last(`UF do Investidor`), 
              situacao_conta = last(`Situacao da Conta`), 
              genero = last(Genero),
              profissao = last(Profissao),
              idade = last(as.numeric(Idade)),
              estado_civil = last(ifelse(grepl('Casado', `Estado Civil`), 'Casado(a)', `Estado Civil`)),
              data_adesao = last(as.Date(`Data de Adesao`, format = "%d/%m/%Y"))
             )

investidores_ativos_tesouro = 
    investidores_ativos_tesouro %>% 
    mutate(ano_adesao = lubridate::year(data_adesao))

investidores_ativos_tesouro %>% 
    write_csv(here::here("dados/investidores_ativos_tesouro.csv"))
