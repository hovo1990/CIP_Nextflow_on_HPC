#!/bin/bash
#SBATCH --job-name="nf_blast"
#SBATCH --output="nf_blast.%j.%N.out"
#SBATCH --partition=shared
####SBATCH --partition=debug
#SBATCH --export=ALL
#SBATCH -t 05:00:00
#SBATCH -A sds196
#SBATCH --mem 2000M
#SBATCH --cpus-per-task=2
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1

##  Load module file(s) into the shell environment

module purge
module load cpu/0.15.4
module load gpu/0.15.4
module load slurm
module load anaconda3/2020.11
module load singularitypro/3.11
eval "$(conda shell.bash hook)"
##  just perform some basic unix commands

# Run python script
conda activate /home/$USER/a/conda_envs/nextflow
export NFX_OPTS="-Xms=512m -Xmx=4g"
nextflow -C ~/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example9/nextflow.config  \
    run -profile expanse ~/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example9/test.nf  \
    -params-file ~/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example9/config.yml  \
    -resume -with-singularity true \
    --outdir ~/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example9/example9_workdir
