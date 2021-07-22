#!/usr/bin/env python

import pandas as pd
import numpy as np
import os
import glob
import sys

print("Argument List:",
       str(sys.argv))

if len(sys.argv)>3:
    scratch_folder = sys.argv[1] # folder inside scratch ej: "real001"
    file_name = sys.argv[2] # file name to split
    file_type = sys.argv[3]
else:
    if len(sys.argv)>2:
        scratch_folder = sys.argv[1] # folder inside scratch ej: "real001"
        file_name = sys.argv[2] # excel file name
        file_type = 'xlsx'
    else:
        if len(sys.argv)>1:
            scratch_folder = sys.argv[1]
            file_name = 'plots_pure_Ppt_gal_IFN.xlsx'  # nombre del archivo a dividir
            file_type = 'xlsx'  # formato del archivo (xlsx o csv)
        else:
            scratch_folder = '/scratch/uva_iufor_1/uva_iufor_1_2/real005/'  # carpeta en la que se aloja el archivo
            file_name = 'plots_pure_Ppt_gal_IFN.xlsx'  # nombre del archivo a dividir
            file_type = 'xlsx'  # formato del archivo (xlsx o csv)

## Directorio de trabajo
Path=scratch_folder # '/scratch/uva_iufor_1/uva_iufor_1_2/'
print(Path)

## step 001 Read input excel to dataframe "plot" and "tree"
fileinpath = Path+'inventories/'+file_name  # acceder al archivo escrito anteriormente, y localizado dentro de la carpeta "inventories"
plot = pd.read_excel(fileinpath, 0)  # leer información de parcelas
tree = pd.read_excel(fileinpath, 1)  # leer información de árboles
print(fileinpath)

## step 002 Read list of plots to vector "plotlist"
plotlist=plot['PLOT_ID'].values.tolist()  # lista de parcelas
print(plotlist)

## step 003 loop to write a excel file for each "plot" in "plotlist"
i=0
for plot_name in plotlist:
    i=1+i
    plot_i=plot[(plot.PLOT_ID==plot_name)]  # buscar la parcela que tenga el ID que estamos buscando
    model_=plot_i.iloc[0]['model']  # acceder al nombre del modelo (1a columna de la hoja parcelas, que ha de crearse con el nombre del modelo a emplear)
    tree_i=tree[(tree.PLOT_ID==plot_name)]  # acceder a los árboles con el mismo ID de parcela
    # plot_=plot.query('PLOT_ID==plot_name')
    # tree_=tree.query('PLOT_ID==plot_name')
    fileoutpath = Path+'/input/'+file_name.replace(file_type, 'sps_'+model_+'.P_'+str(i)+'.xlsx', 1)  # sustituir el nombre del inventario por uno nuevo, especificando la especie y parcela
    writer=pd.ExcelWriter(fileoutpath)  # escribir el nuevo archivo
    plot_i.to_excel(writer, sheet_name='Parcelas', startcol=0, index=False)  # adjuntar información de parcelas
    tree_i.to_excel(writer, sheet_name='PiesMayores', startcol=0, index=False)  # adjuntas información de árboles
    writer.save()  # guardar el documento
