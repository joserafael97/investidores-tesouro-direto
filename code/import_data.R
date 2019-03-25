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
              estado_civil = last(`Estado Civil`),
              data_adesao = last(`Data de Adesao`)
             )

investidores_ativos_tesouro %>% 
    write_csv(here::here("dados/investidores_ativos_tesouro.csv"))
