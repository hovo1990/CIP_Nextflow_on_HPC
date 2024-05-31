//-- ? Process template great for not partitioned jobs
process proc_minimization{
    label 'enough_cpu' //-- * This makes it use enough_cpi directive from nextflow.config
    tag "amber minimization"

    //-- * This copies the outputs of the computations to the directory
    publishDir "${params.output_folder}/1_minimization/", mode: 'copy', overwrite: true
   

    conda "/home/${params.cluster_user}/a/conda_envs/lib_grab"


    input:
        val(faa_file)


    output:
       path("minimized.nc") //-- ? Copy only files don't copy directories
       path("mdout")

    //-- TODO not good enough for job wise it does in the folder
    script:
    """
    pmemd.MPI -O -i min.in \
        -p ../1RGG_chain_A.parm7 \
        -c ../1RGG_chain_A.rst7 \
        -ref ../1RGG_chain_A.rst7 \
        -r minimized.nc -o mdout
    """
}








workflow {

    println " Info> Script directory path: ${projectDir}"
    println " Info> Launch directory path: ${launchDir}"

    //-- ? Input folders for Gromacs
    faa_inputs  = Channel.fromPath(params.blast_db, checkIfExists: true )
    faa_inputs_todo = faa_inputs.flatten()
    // faa_inputs_todo.view()

    blast_input = Channel.fromPath(params.blast_input, checkIfExists: true )
    // blast_input.view()


    //-- * Stage 1: makeblastdb
    updated_db = proc_makeblastdb(faa_inputs_todo)
    // updated_db.view()

    //-- * Stage 2: prepare input for submission
    final_input = blast_input.combine(updated_db)
    // final_input.view()

