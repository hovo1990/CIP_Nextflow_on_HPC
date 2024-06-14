# Purpose

This example demonstrates how to use Nextflow and Slurm to run a Python script within a Conda environment.
Output files are stored in:  cd /home/$USER/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example2_out

# Before launching


**Note:** Replace `sds196` with your actual project name in the following line of the env-slurm.sb script:
```bash
#SBATCH -A sds196

1. Replace sds196 in partition in nextflow.config with the appropriate value for your  access configuration.

```

## How to launch 

```
# Checking your environment on HPC node:

[1] Load module file(s) into the shell environment
module purge
module load cpu/0.15.4
module load slurm
module load anaconda3/2020.11
eval "$(conda shell.bash hook)"


# Create conda environment lib_grab so the python script

mkdir /home/$USER/.conda
mkdir -p /tmp/$USER/conda_pkgs
ln -s /tmp/$USER/conda_pkgs /home/$USER/.conda/pkgs


conda create -p /home/$USER/a/conda_envs/lib_grab python=3.10  -y 
conda activate /home/$USER/a/conda_envs/lib_grab
pip install seaborn pandas matplotlib scipy numpy scikit-learn  loguru psutil gputil py-cpuinfo click






[2] Run:

sbatch nextflow_conda_python.sb

[3] Check the status of your job:

squeue --me

[4] Read output from the folder


```
