# Purpose

This example demonstrates how to use Nextflow and Slurm to run Neofetch and nvidia-smi using Singularity container and use 1 GPU for the task.

Output files are stored in:  cd /home/$USER/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example6_out
In the output section you should see:

```
"gpu" section is not null anymore
```


# Before launching


**Note:** Replace `sds196` with your actual project name in the following line of the env-slurm.sb script:
```bash
#SBATCH -A sds196

1. Replace sds196 in partition in nextflow.config with the appropriate value for your  access configuration.
2. Replace params.cluster_user with your specific user value.

```

# Convert Gromacs image to Singularity

```

# On your local machine
mkdir ~/a/c_images
cd ~/a/c_images
mkdir -p /tmp/$USER

export SINGULARITY_TMPDIR=/tmp/$USER
env | grep TMP
singularity build --force gromacs_2023_2.sif  docker://nvcr.io/hpc/gromacs:2023.2


# Test if sif image works 
singularity shell gromacs_2023_2.sif

# Test if sif image works for GPU
singularity shell --nv gromacs_2023_2.sif



# Copy sif image to SDSC Expanse
mkdir -p ~/a/c_images
scp sdsc_expanse.sif  <username>@login.expanse.sdsc.edu:/home/<username>/a/c_images



# Test on SDSC expanse
module purge
module load singularitypro/3.11
singularity shell sdsc_expanse.sif
```



## How to launch 

```
# Checking your environment on HPC node:

[1] Load module file(s) into the shell environment
module purge
module load cpu/0.15.4
module load gpu/0.15.4
module load slurm
module load anaconda3/2020.11
module load singularitypro/3.11
eval "$(conda shell.bash hook)"


[2] Run:

eval "$(conda shell.bash hook)"
conda activate /home/$USER/a/conda_envs/nextflow
sbatch apptainer_neofetch_example.sb

[3] Check the status of your job:

squeue --me

[4] Read output from the folder


```
