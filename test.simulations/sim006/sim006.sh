#!/bin/bash
## make folders
# OUT_Dir=/data/cristobal/simanfor/HPC
OUT_Dir=/scratch/uva_iufor_1/uva_iufor_1_3/sim006
if [ ! -d "$OUT_Dir" ]; then mkdir $OUT_Dir; fi
folders=("/input" "/scenario" "/output")
for folder in ${folders[@]}
do
    i_Dir=${OUT_Dir}${folder}
    if [ ! -d "$i_Dir" ]; then mkdir $i_Dir; fi
done
## permiso de ejecucion para los archivos
chmod +x ~/scripts/sim006.*
n=8
## make input files
sbatch ~/scripts/sim006.make.input.hpc.sh $n 50 100
## make scenario files
CurrentDir=$(pwd)
cd $OUT_Dir/scenario
i=1 
while [ $i -le $n ]; do
	filename=scnr_sp999_${i}_50-100.json
	sed -e "s/_idnumber_/${i}/g" ~/scripts/sim006.template.json > ${filename}
	echo $filename
	((i++))
done
cd $CurrentDir
## make simulations
##sbatch ~/scripts/sim005.job.array.10-100.sh 
