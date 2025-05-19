#!/bin/bash
#SBATCH -J HCP_Schaef_PC			#job's name in slurm system
#SBATCH -o /Path/to/slurm_logs/%x_ID-%A_task-%a.out 	#%x=job name  %A=slurm job id (assigned on subission) %a=task index (assigned on submission) 
#SBATCH -e /Path/to/slurm_logs/%x_ID-%A_task-%a.err
#SBATCH --nodes=1
#SBATCH -w cluster-node1

## Load the relevant modules needed for the job
module load matlab/R2023b

#Specify job steps to run 
srun matlab -batch "analyze_atlases_over_tesla_HCPSchaef"

