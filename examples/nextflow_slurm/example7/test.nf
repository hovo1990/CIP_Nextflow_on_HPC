//-- ? Process template great for not partitioned jobs
process proc_grompp{
    label 'decent_gpu' //-- * This makes it use low_cpu_gpu directive from nextflow.config
    tag "grompp prep"

    //-- * This copies the outputs of the computations to the directory
    publishDir "${params.output_folder}", mode: 'copy', overwrite: true
   

    container = "/home/${params.cluster_user}/a/c_images/gromacs_2018.2.sif"
    containerOptions = "--nv --bind /home/\$USER:/home/\$USER:rw,/scratch:/scratch:rw"



    input:
        val(gmx_proj)


    output:
        path("*.*") //-- ? Copy only files don't copy directories


    script:
    """
    cp -a ${gmx_proj}/* .
    gmx grompp -f pme.mdp
    """
}


workflow {

    println " Info> Script directory path: ${projectDir}"
    println " Info> Launch directory path: ${launchDir}"

    //-- ? Input folders for Gromacs
    gmx_projs  = Channel.fromPath(params.project_folders, checkIfExists: true )
    gmx_projs_todo = gmx_projs.flatten()
    gmx_projs_todo.view()

    //-- * Stage 1: grompp
    // gmx_grompp = proc_grompp(gmx_projs_todo)

}