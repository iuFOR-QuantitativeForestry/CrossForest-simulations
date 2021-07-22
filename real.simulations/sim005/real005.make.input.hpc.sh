#!/bin/bash
# numero de cores que serán reservados
#SBATCH -n 1
# particion en donde se ejecutara el trabajo
#SBATCH -p haswell
# limites que se aplicaran al trabajo
#SBATCH -q normal
# nombre
#SBATCH -J Script.make.scenarios.real005
# tiempo maximo de ejecucion (p.e. 2 dias). Maximo permitido: 5 dias
#SBATCH --time=10:00:00
# archivos de salida y de error
#SBATCH -o files.o/make.scenarios.real005-%j.o
#SBATCH -e files.e/make.scenarios.real005-%j.e
# directorio de trabajo por defecto
#SBATCH -D .
# notificaciones por email relacionadas con la ejecucion del trabajo
#SBATCH --mail-user=aitor.vazquez.veloso@uva.es
#SBATCH --mail-type=ALL

## argument passed to the script is the scenario type number ($1)

if [ $# -eq 1 ]; then scenario=$1  # seleccionar el primer nº del escenario
      else scenario=1
fi


ROOT=/home/uva_iufor_1/uva_iufor_1_2/simanfor/scripts  # ruta donde se encuentra el presente documento
OUT_Dir=/scratch/uva_iufor_1/uva_iufor_1_2/real005  # ruta donde queremos alojar los escenarios creados

CurrentDir=$(pwd)
cd $OUT_Dir

cd $OUT_Dir

## create a list with the input files
## https://unix.stackexchange.com/questions/356385/loop-through-a-folder-and-list-files
## searchDir="*"
cd ./input/
inputlist=()  # lista en la que alojaremos todos los inventarios que han de combinarse con los escenarios plantilla
while IFS= read -r -d $'\0' foundFile; do
    inputlist+=("$foundFile")
done < <(find * -maxdepth 1 -type f -print0 2> /dev/null)
cd ..

## build scenario files for each itinerario

## echo ${OUT_Dir}/scenario > ./templates/scenarios.filenames

i=1  # variable que aumenta para cada escenario creado (máximo 30.000)
j=1  # variable auxiliar con el mismo funcionamiento que i, utilizada al superar 30.000 escenarios

if [[ ${#inputlist[@]} -ne 0 ]]; then  ## checking for non empty list
    for inputfilename in "${inputlist[@]}"; do ## proccess every file in a for loop
		## https://www.baeldung.com/linux/bash-substring
		## echo ${inputfilename}
		species=${inputfilename:33:1}  # seleccionar en el nombre de los inventarios la parte correspondiente a la especie/localización o criterio por el que se establece la unión entre un inventario y un escenario
		## echo ${inputfilename}
		## echo ${species}
		## https://stackoverflow.com/questions/12152626/how-can-i-remove-the-extension-of-a-filename-in-a-shell-script
		##         name=$(echo "$filename" | cut -f 1 -d '.')
		filename=$(echo "${inputfilename%.*}")

		if [[ $i -lt 30000 ]]; then

			for scenario in {1..62}; do  # para el nº de plantillas de los escenarios previamente elaboradas

				
				## echo ${filename}
				scenariofilename=scnr_ppat_${i}.json  # nombre de los escenarios que vamos a crear, seguidos del ID generado automáticamente
				## echo ${scenariofilename}

				# en la siguiente línea se sustituye _idfile_ por el nombre del inventario, y se crea el escenario editado en la carpeta que indiquemos
				sed -e "s/_idfile_/${filename}/g" ./templates/Pp_at_${species}_${scenario}.json > ./scenario/part_1/${scenariofilename}
				## echo ${species} 
				## echo ${scenario}			
				## echo $scenariofilename >> ./templates/scenarios.filenames
				((i++))  # se aumenta el valor para cada escenario
		    	done

		else

			for scenario in {1..62}; do

				
				## echo ${filename}
				scenariofilename=scnr_ppat_${j}.json
				## echo ${scenariofilename}
				sed -e "s/_idfile_/${filename}/g" ./templates/Pp_at_${species}_${scenario}.json > ./scenario/part_2/${scenariofilename}
				## echo ${species} 
				## echo ${scenario}			
				## echo $scenariofilename >> ./templates/scenarios.filenames
				((i++))
				((j++))
		    	done

		fi

    	done
fi

cd $CurrentDir
