//-- ? Process template great for not partitioned jobs
process echo_stuff{
    label 'very_low_cpu' //-- * This makes it use low_cpu directive from nextflow.config
    tag "test job hoho"

    //-- * This copies the outputs of the computations to the directory
    publishDir "/home/${params.cluster_user}/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example1_out", mode: 'copy', overwrite: true
   

    input:
        val(test)


    output:
        path "task_${test}_out.log"


    script:
    """
    echo "hostname= " `hostname` >> task_${test}_out.log
    echo "date= " `date` >> task_${test}_out.log
    echo "whoami= " `whoami`  >> task_${test}_out.log
    echo "pwd= " `pwd` >> task_${test}_out.log
    """
}


workflow {

    println " Info> Script directory path: ${projectDir}"
    println " Info> Launch directory path: ${launchDir}"

    values = Channel.of([1..100])
    todo_vals = values.flatten()
    // todo_vals.view()

    tobe_done = echo_stuff(todo_vals)
    tobe_done.view()
}