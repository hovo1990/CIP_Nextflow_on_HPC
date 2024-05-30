//-- ? Process template great for not partitioned jobs
process proc_makeblastdb{
    label 'low_cpu' //-- * This makes it use low_cpu_gpu directive from nextflow.config
    tag "prep makeblastdb"

    //-- * This copies the outputs of the computations to the directory
    publishDir "${params.output_folder}/makeblastdb/${faa_file.simpleName}", mode: 'copy', overwrite: true
   

    container = "/home/${params.cluster_user}/a/c_images/gromacs_2018.2.sif"
    containerOptions = "--nv --bind /home/\$USER:/home/\$USER:rw,/scratch:/scratch:rw"



    input:
        path(faa_file)


    output:
       tuple val("${faa_file.simpleName}"), file("*.*") //-- ? Copy only files don't copy directories


    script:
    """
    makeblastdb -in ${faa_file} -dbtype prot
    """
}



process proc_mdrun{
    label 'decent_gpu' //-- * This makes it use low_cpu_gpu directive from nextflow.config
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
    gmx mdrun -ntmpi 1 -nb gpu -pin on -v -noconfout -nsteps 30000 -s topol.tpr -ntomp 1
    """
}







workflow {

    println " Info> Script directory path: ${projectDir}"
    println " Info> Launch directory path: ${launchDir}"

    //-- ? Input folders for Gromacs
    faa_inputs  = Channel.fromPath(params.blast_db, checkIfExists: true )
    faa_inputs_todo = faa_inputs.flatten()
    // gmx_projs_todo.view()

    blast_input = Channel.fromPath(params.blast_input, checkIfExists: true )
    blast_input.view()


}