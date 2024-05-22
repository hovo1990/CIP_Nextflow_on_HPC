//-- ? Process template great for not partitioned jobs
process echo_stuff{
    
    tag "test job hoho"

    publishDir "/home/hgrabski/sdsc-training/Slurm/example6_conda_better/test_output_next", mode: 'copy', overwrite: true
   

    input:
        val(test)


    output:
        path "${test}_out.log"


    script:
    """
    echo "hostname= " `hostname` >> ${test}_out.log
    echo "date= " `date` >> ${test}_out.log
    echo "whoami= " `whoami`  >> ${test}_out.log
    echo "pwd= " `pwd` >> ${test}_out.log
    """
}


workflow {

    println " Info> Script directory path: ${projectDir}"
    println " Info> Launch directory path: ${launchDir}"

    values = Channel.of(['yolo','apricot','apple','valve','steamdeck','switch','ps4','ps5','xbox'])
    todo_vals = values.flatten()

    tobe_done = echo_stuff(todo_vals)
    tobe_done.view()
}