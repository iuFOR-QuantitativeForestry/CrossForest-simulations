#!/usr/bin/env python

import pandas as pd
import os
import glob

# Directorios de trabajo
InputPath =  '/scratch/uva_iufor_1/uva_iufor_1_3/sim008/output/' ## donde estan los ficheros de entrada
OutputPath = '/scratch/uva_iufor_1/uva_iufor_1_3/sim008/output.summary/' ## donde se almacenará el / los ficheros de salida

# Se almacenan en files los ficheros de 'InputPath' que son excel
# https://www.freecodecamp.org/news/how-to-combine-multiple-csv-files-with-8-lines-of-code-265183e0854/

##os.chdir(InputPath) # cambiamos al directorio input

##extension = 'xlsx'
##files = [i for i in glob.glob('*.{}'.format(extension))]

# creamos un csv de cada hoja parcela (la cuarta, que corresponde al numero 3: 0,1,2,3,...) de cada fichero excel
##for filename in files:
##    fileinpath = InputPath+filename
##    df = pd.read_excel(fileinpath, 3)
##    filenamecsv = filename.replace('.xlsx', '.csv', 1)
##    fileoutpath = OutputPath+filenamecsv
##    df.to_csv(fileoutpath, index = False, header=True)
    
os.chdir(OutputPath) # cambiamos al directorio output

extension = 'csv'
filescsv = [i for i in glob.glob('*.{}'.format(extension))]
    
# ahora juntamos los csv en uno solo
#combine all files in the list
combined_csv = pd.concat([pd.read_csv(f) for f in filescsv ])

# nombre de fichero de salida
fileoutall = files[1][:8] + '.csv'

#export to csv
combined_csv.to_csv( fileoutall, index=False, encoding='utf-8-sig')
