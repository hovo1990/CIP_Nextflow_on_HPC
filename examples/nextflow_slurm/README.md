# Now let`s to redo example1 from basic_slurm into nextflow


# Begginer Level

## Example 1 

Very simple example

[How to run example](./example1/README.md)


## Example 2

A little more advanced, it shows how to run python code using conda from Nextflow using Slurm scheduler.

[How to run example](./example2/README.md)


## Example 3

A little more advanced, it shows how to run python code using conda from Nextflow using Slurm scheduler on GPU nodes.

[How to run example](./example3/README.md)

## Example 4

This will show how to run python code from Example 2 using Apptainer/Singularity Container on CPU nodes.

[How to run example](./example4/README.md)



## Example 5

This will show how to run python code from Example 3 using Apptainer/Singularity Container on GPU nodes.
It uses the same container from Example 4.

[How to run example](./example5/README.md)




## Example 6

This will show how to run neofetch from Apptainer/Singularity Container on GPU nodes.

[How to run example](./example6/README.md)



# Intermediate Level


## Example 7
This example will show how to run MD simulations using GROMACS container using  Apptainer/Singularity Container on GPU nodes.
Inspired by https://pawseysc.github.io/singularity-containers/33-gpu-gromacs/index.html


[How to run example](./example7/README.md)


## Example 8
This example will show how to run MD simulations using GROMACS container using  Apptainer/Singularity Container on GPU nodes, a more optimized version.
Inspired by https://pawseysc.github.io/singularity-containers/33-gpu-gromacs/index.html

TODO need to optimize nextflow.config and mdrun

[How to run example](./example8/README.md)




## Example 9

This example will show how to run blastp  using  Apptainer/Singularity Container on CPU nodes.
Inspired by https://pawseysc.github.io/singularity-containers/13-bio-example-host/index.html

[How to run example](./example9/README.md)


## Example 10 TODO 

MPI Error:
```
Command output:
  sim1
   MPI version of PMEMD must be used with 2 or more processors!

Command error:
  ps: /cm/shared/apps/spack/cpu/opt/spack/linux-centos8-zen/gcc-8.3.1/anaconda3-2020.11-da3i7hmt6bdqbmuzq6pyt7kbm47wyrjp/lib/libuuid.so.1: no version information available (required by /lib64/libblkid.so.1)
  --------------------------------------------------------------------------
  MPI_ABORT was invoked on rank 0 in communicator MPI_COMM_WORLD
  with errorcode 1.
  
  NOTE: invoking MPI_ABORT causes Open MPI to kill all MPI processes.
  You may or may not see output from other processes, depending on
  exactly when Open MPI kills them.
  --------------------------------------------------------------------------

Work dir:
  /home/hgrabski/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example10/work/28/a6f462f15488df1351834802802e9e
```

This example will show how to run Amber on  CPU nodes.
Inspired by https://ringo.ams.stonybrook.edu/index.php/AMBER_Tutorials

Better example: https://computecanada.github.io/molmodsim-amber-md-lesson/ 

[How to run example](./example10/README.md)




## Example 11


This example will show how to run Amber on  GPU nodes.
Inspired by https://ringo.ams.stonybrook.edu/index.php/AMBER_Tutorials

Better example: https://computecanada.github.io/molmodsim-amber-md-lesson/ 

[How to run example](./example11/README.md)



## Example 12 TODO


This example will  hyperparameter optimization of machine learning models with Nextflow on SDSC Expanse.
Inspired by: https://github.com/nextflow-io/hyperopt/blob/master/README.md

[How to run example](./example12/README.md)