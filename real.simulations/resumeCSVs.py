#!/usr/bin/env python

import pandas as pd
import os
import glob
import sys
import math

if len(sys.argv) > 3:
    n_folder = sys.argv[1] # folder inside scratch ej: "sim001"
    package_files = int(sys.argv[2]) # number of files to joint
    lofn = int(sys.argv[3]) # length of files name
    type_folder = sys.argv[4] # folder of input files or of output ones
else:
    if len(sys.argv) > 2:
        n_folder = sys.argv[1] # folder inside scratch ej: "sim001"
        package_files = int(sys.argv[2]) # number of files to joint
        lofn = int(sys.argv[3]) # length of files name
        type_folder = "/output" # folder of input files or of output ones
    else:
        if len(sys.argv) > 1:
            n_folder = sys.argv[1] # folder inside scratch ej: "sim001"
            package_files = int(sys.argv[2]) # number of files to joint
            lofn = 15 # int(sys.argv[3]) # length of files name
            type_folder = "/output" # folder of input files or of output ones
        else:
            if len(sys.argv) > 0:
                n_folder = sys.argv[1] # folder inside scratch ej: "sim001"
                package_files = 10000 # int(sys.argv[2]) # number of files to joint
                lofn = 15 #int(sys.argv[3]) # length of files name
                type_folder = "/output" # folder of input files or of output ones
            else:
                if len(sys.argv) == 0:
                    n_folder = "sim001" #sys.argv[1] # folder inside scratch ej: "sim001"
                    package_files = 10000 # int(sys.argv[2]) # number of files to joint
                    lofn = 15 #int(sys.argv[3]) # length of files name
                    type_folder = "/output" # folder of input files or of output ones

# Directorios de trabajo
Path = '/scratch/uva_iufor_1/uva_iufor_1_3/'+n_folder
InputPath =  Path+type_folder+'.csv/' ## donde estan los ficheros de entrada
OutputPath = Path+type_folder+'.summary/' ## donde se almacenará el / los ficheros de salida
# InputPath =  Path+'/output.csv/' ## donde estan los ficheros de entrada
# OutputPath = Path+'/output.summary/' ## donde se almacenará el / los ficheros de salida

os.chdir(InputPath) # cambiamos al directorio input

extension = 'csv'
filescsv = [i for i in glob.glob('*.{}'.format(extension))]
nof=len(filescsv)
noloops=math.ceil(nof/package_files)
files=filescsv[1][:lofn]
for i in range(1,noloops+1):
    filescsv_i=filescsv[ (i-1)*package_files : min(i*package_files,nof)]
    combined_csv = pd.concat([pd.read_csv(f) for f in filescsv_i ])
    fileoutall = files+'_'+ str(i) + '.csv' # nombre de fichero de salida
    os.chdir(OutputPath) # cambiamos al directorio output
    combined_csv.to_csv( fileoutall, index=False, encoding='utf-8-sig') #export to csv
    lofi_name='list.of_'+str(i)+'_files.csv'
    df_filescsv_i=pd.DataFrame(filescsv_i)
    df_filescsv_i.to_csv(lofi_name, index=False, encoding='utf-8-sig')
    os.chdir(InputPath) # cambiamos al directorio input de nuevo para seguir leyendo

os.chdir(OutputPath) # cambiamos al directorio output
df_filescsv=pd.DataFrame(filescsv)
df_filescsv.to_csv('list.of_all_files.csv', index=False, encoding='utf-8-sig')
