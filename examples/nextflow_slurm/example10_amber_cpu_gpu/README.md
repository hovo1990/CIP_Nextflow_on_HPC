# Purpose

This example demonstrates how to run Amber MD using Nextflow on HPC (CPU Version).

Inspired by and adapted from:  https://computecanada.github.io/molmodsim-amber-md-lesson/ 



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

EXPANSEPROJECT='YOUR_PROJECT_NAME_ON_EXPANSE'
sed -i "s|<<EXPANSEPROJECT>>|${EXPANSEPROJECT}|g" nextflow.config 


sed -i "s|<<EXPANSEPROJECT>>|${EXPANSEPROJECT}|g" config.yml 
sed -i "s|<<USER>>|${USER}|g" config.yml 

sed -i "s|<<USER>>|${USER}|g" inputs.yml


sed -i "s|<<EXPANSEPROJECT>>|${EXPANSEPROJECT}|g" nextflow_amber_gpu.sb



[2] Run:
sbatch nextflow_amber_gpu.sb

[3] Check the status of your job:

squeue --me

[4] Read output from the folder


```
