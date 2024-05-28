//-- ? Process template great for not partitioned jobs
process python_stuff{
    label 'low_cpu' //-- * This makes it use low_cpu directive from nextflow.config
    tag "test job python hoho"

    //-- * This copies the outputs of the computations to the directory
    publishDir "/home/${params.cluster_user}/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example2_out", mode: 'copy', overwrite: true
   

    conda '/home/${params.cluster_user}/a/conda_envs/lib_grab'

    input:
        val(test)


    output:
        path "${test}_test_out.log"


    script:
    """
    python /home/hgrabski/sdsc-training/Slurm/example7_conda_python/get_info.py --output ${test}_test_out.log
    """
}


workflow {

    println " Info> Script directory path: ${projectDir}"
    println " Info> Launch directory path: ${launchDir}"

    values = Channel.of(['yolo','apricot','apple','valve','steamdeck','switch','ps4','ps5','xbox'])
    todo_vals = values.flatten()

    tobe_done = python_stuff(todo_vals)
    tobe_done.view()
}