# Purpose
This example demonstrates how to use Nextflow and Slurm to run gromacs using Singularity container and use  2 GPUs for the task.

Inspired by: https://pawseysc.github.io/singularity-containers/33-gpu-gromacs/index.html 



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

EXPANSEPROJECT='YOUR_PROJECT_NAME_ON_EXPANSE'
sed -i "s|<<EXPANSEPROJECT>>|${EXPANSEPROJECT}|g" nextflow.config 


sed -i "s|<<EXPANSEPROJECT>>|${EXPANSEPROJECT}|g" config.yml 
sed -i "s|<<USER>>|${USER}|g" config.yml 


sed -i "s|<<EXPANSEPROJECT>>|${EXPANSEPROJECT}|g" nextflow_gromacs_optim.sb





[2] Run:

sbatch nextflow_gromacs_optim.sb

[3] Check the status of your job:

squeue --me

[4] Read output from the folder


```
