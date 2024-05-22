# How to Install Nextflow on the Cluster Using Anaconda

1. **Access one of the login nodes of the cluster.**

2. **Check if Anaconda is available on the cluster:**
    ```bash
    module spider anaconda3
    ```

3. **If Anaconda is available, load the module. The following is an example for SDSC Expanse:**
    ```bash
    module purge
    module load cpu/0.15.4
    module load slurm
    module load anaconda3/2020.11
    eval "$(conda shell.bash hook)"
    ```

4. **Set up Conda on the HPC cluster:**
   - **Create necessary directories and symlink for Conda packages to improve the speed of environment generation:**
    ```bash
    mkdir /home/$USER/.conda
    mkdir -p /tmp/$USER/conda_pkgs
    ln -s /tmp/$USER/conda_pkgs /home/$USER/.conda/pkgs
    mkdir -p ~/a/conda_envs
    ```
   - **Create a Conda environment for Nextflow:**
    ```bash
    conda create --prefix /home/$USER/a/conda_envs/nextflow python=3 bioconda::nextflow -y
    ```

5. **Verify the Nextflow installation:**
    ```bash
    conda activate /home/$USER/a/conda_envs/nextflow
    nextflow -h
    nextflow -v
    ```

If no errors were encountered, Nextflow is installed correctly.