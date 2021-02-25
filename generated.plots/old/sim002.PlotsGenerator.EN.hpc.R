#!/usr/bin/env Rscript

## This script is intended to use command line with number of plots, trees per plot and species as input parameters
## Output folder is also passeable by command
## R CMD BATCH --vanilla '--args N=1 l=list(a=2, b="test") name="aname"' myscript.R &
## R CMD BATCH --vanilla '--args id.file=1 sp=26 n.p=10 n.t=200 age0=20 ht.m=11 dbh.m=10 tph=1100' PlotsGenerator.EN.hpc.R &

##First read in the arguments listed at the command line
args = commandArgs(trailingOnly=TRUE)
## args=(commandArgs(TRUE))
## args is now a list of character vectors
##  First check to see if arguments are passed.
##  Then cycle through each element of the list and evaluate the expressions.

data.folder <- '/home/uva_iufor_1/COMUNES/simanfor/data/simul/sim002' ## folder to write files in HPC
## data.folder <- '~/simanfor/data/simul/sim001' ## folder to write files in PC

## supply default values
id.file <- 1
sp <- 26 # species spNFIcode
n.p <- 20 # number of plots
n.t <- 100 # number of trees per plot
age0 <- 25 # mean plot age
ht.m <- 15 # mean height
dbh.m <- 12 # mean dbh
tph <- 1100 # elección 'arbitraria' de la densidad en árboles por hectárea

var.d <- 5
var.h <- 3

if(!(length(args)==0)){
    for(i in 1:length(args)){
      eval(parse(text=args[[i]]))
    }
}

## set initial conditios and number of plots and tpp


## load libraries
library(plyr)
## library(dplyr)
library(openxlsx)

## set variables to null
## rm(list=ls())
## ls()
## getwd()
setwd(data.folder)
dir()

                                        # plot variables

## INVENTORY_ID,PLOT_ID,MODEL_NAME,PLOT_TYPE,PLOT_AREA,PROVINCE,STUDY_AREA,MUNICIPALITY,FOREST,PROV_REGION,MAIN_SPECIE,SPECIE_IFN_ID,SLOPE,ASPECT,CONTINENTALITY,LONGITUDE,LATITUDE,ALTITUDE,EXPAN,AGE,DENSITY,BASAL_AREA,BA_MAX,BA_MIN,MEAN_BA,DBH_MAX,DBH_MIN,MEAN_DBH,QM_DBH,DOMINANT_DBH,DOMINANT_SECTION,H_MAX,H_MIN,MEAN_H,DOMINANT_H,CROWN_MEAN_D,CROWN_DOM_D,CANOPY_COVER,REINEKE,HART,SI,REF_SI_AGE,QI,VOL,BOLE_VOL,BARK_VOL,VOL_HA

nms.p.all_en <- c('INVENTORY_ID', 'PLOT_ID', 'MODEL_NAME', 'PLOT_TYPE', 'PLOT_AREA', 'PROVINCE', 'STUDY_AREA', 'MUNICIPALITY', 'FOREST', 'PROV_REGION', 'MAIN_SPECIE', 'SPECIE_IFN_ID', 'SLOPE', 'ASPECT', 'CONTINENTALITY', 'LONGITUDE', 'LATITUDE', 'ALTITUDE', 'EXPAN', 'AGE', 'DENSITY', 'BASAL_AREA', 'BA_MAX', 'BA_MIN', 'MEAN_BA', 'DBH_MAX', 'DBH_MIN', 'MEAN_DBH', 'QM_DBH', 'DOMINANT_DBH', 'DOMINANT_SECTION', 'H_MAX', 'H_MIN', 'MEAN_H', 'DOMINANT_H', 'CROWN_MEAN_D', 'CROWN_DOM_D', 'CANOPY_COVER', 'REINEKE', 'HART', 'SI', 'REF_SI_AGE', 'QI', 'VOL', 'BOLE_VOL', 'BARK_VOL', 'VOL_HA')

## ES (Probably old version)
## parcelaIFN	superficiePARCELA	expan	provincia	ID_INVENTARIO	ID_PARCELA	A_BASIMETRICA	H_DOMINANTE	N_PIES	N_PIESHA	EDAD	D_MEDIO	D_CUADRATICO	D_DOMINANTE	D_MAX	D_MIN	DX	H_MEDIA	DM_COPA	DG_COPA	I_REINEKE	I_HART	FCC	SI	Municipio	Monte	CoordeX	CoordeY	Altitud



                                        # tree variables
## EN
## INVENTORY_ID,PLOT_ID,TREE_ID,number_of_trees,specie,quality,shape,special_param,remarks,age_130,social_class,tree_age,coord_x,coord_y,expan,dbh_1,dbh_2,dbh,stump_h,height,bark_1,bark_2,bark,normal_circumference,hd_ratio,basal_area,bal,ba_ha,cr,lcw,hcb,hlcw,vol,bole_vol,bark_vol,firewood_vol,vol_ha,dbh_oc,h_uncork,nb,cork_cycle

nms.t.all_en <- c('INVENTORY_ID', 'PLOT_ID', 'TREE_ID', 'number_of_trees', 'specie', 'quality', 'shape', 'special_param', 'remarks', 'age_130', 'social_class', 'tree_age', 'coord_x', 'coord_y', 'expan', 'dbh_1', 'dbh_2', 'dbh', 'stump_h', 'height', 'bark_1', 'bark_2', 'bark', 'normal_circumference', 'slenderness', 'basal_area', 'bal', 'ba_ha', 'cr', 'lcw', 'hcb', 'hlcw', 'vol', 'bole_vol', 'bark_vol', 'firewood_vol', 'vol_ha', 'dbh_oc', 'h_uncork', 'nb', 'cork_cycle')

## ES (Probably old version)
## ID_INVENTARIO	ID_PARCELA	ARBOL	NUMEROINDIVIDUOS	ESPECIE	DIAMETRO_1	DIAMETRO_2	CALIDAD	FORMA	ALTURA	PARAMESP	OBSERVACIONES	DAP	CORTEZA_1	CORTEZA_2	CORTEZA	CIRCUNFERENCIA	EXPAN	ESBELTEZ	SEC_NORMAL	EDAD130	CLASE_SOCIOLOGICA	VCC	VSC	IAVC	VLE	BAL	CR	SECCION_COPA_MAXIMA	EDAD_BASE	DIAMETRO_MIN	DIAMETRO_4	FCV	ALTURA_BC	ALTURA_MAC	ALTURA_RM	ALTURA_VV	ALTURA_TOC	ANCHO_CM_1	ANCHO_CM_2	RADIO_C_1	RADIO_C_2	RADIO_C_3	RADIO_C_4	LCW	Coord_X	Coord_Y


## plot generator

## set initial conditios
plot.id <- 1 # plot identificator
f.expan <- tph / n.t # factor de expansión necesario para que el número de árboles por hectárea 'tph' sea el deseado en función del numero de árboles 'n.t' que se van a generar por parcela 
plot.area <- 10000/f.expan
id.inv  <- paste0('simulat.en.', n.p, '.', n.t) 

## set plot variables
parcelaIFN <- rep(NA, n.p)
superficiePARCELA <- rep(plot.area, n.p)
expan <- rep(NA, n.p)
provincia <- rep(NA, n.p)
ID_INVENTARIOp <- rep(NA, n.p)
ID_PARCELAp <- rep(NA, n.p)
A_BASIMETRICA <- rep(NA, n.p)
H_DOMINANTE <- rep(NA, n.p)  ##se calcula
## N_PIES <- rep(NA, n.p)
N_PIESHA <- rep(NA, n.p)
EDAD <- rep(NA, n.p)
D_MEDIO <- rep(NA, n.p)
D_CUADRATICO <- rep(NA, n.p)
D_DOMINANTE <- rep(NA, n.p)
D_MAX <- rep(NA, n.p)
D_MIN <- rep(NA, n.p)
DX <- rep(NA, n.p)
H_MEDIA <- rep(NA, n.p)
DM_COPA <- rep(NA, n.p)
DG_COPA <- rep(NA, n.p)
I_REINEKE <- rep(NA, n.p)
I_HART <- rep(NA, n.p)
FCC <- rep(NA, n.p)
SI <- rep(NA, n.p)
VCC <- rep(NA, n.p)
VSC <- rep(NA, n.p)
Municipio <- rep(NA, n.p)
Monte <- rep(NA, n.p)
CoordeX <- rep(NA, n.p)
CoordeY <- rep(NA, n.p)
Altitud <- rep(NA, n.p)
ZonaEstudio <- rep(NA, n.p)
EspeciePrincipal <- rep(NA, n.p)

n.t_x_n.p <- n.t*n.p

## set tree variables
ID_INVENTARIOt <- rep(NA,n.t_x_n.p)
ID_PARCELAt <- rep(NA,n.t_x_n.p)
ARBOL <- rep(NA,n.t_x_n.p)
NUMEROINDIVIDUOS <- rep(NA,n.t_x_n.p)
ESPECIE <- rep(NA,n.t_x_n.p)
DIAMETRO_1 <- rep(NA,n.t_x_n.p)
DIAMETRO_2 <- rep(NA,n.t_x_n.p)
CALIDAD <- rep(NA,n.t_x_n.p)
FORMA <- rep(NA,n.t_x_n.p)
ALTURA <- rep(NA,n.t_x_n.p)
PARAMESP <- rep(NA,n.t_x_n.p)
OBSERVACIONES <- rep(NA,n.t_x_n.p)
DAP <- rep(NA,n.t_x_n.p)
CORTEZA_1 <- rep(NA,n.t_x_n.p)
CORTEZA_2 <- rep(NA,n.t_x_n.p)
CORTEZA <- rep(NA,n.t_x_n.p)
CIRCUNFERENCIA <- rep(NA,n.t_x_n.p)
EXPAN <- rep(NA,n.t_x_n.p)
ESBELTEZ <- rep(NA,n.t_x_n.p)
SEC_NORMAL <- rep(NA,n.t_x_n.p)
ba_ha <- rep(NA,n.t_x_n.p)
EDAD130 <- rep(NA,n.t_x_n.p)
CLASE_SOCIOLOGICA <- rep(NA,n.t_x_n.p)
vcc <- rep(NA,n.t_x_n.p)
vsc <- rep(NA,n.t_x_n.p)
IAVC <- rep(NA,n.t_x_n.p)
VLE <- rep(NA,n.t_x_n.p)
BAL <- rep(NA,n.t_x_n.p)
CR <- rep(NA,n.t_x_n.p)
SECCION_COPA_MAXIMA <- rep(NA,n.t_x_n.p)
EDAD_BASE <- rep(NA,n.t_x_n.p)
DIAMETRO_MIN <- rep(NA,n.t_x_n.p)
DIAMETRO_4 <- rep(NA,n.t_x_n.p)
FCV <- rep(NA,n.t_x_n.p)
ALTURA_BC <- rep(NA,n.t_x_n.p)
ALTURA_MAC <- rep(NA,n.t_x_n.p)
ALTURA_RM <- rep(NA,n.t_x_n.p)
ALTURA_VV <- rep(NA,n.t_x_n.p)
ALTURA_TOC <- rep(NA,n.t_x_n.p)
ANCHO_CM_1 <- rep(NA,n.t_x_n.p)
ANCHO_CM_2 <- rep(NA,n.t_x_n.p)
RADIO_C_1 <- rep(NA,n.t_x_n.p)
RADIO_C_2 <- rep(NA,n.t_x_n.p)
RADIO_C_3 <- rep(NA,n.t_x_n.p)
RADIO_C_4 <- rep(NA,n.t_x_n.p)
LCW <- rep(NA,n.t_x_n.p)
Coord_X <- rep(NA,n.t_x_n.p)
Coord_Y <- rep(NA,n.t_x_n.p)

id <- 0
for (plot.id in 1:n.p) {
    tree.id <- 1
    age <- as.integer(age0 + runif(1, -5, 5))    
    parcelaIFN[plot.id] <-  'simulation'
    superficiePARCELA[plot.id] <- plot.area
    expan[plot.id] <- f.expan
    provincia[plot.id] <- 'sim'
    ID_INVENTARIOp[plot.id] <- id.inv
    ID_PARCELAp[plot.id] <- plot.id
    A_BASIMETRICA[plot.id] <- 0
    H_DOMINANTE[plot.id] <- 0
    ## N_PIES[plot.id] <- 0
    N_PIESHA[plot.id] <- tph
    EDAD[plot.id] <- age
    D_MEDIO[plot.id] <- 0
    D_CUADRATICO[plot.id] <- 0
    D_DOMINANTE[plot.id] <- 0
    D_MAX[plot.id] <- 0
    D_MIN[plot.id] <- 0
    DX[plot.id] <- 0
    H_MEDIA[plot.id] <- 0
    DM_COPA[plot.id] <- 0
    DG_COPA[plot.id] <- 0
    I_REINEKE[plot.id] <- 0
    I_HART[plot.id] <- 0
    FCC[plot.id] <- 0
    SI[plot.id] <- 0
    Municipio[plot.id] <- " "
    Monte[plot.id] <- " "
    CoordeX[plot.id] <- 0
    CoordeY[plot.id] <- 0
    Altitud[plot.id] <- 0
    VCC[plot.id] <- 0
    VSC[plot.id] <- 0
    ZonaEstudio[plot.id] <- " "
    EspeciePrincipal[plot.id] <- sp
    for  (tree.id in 1:n.t) {
        id = id + 1
        ID_INVENTARIOt[id] <- id.inv
	ID_PARCELAt[id] <- plot.id
	ARBOL[id] <- tree.id
	NUMEROINDIVIDUOS[id] <- 1
	ESPECIE[id] <- sp
	DIAMETRO_1[id] <- dbh.m + var.d * runif(1, -1, 1) 
	DIAMETRO_2[id] <- dbh.m + var.d * runif(1, -1, 1) 
	CALIDAD[id] <- 0
	FORMA[id] <- 0
	ALTURA[id] <- ht.m + var.h * runif(1, -1, 1) 
	PARAMESP[id] <- 0
        OBSERVACIONES[id] <- ""
        DAP[id] <- (DIAMETRO_1[id]+DIAMETRO_2[id])/2
	CORTEZA_1[id] <- 0
	CORTEZA_2[id] <- 0
	CORTEZA[id] <- 0
	CIRCUNFERENCIA[id] <- pi * DAP[id] 
	EXPAN[id] <- f.expan
	ESBELTEZ[id] <- DAP[id] / ALTURA[id]
	SEC_NORMAL[id] <- pi * (DAP[id] / 200) ^ 2
        ba_ha[id] <- SEC_NORMAL[id]*f.expan
	EDAD130[id] <- age
	CLASE_SOCIOLOGICA[id] <- 0
	vcc[id] <- 0
	vsc[id] <- 0
	IAVC[id] <- 0
	VLE[id] <- 0
	BAL[id] <- 0
	CE <- (1 + runif(1, 0, 1)) / 3
	CR[id] <- (1 + runif(1, 0, 1)) / 3
	SECCION_COPA_MAXIMA[id] <- 0
	EDAD_BASE[id] <- age+3
	DIAMETRO_MIN[id] <- 0
	DIAMETRO_4[id] <- 0
	FCV[id] <- 0
	ALTURA_BC[id] <- ALTURA[id] * (1 - CR[id])
	ALTURA_MAC[id] <- ALTURA[id] * (1 - CR[id] + CR[id]*CE/3)
	ALTURA_RM[id] <- 0
	ALTURA_VV[id] <- 0
	ALTURA_TOC[id] <- 0
	ANCHO_CM_1[id] <- 0
	ANCHO_CM_2[id] <- 0
	RADIO_C_1[id] <- 0
	RADIO_C_2[id] <- 0
	RADIO_C_3[id] <- 0
	RADIO_C_4[id] <- 0
	LCW[id] <- 0
	Coord_X[id] <- 0
	Coord_Y[id] <- 0
        }
    }

trees <- data.frame(ID_INVENTARIOt,##[1] "INVENTORY_ID"         
                   ID_PARCELAt,##"PLOT_ID"              
                   ARBOL,##"TREE_ID"             
                   NUMEROINDIVIDUOS,##[4] "number_of_trees"      
                   ESPECIE,##"specie"
                   CALIDAD,##"quality"             
                   FORMA,## [7] "shape"                                    
                   PARAMESP,## "special_param"
                   OBSERVACIONES,##"remarks"
                   EDAD130,##[10] "age_130"             
                   CLASE_SOCIOLOGICA,## "social_class" 
                   EDAD_BASE,## "tree_age"            
                   Coord_X,##[13] "coord_x"             
                   Coord_Y,## "coord_y"              
                   EXPAN,##"expan"               
                   DIAMETRO_1,##[16] "dbh_1"  
                   DIAMETRO_2,##"dbh_2"
                   DAP,## "dbh"                 
                   ALTURA_TOC,##[19] "stump_h"              "height"               "bark_1"              
                   ALTURA,
                   CORTEZA_1,
                   CORTEZA_2,##[22] "bark_2"               "bark"                 "normal_circumference"
                   CORTEZA,
                   CIRCUNFERENCIA,
                   ESBELTEZ,##[25] "hd_ratio"             "basal_area"           "bal"                 
                   SEC_NORMAL,
                   BAL,
                   ba_ha, ## [28] "ba_ha"                                  
                   CR, ## "cr"
                   LCW, ## "lcw"
                   ALTURA_BC,##[31] "hcb"                  "hlcw"                 "vol"                 
                   ALTURA_MAC,
                   vcc,
                   vsc,##[34] "bole_vol"
                   ## "bark_vol"            
                   VLE## "firewood_vol"
                   ## [37] "vol_ha"               "dbh_oc"               "h_uncork"            
                   ## [40] "nb"                   "cork_cycle"          
                   ## IAVC,
                   ## SECCION_COPA_MAXIMA,
                   ## DIAMETRO_MIN,
                   ## DIAMETRO_4,
                   ## FCV,
                   ## ALTURA_RM,
                   ## ALTURA_VV,
                   ## ANCHO_CM_1,
                   ## ANCHO_CM_2,
                   ## RADIO_C_1,
                   ## RADIO_C_2,
                   ## RADIO_C_3,
                   ## RADIO_C_4
                   )

plots <- data.frame(ID_INVENTARIOp, ## "INVENTORY_ID"     
                   ID_PARCELAp, ## "PLOT_ID"  
                   ## "MODEL_NAME"
                   parcelaIFN, ## "PLOT_TYPE"
                   superficiePARCELA, ## "PLOT_AREA"                    
                   provincia, ## "PROVINCE"
                   ZonaEstudio, ##  "STUDY_AREA" 
                   Municipio, ## "MUNICIPALITY"    
                   Monte, ## "FOREST" 
                   ## "PROV_REGION" 
                   EspeciePrincipal, ## "MAIN_SPECIE" 
                   ## "SPECIE_IFN_ID"
                   ## "SLOPE"
                   ## "ASPECT"
                   ## "CONTINENTALITY"
                   CoordeX, # "LONGITUDE"
                   CoordeY, # "LATITUDE"
                   Altitud, # "ALTITUDE"
                   expan, # "EXPAN"
                   EDAD, # "AGE"
                   ## N_PIES, 
                   N_PIESHA, # "DENSITY"
                   A_BASIMETRICA, # "BASAL_AREA"
                   ## "BA_MAX"
                   ## "BA_MIN"
                   ## "MEAN_BA"
                   D_MAX, ## "DBH_MAX"
                   D_MIN, ## "DBH_MIN"
                   D_MEDIO, ## "MEAN_DBH"
                   D_CUADRATICO, ## "QM_DBH"
                   D_DOMINANTE, ## "DOMINANT_DBH"
                   ## "DOMINANT_SECTION"
                   ## "H_MAX"
                   ## "H_MIN"
                   H_MEDIA, ##[34] "MEAN_H"
                   H_DOMINANTE, ## "DOMINANT_H" ## se calcula después
                   DM_COPA, ## "CROWN_MEAN_D"
                   DG_COPA,## "CROWN_DOM_D"
                   FCC, ## "CANOPY_COVER"
                   I_REINEKE, ## "REINEKE"
                   I_HART, ## "HART"            
                   SI, ## "SI"
                   ## "REF_SI_AGE"
                   ## "QI"
                   ## "VOL"
                   VSC, ## "BOLE_VOL"
                   VCC ## "BARK_VOL"
                   ## "VOL_HA"          
                   )

nms.p <- names(plots)
nms.p[1] <- "ID_INVENTARIO"
nms.p[2] <- "ID_PARCELA"
names(plots) <- nms.p
## head(plots)

nms.t <- names(trees)
nms.t[1] <- "ID_INVENTARIO"
nms.t[2] <- "ID_PARCELA"
names(trees) <- nms.t
## head(trees)

## calculate stand variables: Cálculo de diámetros y áreas basales
means <- ddply(trees, c('ID_PARCELA'), summarise,
               ## tph = sum(fe, na.rm = TRUE),
               D_MEDIO = mean(DAP, na.rm = TRUE),
               ## dm2.medio = mean(dm2, na.rm = TRUE),
               A_BASIMETRICA  = sum(ba_ha, na.rm = TRUE) ,
               H_MEDIA        = mean(ALTURA, na.rm = TRUE)    )
## el diametro medio cuadratico dg;
means[,'D_CUADRATICO'] <- with(means, 200*(A_BASIMETRICA/N_PIESHA/pi)^0.5, na.rm=TRUE)

dominantHeight<-function(x, plotID="Estadillo") {
  if(plotID %in% names(x)) {
    IDs = unique(x[[plotID]])
    Hdom = rep(NA, length(IDs))
    names(Hdom) = IDs
    for(i in 1:length(IDs)) {
        Hdom[i] = .domheight(x$ALTURA[x[[plotID]] ==IDs[i]],
                            x$DAP[x[[plotID]]  ==IDs[i]],
                            x$EXPAN[x[[plotID]]  ==IDs[i]])
    }
    Hd <- data.frame(IDs, Hdom)
    return(Hd)
  }
  return(.domheight(x$h, x$d, x$n))
}
#################
.domheight<-function(h, d, n) {
  o <-order(d, decreasing=TRUE)
  h = h[o]
  n = n[o]
  ncum = 0 
  for(i in 1:length(h)) {
    ncum = ncum + n[i]
    if(ncum>100) return(sum(h[1:i]*n[1:i], na.rm=TRUE)/sum(h[1:i]*n[1:i]/h[1:i], na.rm=TRUE))
  }
  return(sum(h*n)/sum(n))
}

##  Calculate dominant height Hdom (m)
dom_height <- dominantHeight(trees, 'ID_PARCELA')

plots$H_DOMINANTE <- dom_height$Hdom
plots$D_MEDIO <- means$D_MEDIO
plots$A_BASIMETRICA <- means$A_BASIMETRICA
plots$H_MEDIA <- means$H_MEDIA
plots$D_CUADRATICO <- means$D_CUADRATICO
    
#n.p
#n.t
n.trees <- paste0('trees_', id.file, '.', n.p, '.', n.t ,'.csv')
n.plot <- paste0('plot_', id.file, '.', n.p, '.', n.t ,'.csv')
n.excel <- paste0('input_', id.file, '.', n.p, '.', n.t ,'sp', sp,'.xlsx')

## write.csv(trees, n.trees)
## write.csv(plots, n.plot)

## 2 excel file
## write list of data.frames to xlsx-file
## write a list of data.frames to individual worksheets using list names as worksheet names
## l <- list("Parcelas" = plots, "PiesMayores" = trees)
## write.xlsx(l, file = n.excel)
## write.xlsx(l, file = "writeXLSXTable2.xlsx", asTable = TRUE)

## en ingles
nms.p_en <- nms.p.all_en[c(1:2,4:9,11,16:22,26:30,34,35:41,44:45)]
names(plots) <- nms.p_en
## head(plots)

nms.t_en <- nms.t.all_en[c(1:27,28:34,36)]
names(trees) <- nms.t_en
## head(trees)

n.trees <- paste0('trees.en_', id.file, '.', n.p, '.', n.t ,'.csv')
n.plot <- paste0('plot.en_', id.file, '.', n.p, '.', n.t ,'.csv')
n.excel <- paste0('input.en_', id.file, '.', n.p, '.', n.t , 'sp', sp,'.xlsx')

## write.csv(trees, n.trees)
## write.csv(plots, n.plot)
l <- list("Parcelas" = plots, "PiesMayores" = trees)
## str(l)
write.xlsx(l, file = n.excel)
