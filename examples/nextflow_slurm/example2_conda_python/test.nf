//-- ? Process template great for not partitioned jobs
process python_conda_example{
    label 'very_low_cpu' //-- * This makes it use low_cpu directive from nextflow.config
    tag "test job python hoho"

    //-- * This copies the outputs of the computations to the directory
    publishDir "/home/${params.cluster_user}/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example2_out", mode: 'copy', overwrite: true
   

    conda "/home/${params.cluster_user}/a/conda_envs/lib_grab"

    input:
        val(test)


    output:
        path "${test}_python_out.log"


    script:
    """
    python /home/${params.cluster_user}/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example2_conda_python/get_info.py --output ${test}_python_out.log
    """
}


workflow {

    println " Info> Script directory path: ${projectDir}"
    println " Info> Launch directory path: ${launchDir}"

    values = Channel.of([1..200])
    todo_vals = values.flatten()
    // todo_vals.view()

    tobe_done = python_conda_example(todo_vals)
    tobe_done.view()
}