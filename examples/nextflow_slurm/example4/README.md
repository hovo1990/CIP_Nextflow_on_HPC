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


# Preparation on local machine

```

# Install apptainer on your machine if not available
## Official guide, install suid version for fakeroot functionality
https://apptainer.org/docs/admin/main/installation.html#install-from-pre-built-packages




# Build apptainer/singularity image from docker
mkdir -p /tmp/apptainer
cd /tmp/apptainer
apptainer build --force sdsc_expanse.sif  docker://nvcr.io/nvidia/cuda:11.7.1-cudnn8-devel-ubuntu20.04
apptainer build --sandbox sdsc_expanse/ sdsc_expanse.sif 
apptainer shell --fakeroot --writable sdsc_expanse/


# Install libraries inside the container shell
apt-get update \
  && apt-get install -y --no-install-recommends \
  libgl1 \
  firefox \
  pymol \
  bash  \
  gawk \
  neofetch \
  locate \
  ncdu \
  less \
  nano \
  && rm -rf /var/lib/apt/lists/*

apt-get update \
  && apt-get install -y --no-install-recommends \
  libtiff-dev \
  libjpeg-dev \
  libpng-dev \
  libglib2.0-0 \
  libxext6 \
  libsm6 \
  libxext-dev \
  libxrender1 \
  libzmq3-dev \
  libc6 \
  && rm -rf /var/lib/apt/lists/*


apt update && apt install python3-pip -y   && rm -rf /var/lib/apt/lists/*
pip install "pandas[performance]" toolz cytoolz click loguru fs  psutil gputil py-cpuinfo click
exit



# Build sif file image
singularity build --fakeroot sdsc_expanse_proc.sif sdsc_expanse/
sudo chown $USER sdsc_expanse_proc.sif


# Test if sif image works 
apptainer shell sdsc_expanse_proc.sif

# Test if sif image works for GPU
apptainer shell --nv sdsc_expanse_proc.sif



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
eval "$(conda shell.bash hook)"


# Create conda environment lib_grab so the python script

mkdir /home/$USER/.conda
mkdir -p /tmp/$USER/conda_pkgs
ln -s /tmp/$USER/conda_pkgs /home/$USER/.conda/pkgs


conda create -p /home/$USER/a/conda_envs/lib_grab python=3.10  -y 
conda activate /home/$USER/a/conda_envs/lib_grab
pip install loguru psutil gputil py-cpuinfo click





[2] Run:

eval "$(conda shell.bash hook)"
conda activate /home/$USER/a/conda_envs/nextflow
sbatch conda_nextflow_python_gpu.sb

[3] Check the status of your job:

squeue --me

[4] Read output from the folder


```