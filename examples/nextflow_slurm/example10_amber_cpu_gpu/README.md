# Purpose

This example demonstrates how to run Amber MD using Nextflow on HPC (CPU Version).

Inspired by and adapted from:  https://computecanada.github.io/molmodsim-amber-md-lesson/ 

Output files are stored in:  cd /home/$USER/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example10_out


# Before launching


**Note:** Replace `sds196` with your actual project name in the following line of the env-slurm.sb script:
```bash
#SBATCH -A sds196

1. Replace sds196 in partition in nextflow.config with the appropriate value for your  access configuration.
2. Replace params.cluster_user with your specific user value.
3. Replace in config.yml so it matches your folder structure

```


# prep on SDSC expanse login node
```
mkdir -p ~/a/demos/amber
cd ~/a/demos/amber
wget https://github.com/ComputeCanada/molmodsim-amber-md-lesson/releases/download/workshop-2021-04/workshop_amber_2024.tar.gz
tar xzvf workshop_amber_2024.tar.gz


wget https://github.com/ComputeCanada/molmodsim-amber-md-lesson/releases/download/workshop-2021-04/workshop_2023a.tar.gz
tar xzvf workshop_2023a.tar.gz

```


## How to launch 

```
# Checking your environment on HPC node:

[1] Load module file(s) into the shell environment
module purge --force
module load cpu/0.15.4
module load gpu/0.15.4
module load slurm
module load  openmpi/4.0.4
module load amber/20
module load anaconda3/2020.11
eval "$(conda shell.bash hook)"


# Create conda environment lib_grab so nextflow can use it

mkdir /home/$USER/.conda
mkdir -p /tmp/$USER/conda_pkgs
ln -s /tmp/$USER/conda_pkgs /home/$USER/.conda/pkgs


conda create -p /home/$USER/a/conda_envs/lib_grab python=3.10  -y 
conda activate /home/$USER/a/conda_envs/lib_grab
pip install seaborn pandas matplotlib scipy numpy scikit-learn  loguru psutil gputil py-cpuinfo click



[1] Update yml config file for the inputs
envsubst < template.yml > config.yml

envsubst < template_amber.yml > inputs.yml


[2] Run:

conda activate /home/$USER/a/conda_envs/nextflow
sbatch nextflow_amber_gpu.sb

[3] Check the status of your job:

squeue --me

[4] Read output from the folder


```
