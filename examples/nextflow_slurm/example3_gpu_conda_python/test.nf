//-- ? Process template great for not partitioned jobs
process python_gpu_process{
    label 'very_low_gpu' //-- * This makes it use low_cpu directive from nextflow.config
    tag "python_gpu_conda"

    //-- * This copies the outputs of the computations to the directory
    publishDir "/expanse/lustre/projects/${params.project}/${params.cluster_user}/CIP_examples/example3_out/", mode: 'copy', overwrite: true
   

    conda "/home/${params.cluster_user}/a/conda_envs/lib_grab"

    input:
        val(test)


    output:
        path "${test}_python_gpu_out.log"


    script:
    """
    python /home/${params.cluster_user}/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example3_gpu_conda_python/get_info.py --output ${test}_python_gpu_out.log
    """
}


workflow {

    println " Info> Script directory path: ${projectDir}"
    println " Info> Launch directory path: ${launchDir}"

    values = Channel.of([1..50])
    todo_vals = values.flatten()
    // todo_vals.view()

    tobe_done = python_gpu_process(todo_vals)
    tobe_done.view()
}