# Purpose

This example demonstrates how to use Nextflow and Slurm to run a Python script within a Conda environment and use 1 GPU for the task.

Output files are stored in:  cd /home/$USER/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example3_out
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


# Preparation on local machine (Laptop/PC)

```

# Install docker and  apptainer/singularity on your machine if not available
## Official guide, install suid version for fakeroot functionality
https://apptainer.org/docs/admin/main/installation.html#install-from-pre-built-packages






# Prepare docker container

DOCKER_BUILDKIT=1 docker build -t sdsc/expanse-test:latest . 
docker images

# find image IMAGE ID of   sdsc/expanse-test:latest so it can be saved to tar file
docker save 4bf558e9904c -o sdsc-expanse.tar 



singularity build --force sdsc_expanse.sif  docker-archive://sdsc-expanse.tar


# Test if sif image works 
singularity shell sdsc_expanse.sif

# Test if sif image works for GPU
singularity shell --nv sdsc_expanse.sif



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
sbatch apptainer_example.sb

[3] Check the status of your job:

squeue --me

[4] Read output from the folder


```
