# Clientes con contenido MOTOR (productos SPORT y MOTOR) a cierre de Nov17

library(data.table)

rm(list=ls())
shell("cls")


# Leer Demograficos
dt1=fread("Dem_ono_20171127.txt", sep="\t")
dt2=fread("Dem_vodafone_20171127.txt", sep="\t")

# Filtrar clientes con Motor + limpieza
dt1=dt1[FLAG_MOTOR=='1' | FLAG_SPORT=='1', .(NUM_CLIENTE, ID_TSN),]
dt1$NUM_CLIENTE=as.character(dt1$NUM_CLIENTE)
dt1[nchar(NUM_CLIENTE)==8, NUM_CLIENTE:=paste0("0",NUM_CLIENTE),]

dt2=dt2[FLAG_MOTOR=='1' | FLAG_SPORT=='1', .(NUM_CLIENTE_VF, ID_TSN),]
names(dt2)[names(dt2)=='NUM_CLIENTE_VF']='NUM_CLIENTE'


# Deduplicar agrupando por NUM_CLIENTE
DT1=dt1[, .(STACK="AMDOCS"), by=NUM_CLIENTE]
DT2=dt2[, .(STACK="ORACLE"), by=NUM_CLIENTE]

# Deduplicar con unique() + limpieza
# DT1=unique(dt1, by="NUM_CLIENTE")
# DT2=unique(dt2, by="NUM_CLIENTE")

# DT2[, ID_TSN:=NULL,]
# DT2[, ID_TSN:=NULL,]

# DT1[, STACK:="AMDOCS",]  # eq. DT1$STACK="AMDOCS"
# DT2[, STACK:="ORACLE",]  # eq. DT2$STACK="ORACLE"


# Listado de salida
write.csv2(rbind(DT1,DT2), file="SPORT_MOTOR.csv", row.names=F)



# ANEXO: ELIMINACIÓN DE DUPLICADOS CON CRITERIO DE SUPERVIVENCIA
V1=c(rep("A", 3), rep("B", 3), rep("C",2))
V2=c(1,1,2,4,1,1,2,2)
dt=data.table(V1,V2)

# Si se van a eliminar duplicados
# ordenando previamente la tabla elegimos quien sobrevive
dt=dt[order(V2,-V1)]

duplicated(dt)  # which rows are duplicated by all columns (eq. by=NULL)
duplicated(dt, by="V1")  # which rows are duplicated by V1

unique(dt)  # unique rows by all columns (eq. by=NULL)
unique(dt, by="V1")  # unique rows by all columns


