//-- ? Process template great for not partitioned jobs
process proc_makeblastdb{
    label 'low_cpu' //-- * This makes it use low_cpu_gpu directive from nextflow.config
    tag "prep makeblastdb"

    //-- * This copies the outputs of the computations to the directory
    publishDir "${params.output_folder}/makeblastdb/${faa_file.simpleName}", mode: 'copy', overwrite: true
   

    container = "/home/${params.cluster_user}/a/c_images/blast_2.9.0--pl526h3066fca_4.sif"
    containerOptions = "--nv --bind /home/\$USER:/home/\$USER:rw,/scratch:/scratch:rw"



    input:
        val(faa_file)


    output:
       tuple val("${faa_file.simpleName}"), file("*.*") //-- ? Copy only files don't copy directories

    //-- TODO not good enough for job wise it does in the folder
    script:
    """
    cp ${faa_file} .
    makeblastdb -in ${faa_file} -dbtype prot
    """
}



process proc_blast{
    label 'average_cpu' //-- * This makes it use low_cpu_gpu directive from nextflow.config
    tag "grompp mdrun"

    //-- * This copies the outputs of the computations to the directory
    publishDir "${params.output_folder}/blast/${faa_proj_filename}", mode: 'copy', overwrite: true
   

    container = "/home/${params.cluster_user}/a/c_images/blast_2.9.0--pl526h3066fca_4.sif"
    containerOptions = "--nv --bind /home/\$USER:/home/\$USER:rw,/scratch:/scratch:rw"



    input:
        tuple val(faa_proj_filename), file(files_to_use)


    output:
        path("*.*") //-- ? Copy only files don't copy directories


    script:
    """
    blastp -query P04156.fasta -db $TUTO/demos/blast_db/zebrafish.1.protein.faa -out results.txt
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
    updated_db.view()
}