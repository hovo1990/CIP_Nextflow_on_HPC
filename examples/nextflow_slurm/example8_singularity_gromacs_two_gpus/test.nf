//-- ? Process template great for not partitioned jobs
process proc_two_grompp{
    label 'decent_gpu' //-- * This makes it use low_cpu_gpu directive from nextflow.config
    tag "grompp prep"

    //-- * This copies the outputs of the computations to the directory
    publishDir "${params.output_folder}/grompp/${gmx_proj.simpleName}", mode: 'copy', overwrite: true
   

    container = "/home/${params.cluster_user}/a/c_images/gromacs_2018.2.sif"
    containerOptions = "--nv --bind /home/\$USER:/home/\$USER:rw,/scratch:/scratch:rw"



    input:
        val(gmx_proj)


    output:
       tuple val("${gmx_proj.simpleName}"), file("*.*") //-- ? Copy only files don't copy directories


    script:
    """
    cp -a ${gmx_proj}/* .
    gmx grompp -f pme.mdp
    """
}



process proc_two_mdrun{
    label 'powerful_gpus' //-- * This makes it use low_cpu_gpu directive from nextflow.config
    tag "grompp mdrun"

    //-- * This copies the outputs of the computations to the directory
    publishDir "${params.output_folder}/mdrun/${gmx_proj_name}", mode: 'copy', overwrite: true
   

    container = "/home/${params.cluster_user}/a/c_images/gromacs_2018.2.sif"
    containerOptions = "--nv --bind /home/\$USER:/home/\$USER:rw,/scratch:/scratch:rw"



    input:
        tuple val(gmx_proj_name), file(files_to_use)


    output:
        path("*.*") //-- ? Copy only files don't copy directories


    script:
    """
    gmx mdrun  -nb gpu -pin on -v -noconfout -nsteps 30000 -s topol.tpr -gpu_id 01
    """
}







workflow {

    println " Info> Script directory path: ${projectDir}"
    println " Info> Launch directory path: ${launchDir}"

    //-- ? Input folders for Gromacs
    gmx_projs  = Channel.fromPath(params.project_folders, checkIfExists: true )
    gmx_projs_todo = gmx_projs.flatten()
    // gmx_projs_todo.view()

    //-- * Stage 1: grompp
    gmx_grompp = proc_two_grompp(gmx_projs_todo)
    // gmx_grompp.view()

    //-- * Stage 2: prep for running MD
    testOut = gmx_grompp.map{ pair ->
        [pair[0], pair[1]]
    }
    testOut.view()

    //-- * Stage 3: run mdrun in parallel for two projects
    gmx_mdrun = proc_two_mdrun(testOut)
    gmx_mdrun.view()


}