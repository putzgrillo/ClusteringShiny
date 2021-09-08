# https://stats.stackexchange.com/questions/195446/choosing-the-right-linkage-method-for-hierarchical-clustering
# OBS: NECESSÁRIO EVOLUIR PARA UM CRITÉRIO QUE PENALIZE QUANTIDADE DE CLUSTERS
options(encoding = "UTF-8")
library(data.table)
library(plotly)
library(tidyverse)
library(cluster)
library(gridExtra)
library(GGally)
library(ggfortify)
library(dendextend)
library(combinat)
library(caret)
library(reshape2)

# FUNÇÕES PRE-DEFINIDAS ----
source('Scripts/funcaoCalcularCluster.R')
source('Scripts/funcaoEscolherClusters.R')
source('Scripts/funcaoTransformarDados.R')

# DADOS ----
df <- readRDS("data/df_playlist.rds")
  # # DADOS: TRANSFORMAR DADOS E JUNTAR AOS ORIGINAIS
df_transf <- funcaoTransformarDados(x = {df %>% select(valence, tempo, energy, danceability, track.duration_min)},
                                    logTransform = T,
                                    rangeTransform = T)
df <- bind_cols(list(df, df_transf))

# APLICAR FUNÇÃO CLUSTERS ----
tempo <- proc.time()
clusters <- funcaoEscolherClusters(df = df, 
                                   percPior = 15, 
                                   intK = 3:9,
                                   varFixasNm = c("valence_TRANSF", "danceability_TRANSF"), 
                                   varCombnNm = c("tempo_TRANSF", "energy_TRANSF", "track.duration_min_TRANSF"),
                                   paralelo = TRUE
                                   )
proc.time() - tempo

save(clusters, file = "data/cluster_object.Rdata")
