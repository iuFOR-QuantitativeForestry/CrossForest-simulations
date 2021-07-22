Estas simulaciones se corresponden con:  
  
* Parcelas: puras de IFN2 e IFN3  
* Modelos: Pinus pinaster atlantica costa e interior. Modelos dinámicos de masa  
* Escenarios: 62 escenarios selvícolas generados a partir de todas las combinaciones posibles de los modelos selvícola de la Xunta de Galicia  
  
  

Instrucciones para hacer simulaciones en HPC:  
  
* realxxx es el nombre del "trabajo", el proyecto que vamos a desarrollar en el HPC

* realxxx.split.hpc.sh es el documento a través del cual se ejecuta splitInputExcel2indPlots.py (programado en python); contiene las rutas donde se encuentra y a donde se envía el archivo de salida

* splitInputExcel2indPlots.py es el documento donde se especifica el nombre del inventario con todas las parcelas a dividir, y la ubicación y nombres de los archivos de salida (programado para 1 parcela por archivo, pero susceptible de cambios)

* realxxx.make.input.hpc.sh es el documento que crea automáticamente los escenarios utilizando escenarios plantilla que hemos de proporcionar y los inventarios deseados. Es necesario:  
	- cambiar las rutas
	- la variable "species" debe acceder al título del archivo de entrada y seleccionar aquella parte del texto que haga referencia a la especie de la que se trata el modelo (esto es para ejecutar escenarios de distintas especies y/o localizaciones a la vez, y no perder la referencia de qué inventario ha de adherirse a cada escenario)
	- la variable "i" es la que dará un código identificador único a cada escenario para poder hacer el array_job (siguiente documento). No debe superar el valor de 30.000, dado que a partir de ahí el HPC no lo ejecutará. Hay dos opciones en este caso, hacer inventarios con más de una parcela o dividir los escenarios en carpetas, con un máximo de 30.000 archivos, siendo el ID del archivo mayor (variable "i") < 30.000
	- "scenariofilename" es eñ título de los escenarios que genera el script automáticamente
	- en la siguiente línea:  
	sed -e "s/_idfile_/${filename}/g" ./templates/Pp_at_${species}_${scenario}.json > ./scenario/part_1/${scenariofilename}  
		- aquí de sustituye "_idfile_" por el nombre del archivo de inventario, por lo que este nombre debe aparecer en el campo "input" de los escenarios
		- los archivos en los que se sustituye son los escenarios plantilla, alojados en la carpeta "templates" para este caso, y cuyo nombre ha de tener una parte común (Pp_at_) seguida del código/campo que identifique la especie y el que identifique el código/campo de escenario
		- por último, es necesario poner la ruta donde queremos guardar estos escenarios generados automáticamente del otro lado del ">"
  
* realxxx.job.sh es el archivo ejecutable que contiene las rutas desde donde se ejecuta el simulador y a donde este accede a los escenarios. Es necesario:  
	- cambiar las rutas
	- cambiar en nº de trabajos (línea 20)

