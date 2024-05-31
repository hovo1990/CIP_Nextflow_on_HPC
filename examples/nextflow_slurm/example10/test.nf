//-- ? Process template great for not partitioned jobs

import groovy.yaml.YamlSlurper


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

    //-- ? How to parse from yaml
    //-- ? https://stackoverflow.com/questions/77078419/nextflow-how-to-pass-the-yaml-format-input-file-from-an-argument-to-channel-as


    inputs = new YamlSlurper().parse(file(params.inputs_list))
    Channel
        .fromList(inputs['projects'])
        .ifEmpty { ['id':params.id, 'param': params.param, 'coord': params.coord] }
        .set { projects }

    projects.view()

}
