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
            file_name = 'Mix.xlsx'
            file_type = 'xlsx'
        else:
            scratch_folder = '/scratch/uva_iufor_1/uva_iufor_1_3/real/real001/'
            file_name = 'mix.xlsx'
            file_type = 'xlsx'

## Directorio de trabajo
Path=scratch_folder+'input/' # '/scratch/uva_iufor_1/uva_iufor_1_3/'
print(Path)

## step 001 Read input excel to dataframe "plot" and "tree"
fileinpath = Path+'source/'+file_name
plot = pd.read_excel(fileinpath, 0)
tree = pd.read_excel(fileinpath, 1)
print(fileinpath)

## step 002 Read list of plots to vector "plotlist"
plotlist=plot['PLOT_ID'].values.tolist()
print(plotlist)

## step 003 loop to write a excel file for each "plot" in "plotlist"
i=0
for plot_name in plotlist:
    i=1+i
    plot_i=plot[(plot.PLOT_ID==plot_name)]
    model_=plot_i.iloc[0]['model']
    tree_i=tree[(tree.PLOT_ID==plot_name)]
    # plot_=plot.query('PLOT_ID==plot_name')
    # tree_=tree.query('PLOT_ID==plot_name')
    fileoutpath = Path+file_name.replace(file_type, 'sps_'+model_+'.P_'+str(i)+'.xlsx', 1)
    writer=pd.ExcelWriter(fileoutpath)
    plot_i.to_excel(writer, sheet_name='Parcelas', startcol=0, index=False)
    tree_i.to_excel(writer, sheet_name='PiesMayores', startcol=0, index=False)
    writer.save()
