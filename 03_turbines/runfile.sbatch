#!/bin/bash
#SBATCH --nodes=2
#SBATCH --account=atom
#SBATCH --output=logs/job_output_filename.%j.out  # %j will be replaced with the job ID
#SBATCH --partition=debug
#SBATCH --time=00:59:00
# #SBATCH --partition=short
# #SBATCH --time=03:59:00
# #SBATCH --partition=standard
# #SBATCH --time=47:59:00


export SPACK_MANAGER=${HOME}/spack-manager; source ${HOME}/spack-manager/start.sh; spack-start; module swap PrgEnv-cray PrgEnv-intel
quick-activate ${SPACK_MANAGER}/environments/atom
spack load amr-wind@main

srun -n 72 amr_wind turbine.i
