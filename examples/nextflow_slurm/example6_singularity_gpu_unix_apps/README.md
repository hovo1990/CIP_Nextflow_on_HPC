# Purpose

This example demonstrates how to use Nextflow and Slurm to run Neofetch and nvidia-smi using Singularity container and use 1 GPU for the task.




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


[1] Run:


EXPANSEPROJECT='YOUR_PROJECT_NAME_ON_EXPANSE'
sed -i "s|<<EXPANSEPROJECT>>|${EXPANSEPROJECT}|g" nextflow.config 
sed -i "s|<<EXPANSEPROJECT>>|${EXPANSEPROJECT}|g" apptainer_neofetch_example.sb
sbatch apptainer_neofetch_example.sb

[2] Check the status of your job:

squeue --me

[3] Read output from the folder
cat singularity_gpu_fancy_out_*.log

```
