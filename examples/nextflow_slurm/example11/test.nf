//-- ? Process template great for not partitioned jobs

import groovy.yaml.YamlSlurper


process proc_minimization{
    // debug true
    label 'decent_gpu' //-- * This makes it use enough_cpi directive from nextflow.config
    tag "amber minimization"

    //-- * This copies the outputs of the computations to the directory
    publishDir "${params.output_folder}/${minim_vals.id}/1_minimization", mode: 'copy', overwrite: true
   

    conda "/home/${params.cluster_user}/a/conda_envs/lib_grab"


    input:
        val(minim_vals)


    output:
       path("minimized.nc") //-- ? Copy only files don't copy directories
       path("mdout*")

    //-- TODO not good enough for job wise it does in the folder
    script:
    """
    echo ${minim_vals.id}
    pmemd.cuda -O -i ${params.project_folder}/1_minimization/min.in \
        -p ${minim_vals.param} \
        -c ${minim_vals.coord} \
        -ref ${minim_vals.coord} \
        -r minimized.nc -o mdout
    """
}



process proc_heating{
    // debug true
    label 'decent_gpu' //-- * This makes it use enough_cpi directive from nextflow.config
    tag "amber heating"

    //-- * This copies the outputs of the computations to the directory
    publishDir "${params.output_folder}/${minim_vals.id}/2_heating", mode: 'copy', overwrite: true
   

    conda "/home/${params.cluster_user}/a/conda_envs/lib_grab"


    input:
        val(proj_vals)
        path(minimized_nc)


    output:
       path("heated.nc") //-- ? Copy only files don't copy directories
       path("heat_mdout")

    //-- TODO not good enough for job wise it does in the folder
    script:
    """
    echo ${proj_vals.id}
    pmemd.cuda -O -i ${params.project_folder}/2_heating/heat.in \
        -p ${proj_vals.param} \
        -c ${minimized_nc} \
        -ref ${proj_vals.coord} \
        -r heated.nc -o heat_mdout
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


    //-- * Stage 1: Minimization
    minimization_task = proc_minimization(projects)

    //-- * Stage 2: Heating
    heat_task = proc_heat(projects, minimization_task[0])

}
