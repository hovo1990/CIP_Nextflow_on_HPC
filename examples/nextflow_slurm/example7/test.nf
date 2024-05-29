//-- ? Process template great for not partitioned jobs
process apptainer_gpu_fancy{
    label 'low_cpu_gpu' //-- * This makes it use low_cpu_gpu directive from nextflow.config
    tag "apptainer fancy hoho"

    //-- * This copies the outputs of the computations to the directory
    publishDir "/home/${params.cluster_user}/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example6_out", mode: 'copy', overwrite: true
   

    container = "/home/${params.cluster_user}/a/c_images/sdsc_expanse.sif"
    containerOptions = "--nv --bind /home/\$USER:/home/\$USER:rw,/scratch:/scratch:rw"



    input:
        val(test)


    output:
        path "${test}_singularity_gpu_fancy_out.log"


    script:
    """
    neofetch > ${test}_singularity_gpu_fancy_out.log
    nvidia-smi >> ${test}_singularity_gpu_fancy_out.log
    """
}


workflow {

    println " Info> Script directory path: ${projectDir}"
    println " Info> Launch directory path: ${launchDir}"

    values = Channel.of(['yolo','apricot','apple','valve','steamdeck','switch','ps4','ps5','xbox'])
    todo_vals = values.flatten()

    tobe_done = apptainer_gpu_fancy(todo_vals)
    tobe_done.view()
}