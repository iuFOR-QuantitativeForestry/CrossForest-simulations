#!/usr/bin/env python

import pandas as pd
import os
import glob
import sys

if len(sys.argv) > 2:
    n_folder = sys.argv[1] # folder inside scratch ej: "sim001"
    type_folder = sys.argv[3] # folder of input files or of output ones
    i_s = int(sys.argv[2]) # sheet order that will be converted to csv
else:
    if len(sys.argv) > 1:
        n_folder = sys.argv[1] # folder inside scratch ej: "sim001"
        type_folder = '/output' # folder of input files or of output ones
        i_s = int(sys.argv[2]) # sheet order that will be converted to csv
    else:
        if len(sys.argv) == 1:
            n_folder = sys.argv[1]
            type_folder = '/output' # folder of input files or of output ones
            i_s = 3 # sheet order that will be converted to csv
        else:
            n_folder = 'sim001'
            type_folder = '/output'
            i_s = 3

# Directorios de trabajo
Path = '/scratch/uva_iufor_1/uva_iufor_1_3/'+n_folder
InputPath =  Path+type_folder+'/' ## donde estan los ficheros de entrada
OutputPath = Path+type_folder+'.csv/' ## donde se almacenará el / los ficheros de salida

# Se almacenan en files los ficheros de 'InputPath' que son excel
# https://www.freecodecamp.org/news/how-to-combine-multiple-csv-files-with-8-lines-of-code-265183e0854/

os.chdir(OutputPath) # cambiamos al directorio output para ver si hay ficheros ya convertidos
extension = 'csv'
files_csv = [i for i in glob.glob('*.{}'.format(extension))]

os.chdir(InputPath) # cambiamos al directorio input
extension = 'xlsx'
files_xlsx = [i for i in glob.glob('*.{}'.format(extension))]

# 4. Return Non-Matches Elements with For Loop
# You can write a function to return all unmatched elements in the list using for loop.
def non_match_elements(list_a, list_b):
    non_match = []
    for i in list_a:
        if i not in list_b:
            non_match.append(i)
    return non_match

if len(files_csv) > 0:
    files_xlsx_=[]
    files_csv_=[]
    files=[]
    for name in files_xlsx:
        files_xlsx_.append( name.replace('.xlsx', '__.__', 1) )
    for name in files_csv:
        files_csv_.append( name.replace('.csv', '__.__', 1) )    
    files_ = non_match_elements(files_xlsx_, files_csv_)
    for name in files_:
        files.append( name.replace('__.__', '.xlsx', 1) )    
else:
    files = files_xlsx
    
# creamos un csv de cada hoja parcela (la cuarta, que corresponde al numero 3: 0,1,2,3,...) de cada fichero excel
for filename in files:
    fileinpath = InputPath+filename
    df = pd.read_excel(fileinpath, i_s)
    filenamecsv = filename.replace('.xlsx', '.csv', 1)
    fileoutpath = OutputPath+filenamecsv
    df.to_csv(fileoutpath, index = False, header=True)
    
