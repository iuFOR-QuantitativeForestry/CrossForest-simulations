# sim001
### complete
100 plots, 10 array = 10 input files, 10 ppf (plots per file), 60 tpp (trees per plot)
### test
10 plots, 1 exec = 1 input files, 10 ppf, 60 tpp

## make input files
10 files with 10 plot each, 60 trees per plot 
folder: /COMUNES/simanfor/data/simul/sim001/
command in HPC: 
          ----> sbatch ~/scripts/sim001.make.input.hpc.sh 10 10 60
which do 10 call to R-script sim001.PlotsGenerator.EN.hpc.R

## make scenario files
command in HPC: 
          ----> ~/scripts/sim001.make.scenario.files.sh 10
put files in /COMUNES/simanfor/scenario/simul/sim001 from template.json
### put 10 files in  /home/uva_iufor_1/COMUNES/simanfor/scenario/simul/sim001
### filename: scnr_sp999_${i}_10-60.json
### each file change input and output files (with _idnumber_ from 1 to 10): 
#### "output_path": "/home/uva_iufor_1/COMUNES/simanfor/output/simul/sim001/out__idnumber__10-60",
#### "input": "/home/uva_iufor_1/COMUNES/simanfor/data/simul/sim001/input.en__idnumber_.10.60sp999.xlsx"
scenario files run two growth periods, 5 years each and perform a thinning

## make simulations
command in HPC: 
          ----> sbatch ~/scripts/sim001.job.array.10-60.sh 
which do 10 array jobs for 10 scenario files: scnr_sp999_${i}_10-60.json

## summary from HPC
### ------------test
calendula Slurm Job_id=492247 Name=sm4_simul_sim001 Ended, Run time 00:04:42, COMPLETED, ExitCode 0
2020/11/08 22:45
#------------
Job ID: 492247
Cluster: calendula
User/Group: uva_iufor_1_3/uva_iufor_1
State: COMPLETED (exit code 0)
Cores: 1
CPU Utilized: 00:04:04
CPU Efficiency: 86.52% of 00:04:42 core-walltime
Job Wall-clock time: 00:04:42
Memory Utilized: 123.03 MB
Memory Efficiency: 6.35% of 1.89 GB

### ------------complete

#------------
Job ID: 488715
Array Job ID: 488715_10
Cluster: calendula
User/Group: uva_iufor_1_3/uva_iufor_1
State: COMPLETED (exit code 0)
Cores: 1
CPU Utilized: 00:03:35
CPU Efficiency: 74.91% of 00:04:47 core-walltime
Job Wall-clock time: 00:04:47
Memory Utilized: 123.11 MB
Memory Efficiency: 6.36% of 1.89 GB
#------------






# sim002
### complete
400 plots, 20 array = 20 input files, 20 ppf, 100 tpp
### test
20 plots, 1 exec = 1 input files, 20 ppf, 100 tpp

## make folders and run other scripts
command in HPC: 
          ----> ~/scripts/sim002.sh

## make scenario files
command in HPC: 
          ----> ~/scripts/sim002.makeScenarioFiles.sh 20
put files in /COMUNES/simanfor/scenario/simul/sim002 from template.json
### put 20 files in  /home/uva_iufor_1/COMUNES/simanfor/scenario/simul/sim002
### filename: scnr_sp999_${i}_20-100.json
### each file change input and output files (with _idnumber_ from 1 to 20): 
#### "output_path": "/home/uva_iufor_1/COMUNES/simanfor/output/simul/sim002/out__idnumber__20-100",
#### "input": "/home/uva_iufor_1/COMUNES/simanfor/data/simul/sim002/input.en__idnumber_.20.100sp999.xlsx"
scenario files run tweenty growth periods, 5 years each and perform a thinning after ten growths

## make input files
20 files with 20 plot each, 100 trees per plot 
folder: /COMUNES/simanfor/data/simul/sim002/
command in HPC: 
          ----> sbatch ~/scripts/sim002.make.input.hpc.sh 20 20 100
which do 20 call to R-script sim002.PlotsGenerator.EN.hpc.R

## make simulations
command in HPC: 
          ----> sbatch ~/scripts/sim002.JobArray_20-100.sh 
which do 20 array jobs for 20 scenario files: scnr_sp999_${i}_20-100.json

## summary from HPC
### ------------test
calendula Slurm Job_id=492248 Name=sm4_simul_sim002 Ended, Run time 00:46:26, COMPLETED, ExitCode 0
25/10/20 23:27
#------------
Job ID: 492248
Cluster: calendula
User/Group: uva_iufor_1_3/uva_iufor_1
State: COMPLETED (exit code 0)
Cores: 1
CPU Utilized: 00:45:51
CPU Efficiency: 98.74% of 00:46:26 core-walltime
Job Wall-clock time: 00:46:26
Memory Utilized: 703.57 MB
Memory Efficiency: 36.34% of 1.89 GB

### ------------complete
calendula Slurm Array Summary Job_id=489904_* (489904) Name=sm4_simul_sim002 Ended, COMPLETED, ExitCode [0-0]
25/10/20 1:40
#------------
Job ID: 489904
Array Job ID: 489904_20
Cluster: calendula
User/Group: uva_iufor_1_3/uva_iufor_1
State: COMPLETED (exit code 0)
Cores: 1
CPU Utilized: 00:53:19
CPU Efficiency: 98.98% of 00:53:52 core-walltime
Job Wall-clock time: 00:53:52
Memory Utilized: 693.74 MB
Memory Efficiency: 35.83% of 1.89 GB
#------------








# sim003
******************OUT OF TIME******************
## description
400 plots, 4 array = 4 input files, 100 ppf, 100 tpp

## make folders and run other scripts
command in HPC: 
          ----> ~/scripts/sim003.sh
this script run everything but the array jobs
## make scenario files
command in HPC: 
          ----> ~/scripts/sim003.makeScenarioFiles.sh 4
put files in $SCRACH/sim003/scenario from template.json
### put 4 files in  $SCRACH/sim003/scenario
### filename: scnr_sp999_${i}_100-100.json
### each file change input and output files (with _idnumber_ from 1 to 4): 
#### "output_path": "$SCRACH/sim003/out__idnumber__20-100",
#### "input": "$SCRACH/sim003/input.en__idnumber_.100.100sp999.xlsx"
scenario files run tweenty growth periods, 5 years each and perform a thinning after ten growths

## make input files
4 files with 100 plot each, 100 trees per plot 
folder: $SCRACH/sim003/
command in HPC: 
          ----> sbatch ~/scripts/sim003.make.input.hpc.sh 4 100 100
which do 4 call to R-script sim003.PlotsGenerator.EN.hpc.R

## make simulations
### test ******************OUT OF TIME******************
command in HPC: 
          ----> sbatch ~/scripts/sim003.job.test.sh 
which do 1 jobs for 1 scenario files: scnr_sp999_1_100-100.json

## summary from HPC
#------------
calendula Slurm Array Summary Job_id=491221_* (491221) Name=sm4_simul_sim002 Ended, Mixed, MaxSignal [9]
3/11/20 0:28
#------------
Job ID: 491221
Array Job ID: 491221_4
Cluster: calendula
User/Group: uva_iufor_1_3/uva_iufor_1
State: TIMEOUT (exit code 0)
Cores: 1
CPU Utilized: 00:59:36
CPU Efficiency: 98.73% of 01:00:22 core-walltime
Job Wall-clock time: 01:00:22
Memory Utilized: 1.58 GB
Memory Efficiency: 83.83% of 1.89 GB

#------------





# sim004
******************OUT OF TIME******************
## description
400 plots, 5 array = 5 input files, 80 ppf, 100 tpp

## make folders and run other scripts
command in HPC: 
          ----> ~/scripts/sim004.sh
this script run everything but the array jobs
## make scenario files
command in HPC: 
          ----> ~/scripts/sim004.makeScenarioFiles.sh 5
put files in $SCRACH/sim004/scenario from template.json
### put 5 files in  $SCRACH/sim004/scenario
### filename: scnr_sp999_${i}_80-100.json
### each file change input and output files (with _idnumber_ from 1 to 5): 
#### "output_path": "$SCRACH/sim004/out__idnumber__80-100",
#### "input": "$SCRACH/sim004/input.en__idnumber_.80.100sp999.xlsx"
scenario files run tweenty growth periods, 5 years each and perform a thinning after ten growths

## make input files
5 files with 80 plot each, 100 trees per plot 
folder: $SCRACH/sim004/
command in HPC: 
          ----> sbatch ~/scripts/sim004.make.input.hpc.sh 5 80 100
which do 5 call to R-script sim004.PlotsGenerator.EN.hpc.R

## make simulations
### test ******************OUT OF TIME******************
command in HPC: 
          ----> sbatch ~/scripts/sim004.job.test.sh 
which do 1 jobs for 1 scenario files: scnr_sp999_1_80-100.json

## summary from HPC
#------------
calendula Slurm Array Summary Job_id=491701_* (491701) Name=sm4_simul_sim004 Ended, Mixed, MaxSignal [9]
5/11/20 13:11
******************OUT OF TIME******************
#------------
Job ID: 491701
Array Job ID: 491701_5
Cluster: calendula
User/Group: uva_iufor_1_3/uva_iufor_1
State: TIMEOUT (exit code 0)
Cores: 1
CPU Utilized: 00:59:00
CPU Efficiency: 98.12% of 01:00:08 core-walltime
Job Wall-clock time: 01:00:08
Memory Utilized: 1.42 GB
Memory Efficiency: 74.87% of 1.89 GB

#------------






# sim005
## description
### complete
400 plots, 40 array = 40 input files, 10 ppf, 100 tpp
### test
10 plots, 1 exec = 1 input files, 10 ppf, 100 tpp

## make folders and run other scripts
command in HPC: 
          ----> ~/scripts/sim005.sh
this script run everything but the array jobs
## make scenario files
command in HPC: 
          ----> ~/scripts/sim005.makeScenarioFiles.sh 40
put files in $SCRACH/sim005/scenario from template.json
### put 40 files in  $SCRACH/sim005/scenario
### filename: scnr_sp999_${i}_10-100.json
### each file change input and output files (with _idnumber_ from 1 to 40): 
#### "output_path": "$SCRACH/sim005/out__idnumber__10-100",
#### "input": "$SCRACH/sim005/input.en__idnumber_.10.100sp999.xlsx"
scenario files run tweenty growth periods, 5 years each and perform a thinning after ten growths

## make input files
40 files with 10 plot each, 100 trees per plot 
folder: $SCRACH/sim005/
command in HPC: 
          ----> sbatch ~/scripts/sim005.make.input.hpc.sh 40 10 100
which do 40 call to R-script sim004.PlotsGenerator.EN.hpc.R

## make simulations
### test 
command in HPC: 
          ----> sbatch ~/scripts/sim005.job.test.sh 
which do 1 jobs for 1 scenario files: scnr_sp999_1_10-100.json
### complete 
command in HPC: 
          ----> sbatch ~/scripts/sim005.job.array_10-100.sh 
which do 40 array jobs for 40 scenario files: scnr_sp999_${i}_10-100.json

## summary from HPC
### ------------test
calendula Slurm Job_id=492046 Name=sm4_simul_sim005-test Ended, Run time 00:17:10, COMPLETED, ExitCode 0
7/11/20 15:47
#------------
Job ID: 492046
Cluster: calendula
User/Group: uva_iufor_1_3/uva_iufor_1
State: COMPLETED (exit code 0)
Cores: 1
CPU Utilized: 00:16:20
CPU Efficiency: 95.15% of 00:17:10 core-walltime
Job Wall-clock time: 00:17:10
Memory Utilized: 436.59 MB
Memory Efficiency: 22.55% of 1.89 GB

### ------------complete
calendula Slurm Array Summary Job_id=492138_* (492138) Name=sm4_simul_sim005 Ended, COMPLETED, ExitCode [0-0]
8/11/20 10:08
#------------
Job ID: 492138
Array Job ID: 492138_40
Cluster: calendula
User/Group: uva_iufor_1_3/uva_iufor_1
State: COMPLETED (exit code 0)
Cores: 1
CPU Utilized: 00:19:52
CPU Efficiency: 90.23% of 00:22:01 core-walltime
Job Wall-clock time: 00:22:01
Memory Utilized: 434.76 MB
Memory Efficiency: 22.46% of 1.89 GB

#------------






# sim006
## description
400 plots, 8 array = 8 input files, 50 ppf, 100 tpp

## make folders and run other scripts
command in HPC: 
          ----> ~/scripts/sim006.sh
this script run everything but the array jobs
## make scenario files
command in HPC: 
put files in $SCRACH/sim003/scenario from template.json
### put 8 files in  $SCRACH/sim006/scenario
### filename: scnr_sp999_${i}_50-100.json
### each file change input and output files (with _idnumber_ from 1 to 8): 
#### "output_path": "$SCRACH/sim006/out__idnumber__50-100",
#### "input": "$SCRACH/sim006/input.en__idnumber_.50.100sp999.xlsx"
scenario files run tweenty growth periods, 5 years each and perform a thinning after ten growths

## make input files
8 files with 50 plot each, 100 trees per plot 
folder: $SCRACH/sim006/
command in HPC: 
          ----> sbatch ~/scripts/sim006.make.input.hpc.sh 8 50 100
which do 8 call to R-script PlotsGenerator.R

## make simulations
### test
command in HPC: 
          ----> sbatch ~/scripts/sim006.job.test.sh 
which do 1 job for 1 scenario files: scnr_sp999_1_50-100.json
### complete
command in HPC: 
          ----> sbatch ~/scripts/sim003.JobArray_100-100.sh 
which do 8 array jobs for 4 scenario files: scnr_sp999_${i}_100-100.json

## summary from HPC
### ------------test
calendula Slurm Job_id=492181 Name=sm4_simul_sim006-test Ended, Run time 04:37:08, COMPLETED, ExitCode 0
8/11/20 14:53
#------------
Job ID: 492181
Cluster: calendula
User/Group: uva_iufor_1_3/uva_iufor_1
State: COMPLETED (exit code 0)
Cores: 1
CPU Utilized: 04:36:50
CPU Efficiency: 99.89% of 04:37:08 core-walltime
Job Wall-clock time: 04:37:08
Memory Utilized: 1.41 GB
Memory Efficiency: 74.39% of 1.89 GB


#------------

#------------






# sim007***********************************************************
## description
400 plots, 16 array = 16 input files, 25 ppf, 100 tpp

## make folders and run other scripts
command in HPC: 
          ----> ~/scripts/sim007.sh
this script run everything but the array jobs
## make scenario files
command in HPC: include in sim005.sh
put files in $SCRACH/sim003/scenario from template.json
### put 4 files in  $SCRACH/sim003/scenario
### filename: scnr_sp999_${i}_10-100.json
### each file change input and output files (with _idnumber_ from 1 to 4): 
#### "output_path": "$SCRACH/sim003/out__idnumber__20-100",
#### "input": "$SCRACH/sim003/input.en__idnumber_.100.100sp999.xlsx"
scenario files run tweenty growth periods, 5 years each and perform a thinning after ten growths

## make input files
40 files with 10 plot each, 100 trees per plot 
folder: $SCRACH/sim005/
command in HPC: 
          ----> sbatch ~/scripts/sim005.make.input.hpc.sh 4 100 100
which do 40 call to R-script PlotsGenerator.R

## make simulations
command in HPC: 
          ----> sbatch ~/scripts/sim003.JobArray_100-100.sh 
which do 4 array jobs for 4 scenario files: scnr_sp999_${i}_100-100.json

## summary from HPC
#------------

#------------

#------------

#------------

