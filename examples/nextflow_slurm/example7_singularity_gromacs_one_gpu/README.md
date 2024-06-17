# Purpose

This example demonstrates how to use Nextflow and Slurm to run gromacs using Singularity container and use 1 GPU for the task.

Inspired by: https://pawseysc.github.io/singularity-containers/33-gpu-gromacs/index.html 

Output files are stored in:  cd /home/$USER/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example7_out


# Before launching


**Note:** Replace `sds196` with your actual project name in the following line of the env-slurm.sb script:
```bash
#SBATCH -A sds196

1. Replace sds196 in partition in nextflow.config with the appropriate value for your  access configuration.
2. Replace params.cluster_user with your specific user value.

```

# Convert Gromacs OCI image to Singularity

```

# On your local machine
mkdir ~/a/c_images
cd ~/a/c_images
mkdir -p /tmp/$USER

export SINGULARITY_TMPDIR=/tmp/$USER
env | grep TMP


# Pull image
singularity pull docker://nvcr.io/hpc/gromacs:2018.2


# Test if sif image works 
singularity shell gromacs_2018.2.sif

# Test if sif image works for GPU
singularity shell --nv gromacs_2018.2.sif


# Copy sif image to SDSC Expanse
mkdir -p ~/a/c_images
scp gromacs_2018.2.sif  <username>@login.expanse.sdsc.edu:/home/<username>/a/c_images


# Test on SDSC expanse
module purge
module load singularitypro/3.11
cd ~/a/c_images
singularity shell gromacs_2018.2.sif
```


# prep on SDSC expanse login node
```
mkdir -p ~/a/demos/gromacs
cd  ~/a/demos/gromacs
wget ftp://ftp.gromacs.org/pub/benchmarks/water_GMX50_bare.tar.gz
tar xzvf water_GMX50_bare.tar.gz

```


## How to launch 

```
[1] Update yml config file for the inputs
envsubst < template.yml > config.yml


[2] Run pipeline
sbatch nextflow_gromacs.sb

[3] Check the status of your job:

squeue --me

[4] Read output from the folder


```
