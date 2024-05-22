# How to install Nextflow on the cluster using Anaconda

1. Access to one of the login nodes of the cluster.
2. Look if anaconda is available on the cluster
    ```
    module spider anaconda3
    ```
3. if it is available, then we need to load the module. This is an example for SDSC Expanse.
    ```
    module purge
    module load cpu/0.15.4
    module load slurm
    module load anaconda3/2020.11

    eval "$(conda shell.bash hook)"


    ```
4. Setting up Conda on an HPC cluster can be challenging due to user folders typically being on a network share. To improve the speed of Conda environment generation, we make a few changes so it uses the tmp folder for downloading the packages and initial preparation.
    ```
    mkdir /home/$USER/.conda
    mkdir -p /tmp/$USER/conda_pkgs
    ln -s /tmp/$USER/conda_pkgs /home/$USER/.conda/pkgs


    mkdir -p ~/a/conda_envs
    conda create --prefix /home/$USER/a/conda_envs/nextflow python=3

    ```