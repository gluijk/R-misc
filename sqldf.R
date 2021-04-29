library(sqldf)
library(data.table)

DT=fread("sqldf_poblacion.csv", header=T, sep=";", dec=",")  # CSV de Excel

# select j
# from DT
# where i
# group by

# DT[i, j, by]

DT

sqldf(paste0("select prov, sum(pob) AS sumpob, count(*) AS nmuni ",
             "from DT ",
             "where pob<100000 ",
             "group by prov"))

DT[pob<100000, .(sumpob=sum(pob), nmuni=.N), by=prov]
